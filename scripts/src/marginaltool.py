#!/usr/bin/env python3

import argparse
import base64
import configparser
import json
import os
import pathlib
import subprocess
import sys
import urllib.parse

# use requests instead of urllib.request for keep-alive connection
import requests

def init(args):
    args.params = urllib.parse.parse_qs(args.url.query)
    args.access_token = args.params["accessToken"][0]
    args.start_token = args.params["startSigningToken"][0]
    args.url = args.params['baseUrl'][0]

    # if missing, get options from section [url] in config
    config = configparser.ConfigParser()
    config.read(os.path.expanduser('~') + '/.marginaltool')
    if not args.engine:
        args.engine = config.get(args.url, 'engine', fallback='file')

    match args.engine:
        case 'file':
            if not args.keyfile:
                args.keyfile = config.get(args.url, 'keyfile')
            if not args.certfile:
                args.certfile = config.get(args.url, 'certfile')
            if not args.keyfile or not args.certfile:
                raise Exception('key or certificate file not specified')
            args.cert = ''.join(
                open(args.certfile).read()
                    .split('-----BEGIN CERTIFICATE-----', 1)[1]
                    .split('-----END CERTIFICATE-----', 1)[0])

        case 'pkcs11':
            if not args.id:
                args.id = config.get(args.url, 'id', fallback=None)
            if not args.id:
                raise Exception('key ID not specified')
            args.cert = base64.b64encode(subprocess.run(['pkcs11-tool', '--read-object', '--type', 'cert', '--id', args.id], capture_output=True).stdout).decode()

            # read the PIN once to avoid prompting for each document
            import tkinter.simpledialog # only needed for PIN entry
            args.pin = tkinter.simpledialog.askstring('marginaltool', 'PIN', show="*")

        case '_':
            raise Exception(f'invalid engine {args.engine}')

def sign(b64data, args):
    match args.engine:
        case 'file':
            if not args.keyfile:
                raise Exception('keyfile not specified')
            cmd = ['openssl', 'pkeyutl', '-sign', '-inkey', args.keyfile, '-pkeyopt', 'digest:sha256']
            env = None
            data = base64.b64decode(b64data)

        case 'pkcs11':
            if not args.id:
                raise Exception('key ID not specified')
            digest_info = { # from RFC 3447
                'MD2': '3020300c06082a864886f70d020205000410',
                'MD5': '3020300c06082a864886f70d020505000410',
                'SHA-1': '3021300906052b0e03021a05000414',
                'SHA-256': '3031300d060960864801650304020105000420',
                'SHA-384': '3041300d060960864801650304020205000430',
                'SHA-512': '3051300d060960864801650304020305000440'
            }
            cmd = ['pkcs11-tool', '--id', args.id, '-s', '-m', 'RSA-PKCS', '-p', 'env:PIN']
            env = {'PIN': args.pin}
            data = bytes.fromhex(digest_info['SHA-256']) + base64.b64decode(b64data)

        case '_':
            raise Exception(f'invalid engine {args.engine}')

    p = subprocess.run(cmd, env=env, input=data, capture_output=True)
    if p.returncode != 0:
        raise Exception(f'could not sign data: {p.stderr.decode()}')

    return base64.b64encode(p.stdout).decode()

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Fake the MargTools application.')
    parser.add_argument('url', type=urllib.parse.urlparse, help='bc-digsign:// url')
    parser.add_argument('-e', '--engine', choices=('file', 'pkcs11'), help='use key file or PKCS11 token?')
    parser.add_argument('-k', '--keyfile', type=pathlib.Path, help='key file')
    parser.add_argument('-c', '--certfile', type=pathlib.Path, help='certificate file')
    parser.add_argument('-i', '--id', type=int, metavar='<KEY ID>', help='key ID on PKCS11 token')
    args = parser.parse_args()

    try:
        # parse query string and load certificates
        init(args)

        session = requests.Session()
        headers = {'Authorization': f'Bearer {args.access_token}'}

        # delete old signing session
        r = session.delete(f'{args.url}/signatures/{args.params["startSigningToken"][0]}', headers=headers)

        # register a certificate or sign a document, makes no difference to us
        if args.params.get('registerCertificate'):
            q = {'registerCertificate': 1}
        else:
            q = {'documentId': [i for i in args.params['documentId'][0].split(',')]}
        qs = urllib.parse.urlencode(q, doseq=True)
        r = session.post(f'{args.url}/signatures?{qs}', headers=headers)

        # get signature request and mix in my secrets and publics
        request = json.loads(r.text)
        request['AuthenticationToken'] = args.access_token
        request['CertificatePublicKey'] = args.cert

        # keep signing whatever they send us
        while True:
            for name in ('AttachmentHashes', 'XmlHashes'):
                if values := request.get(name, []):
                    request[f'Signed{name}'] = [sign(v, args) for v in values]

            r = session.put(f'{args.url}signatures/{request["SignatureRequestId"]}',
                headers=headers | {'Content-Type': 'application/json; charset=utf-8'},
                data=json.dumps(request).encode())
            if not r.text:
                break
            request |= json.loads(r.text)

    except Exception as ex:
        print(f'error: {ex}', file=sys.stderr)
        input('press enter to exit') # don’t close terminal immediately on fail

