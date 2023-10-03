--[[
    ServerList GUI, created by nitharya#0
    Please note that this is BUGGY, and UNFINISHED.
    This is not meant to be used in regular production, and is just an experiment.
    Please suggest ideas, and feel free to tweak this as much as you would like!
]]

function LoadServerList(request)
    if (request == false) then
        local LP = game:GetService("Players").LocalPlayer
        local PlayerGUI = LP:WaitForChild("PlayerGui")
        if PlayerGUI:FindFirstChild("ServerListGUI") then
            local ServerListGUI = PlayerGUI:FindFirstChild("ServerListGUI")
            if ServerListGUI:FindFirstChild("mainFrame") then
                local main = ServerListGUI:FindFirstChild("mainFrame")
                local tweenService = game:GetService("TweenService")
                local properties = {
                    Position = UDim2.new(-0.500, 0, 0.317, 0)
                }
                local tweenInfo = TweenInfo.new(
                    0.5,
                    Enum.EasingStyle.Linear,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                )
                local tween = tweenService:Create(main, tweenInfo, properties)
                tween.Completed:Connect(function()
                    ServerListGUI:Destroy()
                end)
                tween:Play()
                return true
            else
                ServerListGUI:Destroy()
                return true
            end
        else
            return nil
        end
    elseif (request == true) then
        print("Continuing")
        
        -- // Variables \\ --

        local saved_dir = {}
        local HttpRequest, HttpService, TeleportService, PlaceId, JobId, LP, GameID, ServerListPath, GetAsset
        do
            HttpRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
            HttpService = game:GetService("HttpService")
            TeleportService = game:GetService("TeleportService")
            PlaceId = game.PlaceId
            JobId = game.JobId
            LP = game.Players.LocalPlayer
            GameID = tostring(game.PlaceId)
            ServerListPath = "ServerList/Thumbnails"
            GetAsset = (getcustomasset) or (getsynasset)
        end

        -- // Path Configuration \\ --

        if not isfolder("ServerList") then
            makefolder("ServerList")
        end
        if not isfolder(ServerListPath) then
            makefolder(ServerListPath)
        end

        local Data = listfiles(ServerListPath)
        for i,v in pairs(Data) do
            if (isfolder(v)) then
                delfolder(v)
            end
        end

        -- // Functions \\ --

        local function pathFormatUrl(input)
            local result = input:gsub("[:/\\]", "")
            return result
        end
        local function formatLS(input)
            local result = string.gsub(input, "\\", "/")
            return result
        end
        local function getServerFromJobID(id)
            local Request = HttpRequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100", GameID)})
            local Body = HttpService:JSONDecode(Request.Body)
            local Data = Body.data
            if (Body and Data) then
                for i, v in pairs(Data) do
                    local requestID = v.id
                    if (requestID == id) then
                        return true
                    end
                end
            end
        end

        -- // Storing Thumbnail Data \\ --
        
        local serverData = HttpRequest({
            Url = string.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Desc&limit=100", GameID)
        })
        serverData = HttpService:JSONDecode(serverData.Body)
        local serverCount = #serverData.data
        
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
                Body = HttpService:JSONEncode(playerIcons),
                Headers = {
                    ["Content-Type"] = "application/json"
                }
            })
            local recvServerData = HttpService:JSONDecode(postRequest.Body).data
            if recvServerData then
                for playerCount, v in ipairs(recvServerData) do
                    local imageUrl = v.imageUrl
                    local requestJobId = v.requestId
                    if (not isfolder(ServerListPath .. "/" .. requestJobId)) then
                        makefolder(ServerListPath .. "/" .. requestJobId)
                    end
                    local imagePath = ServerListPath .. "/" .. requestJobId .. "/" .. pathFormatUrl(tostring(imageUrl)) .. ".png"
                    writefile(ServerListPath .. "/" .. requestJobId .. "/" .. requestJobId .. ".txt", requestJobId)
                    writefile(imagePath, game:HttpGet(v.imageUrl))
                end
            end
        end
        local function createServerObject(parent, x, y, serverIndex)
            local serverObject = Instance.new("Frame")
            serverObject.Parent = parent
            serverObject.BackgroundColor3 = Color3.fromRGB(125, 130, 134)
            serverObject.BackgroundTransparency = 0.200
            serverObject.BorderColor3 = Color3.fromRGB(0, 0, 0)
            serverObject.BorderSizePixel = 0
            serverObject.Position = UDim2.new(x, 0, y, 0)
            serverObject.Size = UDim2.new(0, 125, 0, 100)
            serverObject.ClipsDescendants = true
            local round = Instance.new("UICorner")
            round.CornerRadius = UDim.new(0.1, 0)
            round.Parent = serverObject
            local headshotContainer = Instance.new("Frame")
            headshotContainer.Parent = serverObject
            headshotContainer.BackgroundTransparency = 1
            headshotContainer.Size = UDim2.new(0, 125, 0, 100)
            headshotContainer.Position = UDim2.new(0, 0, 0, 0)
            headshotContainer.ClipsDescendants = true
            local jobid
            local function createImageLabel(xPos, yPos)
                local current_dir
                local assetid
                local Files = listfiles(ServerListPath)
                local fetched_headshot
                for i, ServerDirectory in pairs(Files) do
                    local ServerFiles = listfiles(ServerDirectory)
                    for index, file in pairs(ServerFiles) do
                        if (index == 1) then
                            current_dir = tostring(ServerFiles)
                        else
                            local headshot = formatLS(file)
                            if (not table.find(saved_dir, tostring(headshot))) and (current_dir == tostring(ServerFiles)) then
                                local data = readfile(file)
                                if (index == 1) and (type(data) == "string") then
                                    jobid = tostring(data)
                                end
                                assetid = GetAsset(headshot)
                                table.insert(saved_dir, tostring(headshot))
                                fetched_headshot = true
                                break
                            end
                        end
                        if (fetched_headshot == true) then
                            break
                        end
                    end
                end
                local imageLabel = Instance.new("ImageLabel")
                imageLabel.Parent = headshotContainer
                imageLabel.BackgroundColor3 = Color3.fromRGB(1, 1, 1)
                imageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                imageLabel.BorderSizePixel = 0
                imageLabel.Position = UDim2.new(xPos, 0, yPos, 0)
                imageLabel.Size = UDim2.new(0, 29, 0, 29)
                imageLabel.BackgroundTransparency = 0.5
                if (assetid ~= nil) then
                    imageLabel.Image = assetid
                    local roundImage = Instance.new("UICorner")
                    roundImage.CornerRadius = UDim.new(0, 8)
                    roundImage.Parent = imageLabel
                else
                    print("AssetID is nil.")
                    imageLabel:Destroy()
                end
            end
            local xPositions = {0.076, 0.375, 0.683}
            local yPositions = {0.07, 0.39}
            for i, x in ipairs(xPositions) do
                for j, y in ipairs(yPositions) do
                    createImageLabel(x, y)
                end
            end
            local joinButton = Instance.new("TextButton")
            joinButton.Parent = serverObject
            joinButton.BackgroundColor3 = Color3.fromRGB(140, 140, 140)
            joinButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
            joinButton.BorderSizePixel = 0
            joinButton.Position = UDim2.new(0.076, 0, 0.73, 0)
            joinButton.Size = UDim2.new(0, 105, 0, 20)
            joinButton.Font = Enum.Font.SourceSans
            joinButton.Text = "Join Server"
            joinButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            joinButton.TextSize = 14.000
            local roundButton = Instance.new("UICorner")
            roundButton.CornerRadius = UDim.new(0.2, 0)
            roundButton.Parent = joinButton
            joinButton.MouseButton1Click:Connect(function()
                if (type(jobid) == "string") then
                    print("Teleporting to " .. jobid)
                    TeleportService:TeleportToPlaceInstance(PlaceId, jobid, LP)
                else
                    warn("JobID isn't a valid type, teleport failed.")
                end
            end)
        end
        
        local gui = Instance.new("ScreenGui")
        gui.Name = "ServerListGUI"
        gui.Parent = LP.PlayerGui
        gui.ResetOnSpawn = false
        local mainFrame = Instance.new("Frame")
        mainFrame.Name = "mainFrame"
        mainFrame.Parent = gui
        mainFrame.BackgroundColor3 = Color3.fromRGB(35, 37, 39)
        mainFrame.BackgroundTransparency = 0.3
        mainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        mainFrame.BorderSizePixel = 0
        mainFrame.Position = UDim2.new(-0.500, 0, 0.317, 0)
        mainFrame.Size = UDim2.new(0, 536, 0, 275)
        mainFrame.ClipsDescendants = true
    
        local roundMain = Instance.new("UICorner")
        roundMain.CornerRadius = UDim.new(0, 7)
        roundMain.Parent = mainFrame
    
        local serverContainer = Instance.new("ScrollingFrame")
        serverContainer.Parent = mainFrame
        serverContainer.Active = true
        serverContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        serverContainer.BackgroundTransparency = 1
        serverContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
        serverContainer.BorderSizePixel = 0
        serverContainer.Position = UDim2.new(0.028, 0, 0.051, 0)
        serverContainer.Size = UDim2.new(0, 508, 0, 244)
        serverContainer.ScrollBarThickness = 12
    
        local numRows = 2
        local numColumns = math.ceil(serverCount / numRows)
        local spacingX = 0.29
        local spacingY = 0.25
        local serverIndex = 1
    
        for i = 1, numColumns do
            for j = 1, numRows do
                if serverIndex <= serverCount then
                    local x = (i - 1) * spacingX
                    local y = (j - 1) * spacingY
                    createServerObject(serverContainer, x, y, serverIndex)
                    serverIndex = serverIndex + 1
                else
                    break
                end
            end
        end

        local tweenService = game:GetService("TweenService")
        local properties = {
            Position = UDim2.new(0.313, 0, 0.317, 0)
        }
        local tweenInfo = TweenInfo.new(
            0.5,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        )
        local tween = tweenService:Create(mainFrame, tweenInfo, properties)
        tween:Play()
    end
end
