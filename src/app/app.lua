
-- local MyApp = class("MyApp", cc.load("mvc").AppBase)

-- function MyApp:onCreate()
--     math.randomseed(os.time())
-- end

-- return MyApp

------------------------------------------------------------
-- 游戏入口
--

local _M = class('App')

function _M:run()
    math.randomseed(os.time())
    cc.exports.CGEnv = require('app.util.env.env')
    cc.exports.CGLog = require('app.util.log.log')
    CGEnv:load()
    cc.exports.hotupdate = require('app.util.hotupdate.hotupdate').new()
    
    cc.exports.CGMainScene = cc.Scene:create()
    cc.Director:getInstance():runWithScene(CGMainScene)

    local sp = cc.Sprite:create('HelloWorld.png')
    if sp then
        sp:setPosition(display.center)
        sp:addTo(CGMainScene)
    end
end

return _M