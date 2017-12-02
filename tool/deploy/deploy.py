#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import sys
import common as helper
import compress_jpg as cjpg
import compress_png as cpng
import encrypt_src  as encrypt
import hash_file as hashtool

def deploy(platform):
    if cjpg.compress(cjpg.SOUR_DIR, 'Update'):
        if cpng.compress(cpng.SOUR_DIR, 'Update'):
            if encrypt.encrypt(platform):
                if hashtool.hash():
                    print('[deploy] Everything is OK!')

if __name__ == '__main__':
    import sys
    if len(sys.argv) == 1:
        print 'need target platform : android/ios32/ios64'
    else:
        deploy(sys.argv[1])
