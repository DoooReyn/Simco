#!/usr/bin/python
# -*- coding: utf-8 -*-
###########################################
# @desc: a tool for compressing jpg files
###########################################


import os
import common as helper

SOUR_DIR = '../../res/'

def jpegoptim(filepath, filebase, comtype):
    locate = './package/%s/res/%s' % (comtype, filebase)
    locdir = os.path.dirname(locate)
    helper.mkdirs(locate)
    os.system('jpegoptim -m50 -d %s %s -o' % (locdir, filepath))
    osize = helper.format_file_size(os.path.getsize(filepath))
    csize = helper.format_file_size(os.path.getsize(locate))
    # print('[compressing] %s(%s) >>> %s(%s)' % (filepath, osize, locate, csize))


def compress(dirpath, comtype):
    try:
        prefix = os.path.abspath(dirpath) + '/'
        for root, dirs, files in os.walk(dirpath):
            for f in files:
                ext = os.path.splitext(f)
                if len(ext) > 1 and ext[1] == '.jpg' or ext[1] == '.jpeg':
                    filepath = os.path.join(root, f)
                    filebase = os.path.abspath(filepath).replace(prefix, '')
                    jpegoptim(filepath, filebase, comtype)
        print('[compress jpg] OK')
        return True
    except:
        print('[compress jpg] Fail')
        return False


if __name__ == '__main__':
    compress(SOUR_DIR, 'Update')
