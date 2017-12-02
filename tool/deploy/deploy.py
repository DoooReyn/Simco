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
    # cjpg.compress()
    cpng.compress(cpng.SOUR_DIR, 'Update')
    encrypt.encrypt(platform)
    hashtool.hash()

if __name__ == '__main__':
    import sys
    if len(sys.argv) == 1:
        print 'need target platform : android/ios'
    else:
        platform = sys.argv[1]
        if platform == 'android' or  platform == 'ios':
            deploy(platform)
        else:
            print 'need target platform : android/ios'
