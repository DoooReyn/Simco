#!/user/bin/python
# -*- coding: utf-8 -*-
###########################################
# @desc: compile and encrypt lua files
###########################################

import os
import sys

SOURCE_DIR = '../../src/'
OUT_DIR = './package/Update/src/'
KEY  = 'reyn@simco@07171991@KEY'
SIGN = '!19917170!comis!nyer@SIGN'

def encrypt_lua_file_for_android(src, out, key, sign):
    cmd = "cocos luacompile -s %s -d %s -e -k %s -b %s" % (src, OUT_DIR, key, sign)
    os.system(cmd)


# --disable-compile
def encrypt_lua_file_for_ios32(src, out, key, sign):
    cmd = "cocos luacompile -s %s -d %s -e -k %s -b %s" % (
        src, OUT_DIR, key, sign)
    os.system(cmd)

def encrypt_lua_file_for_ios64(src, out, key, sign):
    cmd = "cocos luacompile -s %s -d %s -e -k %s -b %s --bytecode-64bit" % (
        src, OUT_DIR, key, sign)
    os.system(cmd)

def encrypt(platform):
    try:
        if platform == 'android':
            encrypt_lua_file_for_android(SOURCE_DIR, OUT_DIR, KEY, SIGN)
            print('[encrypt] OK')
        elif platform == 'ios32':
            encrypt_lua_file_for_ios32(SOURCE_DIR, OUT_DIR, KEY, SIGN)
            print('[encrypt] OK')
        elif platform == 'ios64':
            encrypt_lua_file_for_ios64(SOURCE_DIR, OUT_DIR, KEY, SIGN)
            print('[encrypt] OK')
        else:
            correct_platform()
            print('[encrypt] Fail')
            return False
        return True
    except:
        print('[encrypt] Fail')
        return False


def correct_platform():
    print '[encrypt] need correct target platform : android/ios32/ios64'

if __name__ == '__main__':
    if len(sys.argv) > 1  :
        encrypt(sys.argv[1])
    else:
        correct_platform()
