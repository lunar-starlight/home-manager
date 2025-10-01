{ pkgs, ... }:
pkgs.writeShellScriptBin "getbib" ''
curl --resolve doi.org:443:104.26.8.237 -LH "Accept: text/bibliography; style=bibtex" "$1"
''
