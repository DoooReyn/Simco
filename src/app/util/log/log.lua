------------------------------------------------------------
-- 日志管理
--

local _M = {}

local __log__ = cc.FileUtils:getInstance():getWritablePath() .. 'log.txt'
print('[CGLOG] located at : ' .. __log__)
local __strfmt = string.format
local isdump = CGEnv:getenv('DUMP_LOG')
local issave = CGEnv:getenv('SAVE_LOG')

local function save(log)
    local f = io.open(__log__, 'a+')
    if not f then return end
    f:write(log)
    f:close()
end

function _M:console(fmt, ...)
    if not isdump and not issave then
        return
    end
    
    local s = fmt
    if select('#', ...) > 0 then
        s = __strfmt(fmt, ...)
    end
    s = '\n[CGLOG] (' .. os.date('%Y-%m-%d %H:%M:%S', os.time()) .. ') : \n' .. s
    if isdump then
        print(s)
    end
    if issave then
        save(s)
    end
end

cc.exports.CGLog = _M