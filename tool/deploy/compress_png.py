#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import common as helper

SOUR_DIR = '../../res/'

def pngquant(filepath, filebase, comtype):
    locate = './package/%s/res/%s' % (comtype, filebase)
    helper.mkdirs(locate)
    os.system('pngquant --quality=85-90 --floyd=0.5 -o %s %s --force' % (locate, filepath))
    osize = helper.format_file_size(os.path.getsize(filepath))
    csize = helper.format_file_size(os.path.getsize(locate))
    print('[compressing] %s(%s) >>> %s(%s)' % (filepath, osize, locate, csize))
    
def compress(dirpath, comtype):
    prefix = os.path.abspath(dirpath) + '/'
    for root, dirs, files in os.walk(dirpath):
        for f in files:
            ext = os.path.splitext(f)
            if len(ext) > 1 and ext[1] == '.png':
                filepath = os.path.join(root, f)
                filebase = os.path.abspath(filepath).replace(prefix, '')
                pngquant(filepath, filebase, comtype)

if __name__ == '__main__':
    compress(SOUR_DIR, 'Update')
