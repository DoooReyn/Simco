#!/user/bin/python
# # -*- coding: utf-8 -*-

import os

SOURCE_DIR = '../../src/'
OUT_DIR = './package/Update/src/'

def encrypt_lua_file(src, out):
    cmd = "cocos luacompile -s %s -d %s -e -k reyn@simco@07171991@KEY -b !19917170!comis!nyer@SIGN" % (src, OUT_DIR)
    os.system(cmd)


if __name__ == '__main__':
    encrypt_lua_file(SOURCE_DIR, OUT_DIR)
