-- // Variables \\ --

HttpRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request;
HttpService = game:GetService("HttpService")
TeleportService = game:GetService("TeleportService");
PlaceId = game.PlaceId;
JobId = game.JobId;
LP = game.Players.LocalPlayer;
Queue = (fluxus and fluxus.queue_on_teleport) or (syn and syn.queue_on_teleport) or (queue_on_teleport);

-- // Audio \\ --

function playAudio(req)
    if (getgenv().muteSound == true) then
        return
    end
    if (req == "Intro") then
        local Intro = Instance.new("Sound")
        Intro.Name = "Introduction Sound"
        Intro.SoundId = "http://www.roblox.com/asset/?id=1570675466"
        Intro.Volume = 2
        Intro.Looped = false
        Intro.archivable = false
        Intro.Parent = game.Workspace
        Intro:Play()
        Intro:Destroy()
    elseif (req == "Error") then
        local Error = Instance.new("Sound")
        Error.Name = "Error Sound"
        Error.SoundId = "http://www.roblox.com/asset/?id=4841731967"
        Error.Volume = 2
        Error.Looped = false
        Error.archivable = false
        Error.Parent = game.Workspace
        Error:Play()
        Error:Destroy()
    elseif (req == "SetupError") then
        local SetupError = Instance.new("Sound")
        SetupError.Name = "Error Sound"
        SetupError.SoundId = "http://www.roblox.com/asset/?id=1346533206"
        SetupError.Volume = 2
        SetupError.Looped = false
        SetupError.archivable = false
        SetupError.Parent = game.Workspace
        SetupError:Play()
        SetupError:Destroy()
    end
end
function muteAudio(req)
    if req == true then
        getgenv().muteSound = true
    else
        getgenv().muteSound = false
    end
end

-- // Server Hop \\ --

function ServerHop()
    if (HttpRequest) then
        local Servers = {}
        local Request = HttpRequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100", PlaceId)})
        local Body = HttpService:JSONDecode(Request.Body) -- Server Information
        local Data = Body.data; -- Formatted Server Information
        if (Body and Data) then -- If there's Server Data
            for i, v in pairs(Data) do
                local playerLimit = tonumber(v.maxPlayers);
                local isPlaying = tonumber(v.playing);
                local requestID = v.id;
                if (type(v) == "table") and (playerLimit and isPlaying) and (isPlaying < playerLimit and requestID ~= JobId) then
                    table.insert(Servers, 1, requestID)
                end
            end
        else
            return nil;
        end
        if (#Servers > 0) then
            local randomServer = Servers[math.random(1, #Servers)];
            TeleportService:TeleportToPlaceInstance(PlaceId, randomServer, LP)
        else
            return false;
        end
    end
end
function Rejoin()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, JobId, LP);
end
function CheckIfCrashed()
    local Ping1 = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    task.wait(2.5)
    local Ping2 = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    if (Ping1 == Ping2) then
        return true
    else
        return false
    end
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
                        _G.foundPlayer = true
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
