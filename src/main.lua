
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"

cc.setglobal = function(t)
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

local function main()
    require('app.app'):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
