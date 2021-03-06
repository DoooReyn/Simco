#!/user/bin/python
# -*- coding: utf-8 -*-
###########################################
# @desc: a tool for hashing files
###########################################

import os
import hashlib
import common as helper

def get_assets_path():
    return './package/version/assets.lua'

def get_files_location():
    return [
        './package/Update/src/',
        './package/Update/res/'
    ]

def hash_one(filepath, filebase):
    filesize = os.path.getsize(filepath)
    with open(filepath, 'rb') as f:
        md5 = hashlib.md5()
        md5.update(f.read())
        filehash = md5.hexdigest()
    # print {'name': filebase, 'md5': filehash, 'size': filesize}
    return filebase, filehash, filesize


def write_assets_lua(assets_content):
    assets_filepath = os.path.abspath(get_assets_path())
    if helper.mkdirs(assets_filepath):
        with open(assets_filepath, 'wt') as f:
            f.write(assets_content)

        
def hash():
    try:
        hasharr = []
        hasharr.append('return {\n')
        for d in get_files_location():
            prefix = os.path.abspath(d) + '/'
            for root, dirs, files in os.walk(prefix):
                for f in files:
                    filepath = os.path.join(root, f)
                    filebase = os.path.abspath(filepath).replace(prefix, '')
                    hasharr.append("\t['%s'] = {\n\t\tmd5 = '%s',\n\t\tsize = %d\n\t},\n" % (hash_one(filepath, filebase)))
        hasharr.append('}\n')
        write_assets_lua(''.join(hasharr))
        print('[hash] OK')
        return True
    except:
        print('[hash] Fail')
        return False


if __name__ == '__main__':
    hash()
