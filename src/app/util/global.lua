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
    if finnally then
        print('[sandbox] finnally : ' .. tostring(ok))
        finnally(ok, err)
    end
    
    return ok
end

-- setglobal
local setglobal = function(t)
    if type(t) ~= 'table' then
        return 
    end
    for _, v in ipairs(t) do
        local v1, v2 = v[1], v[2]
        if v1 and v2 and type(v1) == 'string' then
            print('register global data : ' .. v[1])
            cc.exports[v1] = v2
        end
    end
end

setglobal(
    {
        {"CGSetGlobal",setglobal},
        {"CGSandBox",sandbox},
    }
)