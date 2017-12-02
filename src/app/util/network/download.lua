------------------------------------------------------------
-- HTTP网络下载器
------------------------------------------------------------

local STATE_CODE = require('app.util.network.constant').DOWNLOAD_STATE_CODE
local _M = class('download')

------------------------------------------
-- @description : 构造下载器
-- @params url : 下载地址
-- @params storage : 存储地址
-- @params responseCB : 下载回调
--
function _M:ctor(url, storage, responseCB)
    self.downloadUrl = url
    self.storagePath = storage
    self.responseCB  = responseCB
    self.downHandler = nil
end

------------------------------------------
-- @description : 设置下载地址
-- @params url : 下载地址
--
function _M:setUrl(url)
    self.downloadUrl = url
end

------------------------------------------
-- @description : 设置存储地址
-- @params storage : 存储地址
--
function _M:setStorage(storage)
    self.storagePath = storage
end

------------------------------------------
-- @description : 设置下载回调
-- @params response : 下载回调
--
function _M:setResponseCallBack(responseCB)
    self.responseCB  = responseCB
end

------------------------------------------
-- @description : 处理下载状态事件
-- @params code : 下载状态代码
--
function _M:handleStateEvent(code)
    if self.responseCB and type(self.responseCB) == 'function' then
        self.responseCB(code, self.storagePath)
    end
end

------------------------------------------
-- @description : 下载核心
--
function _M:download()
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("GET", self.downloadUrl)
    local function onDownloadStateChanged()
        print(__strfmt('%s [xhr.readyState : %d]', self.downloadUrl, xhr.readyState))
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 300) then
            self:handleStateEvent(STATE_CODE.DOWN_OK)
            local data = xhr.response
            local file = io.open(self.storagePath, "wb")
            if file then
                file:write(data)
                file:close()
                self:handleStateEvent(STATE_CODE.WRITE_OK)
            else
                self:handleStateEvent(STATE_CODE.WRITE_FAILED)
            end
        else
            self:handleStateEvent(STATE_CODE.DOWN_FAILED)
            coroutine.resume(self.downHandler)
            self.downHandler = nil
        end
    end
    xhr:registerScriptHandler(onDownloadStateChanged)
    xhr:send()
    print("[download] start to download " .. self.downloadUrl)
end

------------------------------------------
-- @description : 获取下载任务状态
--
function _M:getState()
    if not self.downHandler then
        return 'none'
    end
    local status = coroutine.status(self.downHandler)
    return status
end

------------------------------------------
-- @description : 开始下载任务
--
function _M:start()
    if not self.downloadUrl then
        print("[download] Please check download url first.")
        return
    end
    if not self.storagePath then
        print("[download] Please check storage path first.")
        return
    end
    if self.downHandler and coroutine.status(self.downHandler) ~= 'running' then
        print("[download] Download task is running.")
        return
    end
    print("[download] set download info : \n\turl : " .. self.downloadUrl .. "\n\tsave : " .. self.storagePath)
    self.downHandler = coroutine.create(function()
        self:download()
    end)
    coroutine.resume(self.downHandler)
end

------------------------------------------
-- @description : 停止下载任务
--
function _M:stop()
    if not self.downHandler then
        return
    end
    local status = coroutine.status(self.downHandler)
    if status ~= 'dead' and status ~= 'suspend' then
        coroutine.yield()
        self.downHandler = nil
    end
end

------------------------------------------
-- @description : 挂起下载任务
--
function _M:suspend()
   if not self.downHandler then
        return
    end
    local status = coroutine.status(self.downHandler)
    if status == 'running' then
        coroutine.yield()
    end
end

------------------------------------------
-- @description : 恢复下载任务
--
function _M:resume()
   if not self.downHandler then
        return
    end
    local status = coroutine.status(self.downHandler)
    if status == 'suspend' then
        coroutine.resume(self.downHandler)
    end
end

return _M
