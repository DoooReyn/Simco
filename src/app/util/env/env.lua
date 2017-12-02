------------------------------------------------------------
-- 开发环境配置管理
--

----------------------------------------------
local _C = require('app.util.env.const')

local setenv = function(key, v)
    _C[_C.MODE][key] = val
end

local getenv = function(key)
    return _C[_C.MODE][key]
end

local setmode = function(mode)
    _C.MODE = mode
end

local getmode = function()
    return _C.MODE
end

local env = function(key)
    if key then
        if _C[_C.MODE][key] ~= nil then
            return _C[_C.MODE][key]
        end
        if _C.COMMON[key] ~= nil then
            return _C.COMMON[key]
        end
        return nil
    else
        local t = {}
        for k,v in pairs(_C.COMMON) do
            t[k] = v
        end
        for k,v in pairs(_C[_C.MODE]) do
            t[k] = v
        end
        return t
    end
end

----------------------------------------------

local _M = {}

function _M:getenv(key)
    return env(key)
end

function _M:setenv(key, val)
    if getenv(key) ~= nil then
        setenv(key, val)
    end
end

function _M:release(isrelease)
    setmode((not isrelease) and 'DEBUG' or 'RELEASE')
end

function _M:console()
    dump(env(), '[CG] Environment Data : ' .. _C.MODE)
end

function _M:load()
    self:console()
    cc.Director:getInstance():setDisplayStats(env('SHOW_FPS'))
    cc.Director:getInstance():setAnimationInterval(1.0 / env('FPS_RATE'))
end

return _M
------------------------------------------------------------