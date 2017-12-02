# -*- coding: utf-8 -*-

import os

def realdir(path):
    return os.path.split(os.path.realpath(path))[0]
