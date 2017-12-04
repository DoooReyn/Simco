------------------------------------------------------------
-- 标准输出
--
local __strfmt     = string.format
local __print      = print
local __dump       = dump
local __printLog   = printLog
local __printInfo  = printInfo
local __printError = printError
local __stdout     = function() return CGEnv:getenv('DUMP_LOG') end

CGSetGlobal(
    {
        print = function(...)
            if __stdout() then
                __print(...)
            end
        end,
        printf = function(fmt, ...)
            if __stdout() then
                __print(__strfmt(fmt, ...))
            end
        end,
        dump = function(t, d, n)
            if __stdout() then
                __dump(t, d, m)
            end
        end,
        printLog = function(tag, fmt, ...)
            if __stdout() then
                __printLog(tag, fmt, ...)
            end    
        end,
        printInfo = function(fmt, ...)
            if __stdout() then
                __printInfo(fmt, ...)
            end
        end,
        printError = function(fmt, ...)
            if __stdout() then
                __printError(fmt, ...)
            end
        end
    }
)
