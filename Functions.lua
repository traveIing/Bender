-- // Variables \\ --

HttpRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
HttpService = game:GetService("HttpService")
TeleportService = game:GetService("TeleportService")
PlaceId = game.PlaceId
JobId = game.JobId
LP = game.Players.LocalPlayer
Queue = (fluxus and fluxus.queue_on_teleport) or (syn and syn.queue_on_teleport) or (queue_on_teleport)

-- // Audio \\ --

function PlaySound(req)
    local function set_audio(id, name)
        local Sound = Instance.new("Sound")
        Sound.Name = name
        Sound.SoundId = "http://www.roblox.com/asset/?id=" .. id
        Sound.Volume = 2
        Sound.Looped = false
        Sound.archivable = false
        Sound.Parent = game.Workspace
        Sound:Play()
    end
    local sound_types = {
        ["Intro"] = "1570675466", ["Error"] = "8551372796",
        ["SetupError"] = "1346533206", ["CrashDetected"] = "7383525713",
        ["CONFIRM_ACTION"] = "1524543584", ["LEAVING_GAME"] = "4835664238",
        ["PREFIX_CHANGE"] = "716565345", ["STARTUP_SOUND"] = "9041819468"
    }

    for name, aid in pairs(sound_types) do
        if (name == req) then
            set_audio(aid, name)
        end
    end
end

-- // Server Handling \\ --

function ServerHop()
    if (HttpRequest) then
        local Servers = {}
        local Request = HttpRequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100", PlaceId)})
        local Body = HttpService:JSONDecode(Request.Body)
        local Data = Body.data
        if (Body and Data) then
            for i, v in pairs(Data) do
                local playerLimit = tonumber(v.maxPlayers);
                local isPlaying = tonumber(v.playing);
                local requestID = v.id;
                if (type(v) == "table") and (playerLimit and isPlaying) and (isPlaying < playerLimit and requestID ~= JobId) then
                    table.insert(Servers, 1, requestID)
                end
            end
        else
            return nil
        end
        if (#Servers > 0) then
            local randomServer = Servers[math.random(1, #Servers)];
            TeleportService:TeleportToPlaceInstance(PlaceId, randomServer, LP)
        else
            return false;
        end
    end
end

function CheckIfCrashed()
    local Ping1 = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    task.wait(3)
    local Ping2 = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    if (Ping1 == Ping2) then
        return true
    else
        return false
    end
end

function Rejoin()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, JobId, LP)
end

function JoinPlayer(plrID)
    local userID = plrID
    local gameID = tostring(game.PlaceId)
    local httpService = game:GetService("HttpService")
    local servers, cursor = {}
    local success, response = pcall(function()
        local serverData = HttpRequest({
            Url = string.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Desc&limit=100%s", gameID, cursor and "&cursor=" .. cursor or "")
        })
        cursor = serverData.nextPageCursor
        serverData = httpService:JSONDecode(serverData.Body)
        local playerHeadshot = HttpRequest({
            Url = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=".. userID .. "&size=150x150&format=Png&isCircular=false"
        })
        local playerImageURL = httpService:JSONDecode(playerHeadshot.Body).data[1].imageUrl
        for _, server in ipairs(serverData.data) do
            local playerIcons = {}
            for i = 1, #server.playerTokens do
                table.insert(playerIcons, {
                    token = server.playerTokens[i],
                    type = "AvatarHeadshot",
                    size = "150x150",
                    requestId = server.id
                })
            end
            local postRequest = HttpRequest({
                Url = "https://thumbnails.roblox.com/v1/batch",
                Method = "POST",
                Body = httpService:JSONEncode(playerIcons),
                Headers = {
                    ["Content-Type"] = "application/json"
                }
            })
            local recvServerData = httpService:JSONDecode(postRequest.Body).data
            if (recvServerData) then
                for _, v in ipairs(recvServerData) do
                    if (v.imageUrl == playerImageURL) then
                        game:GetService("TeleportService"):TeleportToPlaceInstance(gameID, v.requestId)
                        return
                    end
                end
            end
        end
    end)
    if not success then
        warn("An error occurred:", response)
    end
end

-- // Encryption \\ --

function GetGUID()
    local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end

function SendUniqueIdentifier()
    game.Players:Chat(GetGUID())
end
