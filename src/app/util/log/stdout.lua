------------------------------------------------------------
-- 标准输出
--
local __strfmt     = string.format
local __print      = print
local __dump       = dump
local __printLog   = printLog
local __printInfo  = printInfo
local __printError = printError
local __stdout     = CGEnv:getenv('DUMP_LOG')

cc.exports.print = function(...)
    if __stdout then
        __print(...)
    end
end

cc.exports.printf = function(fmt, ...)
    if __stdout then
        __print(__strfmt(fmt, ...))
    end
end

cc.exports.dump = function(t, d, n)
    if __stdout then
        __dump(t, d, m)
    end
end

cc.exports.printLog = function(tag, fmt, ...)
    if __stdout then
        __printLog(tag, fmt, ...)
    end    
end

cc.exports.printInfo = function(fmt, ...)
    if __stdout then
        __printInfo(fmt, ...)
    end
end

cc.exports.printError = function(fmt, ...)
    if __stdout then
        __printError(fmt, ...)
    end
end
