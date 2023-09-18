function EstablishServerConnection()
    local failed_to_connect
    local encrypted_session_data, decrypted_session_data 
    local http_request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    local server_avail_request = http_request({
        Url = "https://api.joinbender.com/crypt/AsyncDataExchangeAPI?request-type=SESSION_CREDENTIALS",
        Method = "GET",
        Headers = {
            ["Content-Type"] = "application/json"
        }
    })
    for i,v in pairs(server_avail_request) do
        if (i == "Body") then
            encrypted_session_data = v
        end
    end
    if (encrypted_session_data ~= nil) then
        local decode_connection_details = http_request({
            Url = "https://api.joinbender.com/crypt/DecryptWebTrafficAPI?request=" .. encrypted_session_data,
            Method = "GET",
            Headers = {
                ["Content-Type"] = "application/json"
            }
        })
        for i,v in pairs(decode_connection_details) do
            if (i == "Body") then
                decrypted_session_data = v
                break
            end
        end
    end
    if (decrypted_session_data ~= nil) then
        local success, err pcall(function()
            if (getgenv().Bender_WebSocket ~= nil) then
                getgenv().Bender_WebSocket:Close()
            end
            local suc, er = pcall(function()
                getgenv().Bender_WebSocket = WebSocket.connect(decrypted_session_data)
            end)
            if (not suc) and (er ~= nil) then
                warn("Couldn't connect to the socket server: " .. er)
                warn("Websocket URL: " .. decrypted_session_data)
                failed_to_connect = false and er
                getgenv().Bender_WebSocket = WebSocket.connect(decrypted_session_data)
            end
            warn("SERVCONN")
            getgenv().Bender_WebSocket.OnMessage:Connect(function(message)
                getgenv().Bender_ReceivedWebSocketMessage = message
                print("Received: " .. message)
            end)
            getgenv().Bender_WebSocket.OnClose:Connect(function()
                notifyError("Bender", "It looks like you lost connection to our servers. :(", 4)
            end)

            game:GetService("Players").PlayerRemoving:Connect(function(player)
                if (player == game.Players.LocalPlayer) then
                    getgenv().Bender_WebSocket:Close()
                end
            end)
        end)
        if (not success) and (err ~= nil) then
            warn("Error while connecting to a socket.")
        end
    else
        warn("Error while decrypting the session data.")
    end
    if (failed_to_connect ~= nil) then
        task.wait(0.25)
        return failed_to_connect
    end
end
