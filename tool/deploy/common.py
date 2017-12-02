# -*- coding: utf-8 -*-

import os

def realdir(path):
    return os.path.split(os.path.realpath(path))[0]


def mkdirs(filepath):
    if not os.path.exists(filepath):
        try:
            os.makedirs(os.path.dirname(filepath))
        except:
            pass


def format_file_size(size):
    size = int(size) * 1.0
    if size / 1024 < 1:
        return '%.1fB' % (size)
    elif size / 1024**2 < 1:
        return '%.1fK' % (size / 1024)
    elif size / 1024**3 < 1:
        return '%.1fM' % (size / 1024**2)
    else:
        return '%.1fG' % (size / 1024**3)

