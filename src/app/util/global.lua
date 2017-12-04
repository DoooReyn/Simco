-- sandbox
local sandbox = function(block)
    -- get the try function
    local try = block.try
    assert(try)
    print('[sandbox] try : ' .. tostring(try))

    --get catch and finnally functions
    local catch, finnally = block.catch, block.finnally

    -- try to call 'block.try'
    local ok, err = pcall(try)
    
    -- run the 'block.catch'
    if not ok and catch then
        print('[sandbox] catch error')
        catch(err)
        -- dump error message
        if block.dumpmsg then 
            print(err) 
        end
    end

    -- run the 'block.finnally'
    print('[sandbox] finnally : ' .. tostring(ok))
    if finnally then
        finnally(ok, err)
    end
    
    return ok
end

-- setglobal
local _g = {}
local setglobal = function(t)
    if type(t) ~= 'table' then
        return 
    end
    for _, v in ipairs(t) do
        local v1, v2 = v[1], v[2]
        if v1 and v2 and type(v1) == 'string' then
            print('register global data : ' .. v[1])
            cc.exports[v1] = v2
            table.insert(_g, v1)
        end
    end
end

local globals = function()
    dump(_g)
end

local trycatch = function(try, catch)
    return sandbox({
        try      = try,
        catch    = catch
    })
end

setglobal(
    {
        {"CGSetGlobal", setglobal},
        {"CGGlobals",   globals},
        {"CGSandBox",   sandbox},
        {"CGTryCatch",  trycatch},
    }
)