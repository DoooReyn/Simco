
cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath('cocos-framework')


require "config"
require "cocos.init"
require "app.util.global"

local function main()
    require('app.app'):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
