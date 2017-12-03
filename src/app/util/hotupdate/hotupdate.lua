------------------------------------------------------------
-- 热更新管理
-- 1. 热更
--  - 负责变动资源的更新与维护
-- 2. 分包
--  - 负责后续资源的下载
-- 3. 顺序
--  - 热更的搜索顺序高于分包高于本地，即：热更 > 分包 > 本地
--
------------------------------------------------------------

local cjson = require 'cjson'

local __strfmt      = string.format
local __fileutils   =  cc.FileUtils:getInstance()
local __storagePath =  __fileutils:getWritablePath()

-- update
local __baseUrl     =  'http://192.168.1.102/~reyn/'
local __updateSuf   =  'Update/'
local __updateUrl   =  __baseUrl .. __updateSuf
local __versionLN   =  'version.lua' 
local __projectLN   =  'assets.lua'
local __updatePath  =  __storagePath .. __updateSuf
local __versionURL  =  __updateUrl   .. __versionLN
local __projectURL  =  __updateUrl   .. __projectLN
local __versionRN   =  __updatePath  .. __versionLN
local __projectRN   =  __updatePath  .. __projectLN
local __locatetype  =  {'local', 'remote'}
local __downloader  =  require('app.util.network.download')

local __address = {
    ['local'] = {
        version = 'version/version.lua',
        assets  = 'version/assets.lua',
    },
    ['remote'] = {
        version = __baseUrl .. 'version/version.lua',
        assets  = __baseUrl .. 'version/assets.lua',
    },
    ['temp'] = {
        version = __updatePath .. 'version/version_temp.lua',
        assets  = __updatePath .. 'version/assets_temp.lua',
    }
}

-- extend
local __extendSuf   =  'Extend/'
local __extendUrl   =  __baseUrl .. __extendSuf
local __extendPath  =  __storagePath .. __extendSuf

------------------------------------------------------------

local _M = class('hotupdate')

function _M:ctor()
    self:checkSearchPath()
    self:checkUpdate()
end

-- 检查搜索路径
function _M:checkSearchPath()
    local pathes = {
        __updatePath,
        __extendPath,
        __updatePath .. 'res/',
        __updatePath .. 'src/',
        __extendPath .. 'res/',
        __extendPath .. 'src/',
    }
    for _, v in ipairs(pathes) do
        if not __fileutils:isDirectoryExist(v) then
            __fileutils:createDirectory(v)
        end
        __fileutils:addSearchPath(v)
    end
    __fileutils:addSearchPath('res/')
    __fileutils:addSearchPath('src/')
end

-- 检查版本更新
function _M:checkUpdate()
    __downloader.new(__versionURL, __versionTN, handler(self, self.checkVersion)):start()
end

-- 解析版本文件
function _M:parseVersion(filepath, locatetype)
    print(__strfmt('[hotupdate] ready to parse %s version manifest', locatetype))
    
    if not __fileutils:isFileExist(filepath) then
        print(__strfmt('[hotupdate] %s version manifest not found', locatetype))
        return 0
    end

    local realpath = __fileutils:fullPathForFilename(filepath)
    print(__strfmt('[hotupdate] %s version manifest located at %s', locatetype, realpath))
    
    local verstr = __fileutils:getStringFromFile(realpath)
    local json   = cjson.decode(verstr)
    if json then 
        return json.version or 0
    end
    return 0
end

-- 解析本地工程文件
function _M:parseProject(filepath, locatetype)
    print(__strfmt('[hotupdate] ready to parse %s project manifest', locatetype))
    
    if not __fileutils:isFileExist(filepath) then
        print(__strfmt('[hotupdate] %s project manifest not found', locatetype))
        return {}
    end

    local realpath = __fileutils:fullPathForFilename(filepath)
    print(__strfmt('[hotupdate] %s project manifest located at %s', locatetype, realpath))
    
    local prostr  = __fileutils:getStringFromFile(realpath)
    local json    = cjson.decode(prostr)
    if json then 
        return json.asset
    end
    return {}
end

-- 比对版本
function _M:checkVersion(code, filepath)
    if code < 0 or not __fileutils:isFileExist(filepath) then
        print('[hotupdate] remote version manifest not found')
        -- 发送检查更新失败事件
        return
    end
    
    self.local_version  = self:parseVersion(__versionLN, __locatetype[1])
    self.remote_version = self:parseVersion(__versionTN, __locatetype[2])
    
    if self.remote_version > self.local_version then
        __downloader.new(__projectRF, __projectRSF, handler(self, self.checkProject)):start()
    end
end

-- 比对资源
function _M:checkProject(code, filepath)
    if code < 0 then
        print('[hotupdate] remote project manifest not found')
        -- 发送检查更新失败事件
        return
    end
    
    self.local_project  = self:parseProject(__projectLN)
    self.remote_project = self:parseProject(__projectTN)

    local total_size, diff_files = self:diffProject()
end

-- 获取资源差异
function _M:diffProject()
    
end

-- 开始更新
function _M:startUpdate()

end

return _M
