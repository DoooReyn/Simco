#!/user/bin/python
# # -*- coding: utf-8 -*-

import os
import sys

SOURCE_DIR = '../../src/'
OUT_DIR = './package/Update/src/'
KEY  = 'reyn@simco@07171991@KEY'
SIGN = '!19917170!comis!nyer@SIGN'

def encrypt_lua_file_for_android(src, out, key, sign):
    cmd = "cocos luacompile -s %s -d %s -e -k %s -b %s" % (src, OUT_DIR, key, sign)
    os.system(cmd)

def encrypt_lua_file_for_ios(src, out, key, sign):
    cmd = "cocos luacompile -s %s -d %s -e -k %s -b %s --disable-compile" % (src, OUT_DIR, key, sign)
    os.system(cmd)

def encrypt(platform):
    if platform == 'android':
        encrypt_lua_file_for_android(SOURCE_DIR, OUT_DIR, KEY, SIGN)
    elif platform == 'ios':
        encrypt_lua_file_for_ios(SOURCE_DIR, OUT_DIR, KEY, SIGN)
    else:
        print 'need correct target platform : android/ios'

def correct_platform():
    print 'need correct target platform : android/ios'

if __name__ == '__main__':
    if len(sys.argv) > 1  :
        encrypt(sys.argv[1])
    else:
        correct_platform()
