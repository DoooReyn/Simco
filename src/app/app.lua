------------------------------------------------------------
-- 游戏入口
--

local _M = class('App')

function _M:run()
    math.randomseed(os.time())

    cc.exports.CGDirector        = cc.Director:getInstance()
    cc.exports.CGEventDispatcher = CGDirector:getEventDispatcher()
    cc.exports.CGFormat          = string.format

    
    cc.exports.CGEnv = require('app.util.env.env')
    require('app.util.log.stdout')
    cc.exports.CGLog = require('app.util.log.log')
    CGEnv:load()
    
    cc.exports.CGHotUpdate = require('app.util.hotupdate.hotupdate').new()
    
    cc.exports.CGMainScene = cc.Scene:create()
    CGDirector:runWithScene(CGMainScene)

    local sp = cc.Sprite:create('image/background/HelloWorld.png')
    if sp then
        sp:setPosition(display.center)
        sp:addTo(CGMainScene)
    end

    CGGlobals()
end

return _M