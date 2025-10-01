#!/bin/python
import sys
import string

TESTING = False
XCOMPOSE_FILE_SRC = ("/tmp" if TESTING else "") + "/home/muf/.config/home-manager/dotfiles/XCompose-src"
XCOMPOSE_FILE_GEN = ("/tmp" if TESTING else "") + "/home/muf/.config/home-manager/dotfiles/XCompose"
l = False

class Trie:
    # https://github.com/bdimmick/python-trie
    def __init__(self):
        self.path = {}
        self.value = None
        self.value_valid = False

    def __setitem__(self, key, value):
        head = key[0]
        if head in self.path:
            node = self.path[head]
        else:
            node = Trie()
            self.path[head] = node

        if len(key) > 1:
            remains = key[1:]
            node.__setitem__(remains, value)
        else:
            node.value = value
            node.value_valid = True

    def __getitem__(self, key):
        head = key[0]
        if head in self.path:
            node = self.path[head]
        else:
            raise KeyError(key)
        if len(key) > 1:
            remains = key[1:]
            try:
                return node.__getitem__(remains)
            except KeyError:
                raise KeyError(key)
        elif node.value_valid:
            return node.value
        else:
            raise KeyError(key)

    def __contains__(self, key):
        try:
            self.__getitem__(key)
        except KeyError:
            return False
        return True

    def get(self, key, default=None):
        try:
            return self.__getitem__(key)
        except KeyError:
            return default

    def keys(self, prefix=[]):
        return self.__keys__(prefix)

    def __keys__(self, prefix=[], seen=[]):
        result = []
        if self.value_valid:
            isStr = True
            val = ""
            for k in seen:
                if type(k) != str or len(k) > 2:
                    isStr = False
                    break
                else:
                    val += k
            if isStr:
                result.append(val)
            else:
                result.append(prefix)
        if len(prefix) > 0:
            head = prefix[0]
            prefix = prefix[1:]
            if head in self.path:
                nextpaths = [head]
            else:
                nextpaths = []
        else:
            nextpaths = self.path.keys()
        for k in nextpaths:
            nextseen = []
            nextseen.extend(seen)
            nextseen.append(k)
            result.extend(self.path[k].__keys__(prefix, nextseen))
        return result

    def __add__(self, other):
        result = Trie()
        result += self
        result += other
        return result

    def __iadd__(self, other):
        for k in other:
            self[k] = other[k]
        return self

    def isPrefix(self, key):
        head = key[0]
        if head not in self.path:
            return False
        node = self.path[head]
        if len(key) > 1:
            return node.isPrefix(key[1:])
        return ' ' in node.path


def parse_sequence(s : str):
    k, v = s.split(' : ')
    k = ' '.join(k.split()[1:])
    return (k, v)


def make_trie():
    global l
    t = Trie()
    with open(XCOMPOSE_FILE_SRC, 'r') as f:
        # f.readline()  # include "%L"
        for line in f:
            if line == '\n': continue
            if line[0] == '#': continue
            if line == 'include "%L"\n':
                l = True
                continue
            if s := parse_sequence(line.replace('\n','')):
                k, v = s
                t[k] = v
    return t


def add_suffixes(t, key):
    for char in alphabet | extra:
        new_key = key + f' <{char}>'
        if new_key in t:
            continue

        t[new_key] = t[key].replace('"  #', f'{LUT[char]}"  #')
        if t.isPrefix(new_key):
            t = add_suffixes(t, new_key)
    return t

alphabet = set(string.ascii_letters + string.digits)
extra = {'space','underscore','slash','backslash'}
LUT = {k : k for k in alphabet} | {'space' : ' ', 'underscore' : '_', 'slash' : '/','backslash' : '\\\"#'}

t = make_trie()

for key in t.keys():
    if t.isPrefix(key):
       t = add_suffixes(t, key)

with open(XCOMPOSE_FILE_GEN, 'w') as f:
    if l: f.write('include "%L"\n')
    for key in sorted(t.keys()):
        f.write('<Multi_key> ' + key + ' : ' + t[key] + '\n')
