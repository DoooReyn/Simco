------------------------------------------------------------
-- 日志管理
--

local _M = {}

local __log__ = cc.FileUtils:getInstance():getWritablePath() .. 'log.txt'
print('[CGLOG] located at : ' .. __log__)

local function save(log)
    local f = io.open(__log__, 'a+')
    if not f then return end
    f:write(log)
    f:close()
end

function _M:console(fmt, ...)
    local isdump = CGEnv:getenv('DUMP_LOG')
    local issave = CGEnv:getenv('SAVE_LOG')
    if not isdump or not issave then
        return
    end
    
    local s = fmt
    if select('#', ...) > 0 then
        s = string.format(fmt, ...)
    end
    s = '\n[CGLOG] (' .. os.date('%Y-%m-%d %H:%M:%S', os.time()) .. ') : \n' .. s
    if isdump then
        print(s)
    end
    if issave then
        save(s)
    end
end


return _M