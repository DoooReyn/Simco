#!/user/bin/python
# # -*- coding: utf-8 -*-

import os

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


if __name__ == '__main__':
    import sys
    if len(sys.argv) == 1:
        print 'need target platform : android/ios'
    else:
        if sys.argv[1] == 'android':
            encrypt_lua_file_for_android(SOURCE_DIR, OUT_DIR, KEY, SIGN)
        elif sys.argv[1] == 'ios':
            encrypt_lua_file_for_ios(SOURCE_DIR, OUT_DIR, KEY, SIGN)
        else:
            print 'need target platform : android/ios'
