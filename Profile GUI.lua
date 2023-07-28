-- Main Code

-- Defining GP Check Functions

local function hasPerm(UserID)
    local PermNBC = 66254
    local PermBC = 64354
 
    if string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PermNBC), PermNBC)
    or string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. _G.UserID .. "/items/GamePass/" .. PermBC), PermBC) then
       return true
    else
       return false
    end
 end
 
 local function hasPersons(UserID)
    local PersonNBC = 35748
    local PersonBC = 37127
 
    if string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PersonNBC), PersonNBC)
    or string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PersonBC), PersonBC) then
       return true
    else
       return false
    end
 end
 
 -- Misc Functions
 
 local function getDate(n)
    return os.date('%B %d %Y %H:%M:%S', n)
end

 
 local function addCommas(number)
    -- Convert the number to a string
    local numberString = tostring(number)
 
    -- Reverse the string
    local reversedString = string.reverse(numberString)
 
    -- Split the reversed string into chunks of 3 characters
    local chunks = {}
    local index = 1
 
    while index <= #reversedString do
       local chunk = string.sub(reversedString, index, index + 2)
       table.insert(chunks, chunk)
       index = index + 3
    end
 
    -- Join the chunks with commas and reverse the final string
    local finalString = table.concat(chunks, ",")
    finalString = string.reverse(finalString)
 
    return finalString
 end
 
 
 -- Defining ProfileGUI function
 
 function promptProfileGUI(plr)
 
    -- Gathering Information
 
    -- Variables
    local HttpRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    local UserData = HttpRequest({Url = "https://api.joinbender.com/roblox/LookupAPI/userinfo.php?username=" .. plr})
    local HttpService = game:GetService("HttpService")
 
    -- Making sure that the received information are strings
    if type(UserData) == "table" then
       for key, value in pairs(UserData) do
          if (key == "Body")  then
 
             -- JSON Sorter
             local User = value:gsub('.*"requestedUsername":"(.-)".*', '%1')
             local Badge = value:gsub('.*"hasVerifiedBadge":(.-),.*', '%1')
             local ID = value:gsub('.*"id":(.-),.*', '%1')
             local Nametag = value:gsub('.*"name":"(.-)".*', '%1')
             local Dname = value:gsub('.*"displayName":"(.-)".*', '%1')
             -- Defining User Data Information
             _G.Username = User;
             _G.HasVerifiedBadge = Badge;
             _G.UserID = ID;
             _G.Username = Nametag;
             _G.DisplayName = Dname;
             _G.Followers = game:HttpGet("https://api.joinbender.com/roblox/LookupAPI/userfollowers.php?userId=" .. _G.UserID)
             -- Getting precise account date
             local dateResponse = HttpRequest({
                Url = "https://users.roblox.com/v1/users/" .. _G.UserID;
            })
            
             for i,json in pairs(dateResponse) do
                if type(json) == "string" then
                   task.spawn(function()
                   local Created = string.match(json, '"created":"(.-)"')
                   local Date = Created:match("^([%d-]+)")
                   _G.AccountDate = Date;
                   end)
                end
             end
             -- Getting precise last-online date
 
             local lastOnlineResponse = HttpRequest({
                Url = "https://www.rolimons.com/playerapi/player/" .. _G.UserID;
             })
             for i,json in pairs(dateResponse) do
                if type(json) == "string" then
                   local dec = game:GetService("HttpService"):JSONDecode(json)
                   _G.LastOnline = getDate(dec.last_online);
                end
             end
          end
       end
    else
       print("API response is not a table")
       return nil
    end
 
    -- Caching Gamepass Check
 
    if hasPerm(_G.UserID) then
       _G.hasPerm = true;
    else
       _G.hasPerm = false;
    end
    if hasPersons(_G.UserID) then
       _G.hasPersons = true;
    else
       _G.hasPersons = false;
    end
 
    -- GUI Variables
    local ScreenGui = Instance.new("ScreenGui")
    local UserProfile = Instance.new("Frame")
    local UserData = Instance.new("Folder")
    local UserInfo = Instance.new("Folder")
    local Header = Instance.new("TextLabel")
    local JoinDate = Instance.new("TextLabel")
    local UserThumb = Instance.new("ImageLabel")
    local UserID = Instance.new("TextLabel")
    local UserFollowing = Instance.new("TextLabel")
    local UserLastOnline = Instance.new("TextLabel")
    local UserGP = Instance.new("Folder")
    local ImageLabel = Instance.new("ImageLabel")
    local ImageLabel_2 = Instance.new("ImageLabel")
    local Configs = Instance.new("Folder")
    local TopBar = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Username = Instance.new("TextLabel")
    local UICorner_2 = Instance.new("UICorner")
 
    -- Properties:
 
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false;
 
    UserProfile.Name = "UserProfile"
    UserProfile.Parent = ScreenGui
    UserProfile.BackgroundColor3 = Color3.fromRGB(36, 36, 45)
    UserProfile.Position = UDim2.new(-0.45, 0, 0.522688329, 0)
    UserProfile.Size = UDim2.new(0, 317, 0, 154)
    UserProfile.Active = true
    UserProfile.Draggable = true
 
    UserData.Name = "UserData"
    UserData.Parent = UserProfile
 
    UserInfo.Name = "UserInfo"
    UserInfo.Parent = UserData
 
    Header.Name = "Header"
    Header.Parent = UserInfo
    Header.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
    Header.Position = UDim2.new(0.419558346, 0, 0.187134504, 0)
    Header.Size = UDim2.new(0, 172, 0, 13)
    Header.Font = Enum.Font.SourceSans
    Header.Text = "Profile Information"
    Header.TextColor3 = Color3.fromRGB(255, 255, 255)
    Header.TextSize = 14.000
 
    JoinDate.Name = "JoinDate"
    JoinDate.Parent = UserInfo
    JoinDate.BackgroundColor3 = Color3.fromRGB(36, 36, 45)
    JoinDate.BorderColor3 = Color3.fromRGB(36, 36, 45)
    JoinDate.Position = UDim2.new(0.542586923, 0, 0.450292408, 0)
    JoinDate.Size = UDim2.new(0, 94, 0, 17)
    JoinDate.Font = Enum.Font.SourceSans
    JoinDate.Text = "Join Date: " .. _G.AccountDate
    JoinDate.TextColor3 = Color3.fromRGB(255, 255, 255)
    JoinDate.TextSize = 14.000
 
    UserThumb.Name = "UserThumb"
    UserThumb.Parent = UserInfo
    UserThumb.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
    UserThumb.Position = UDim2.new(0.0788643509, 0, 0.263157904, 0)
    UserThumb.Size = UDim2.new(0, 88, 0, 76)
    UserThumb.BackgroundTransparency = 0
    UserThumb.BorderColor3 = Color3.fromRGB(46, 54, 56) -- Set the color of the frame
    UserThumb.BorderSizePixel = 4 -- Set the size of the frame
    UserThumb.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
 
    -- Get the user's thumbnail URL
    local thumbnailUrl = game:GetService("Players"):GetUserThumbnailAsync(_G.UserID, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
    UserThumb.Image = thumbnailUrl
 
    UserID.Name = "UserID"
    UserID.Parent = UserInfo
    UserID.BackgroundColor3 = Color3.fromRGB(36, 36, 45)
    UserID.BorderColor3 = Color3.fromRGB(36, 36, 45)
    UserID.Position = UDim2.new(0.542586923, 0, 0.30409357, 0)
    UserID.Size = UDim2.new(0, 94, 0, 17)
    UserID.Font = Enum.Font.SourceSans
    UserID.Text = "User ID: " .. _G.UserID
    UserID.TextColor3 = Color3.fromRGB(255, 255, 255)
    UserID.TextSize = 14.000
 
    UserFollowing.Name = "UserFollowing"
    UserFollowing.Parent = UserInfo
    UserFollowing.BackgroundColor3 = Color3.fromRGB(36, 36, 45)
    UserFollowing.BorderColor3 = Color3.fromRGB(36, 36, 45)
    UserFollowing.Position = UDim2.new(0.539432347, 0, 0.578947365, 0)
    UserFollowing.Size = UDim2.new(0, 94, 0, 17)
    UserFollowing.Font = Enum.Font.SourceSans
    UserFollowing.Text = " Followers: " .. addCommas(_G.Followers)
    UserFollowing.TextColor3 = Color3.fromRGB(255, 255, 255)
    UserFollowing.TextSize = 14.000
 
    UserLastOnline.Name = "UserLastOnline"
    UserLastOnline.Parent = UserInfo
    UserLastOnline.BackgroundColor3 = Color3.fromRGB(36, 36, 45)
    UserLastOnline.BorderColor3 = Color3.fromRGB(36, 36, 45)
    UserLastOnline.Position = UDim2.new(0.536277771, 0, 0.71047365, 0)
    UserLastOnline.Size = UDim2.new(0, 94, 0, 17)
    UserLastOnline.Font = Enum.Font.SourceSans
    UserLastOnline.Text = "Last Online: " .. _G.LastOnline
    UserLastOnline.TextColor3 = Color3.fromRGB(255, 255, 255)
    UserLastOnline.TextSize = 14.000
 
    UserGP.Name = "UserGP"
    UserGP.Parent = UserData
 
    -- Checking if the requested user has Perm or Person299
    local MarketplaceService = game:GetService("MarketplaceService")
    local permImageID = "rbxassetid://116737592"
    local personImageID = "rbxassetid://127681615"
 
 
    ImageLabel.Parent = UserGP
    ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel.Position = UDim2.new(0.873817027, 0, 0.30409354, 0)
    ImageLabel.Size = UDim2.new(0, 28, 0, 27)
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.ImageTransparency = 1;
    ImageLabel.Image = permImageID
 
    ImageLabel_2.Parent = UserGP
    ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel_2.Position = UDim2.new(0.873817027, 0, 0.549707592, 0)
    ImageLabel_2.Size = UDim2.new(0, 28, 0, 27)
    ImageLabel_2.BackgroundTransparency = 1;
    ImageLabel_2.ImageTransparency = 1;
    ImageLabel_2.Image = personImageID
 
    Configs.Name = "Configs"
    Configs.Parent = UserProfile
 
    TopBar.Name = "TopBar"
    TopBar.Parent = Configs
    TopBar.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    TopBar.Position = UDim2.new(0, 0, -0.0660852194, 0)
    TopBar.Size = UDim2.new(0, 317, 0, 27)
 
    UICorner.CornerRadius = UDim.new(0.0599999987, 1)
    UICorner.Parent = TopBar
 
    Username.Name = "Username"
    Username.Parent = TopBar
    Username.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    Username.BorderColor3 = Color3.fromRGB(8, 8, 8)
    Username.Position = UDim2.new(0.0563091487, 0, 0.0545811243, 0)
    Username.Size = UDim2.new(0, 129, 0, 24)
    Username.Font = Enum.Font.SourceSansBold
    Username.Text = _G.DisplayName .. " (@" .. _G.Username .. ")"
    Username.TextColor3 = Color3.fromRGB(255, 255, 255)
    Username.TextSize = 14.000
 
    UICorner_2.CornerRadius = UDim.new(0.0599999987, 0)
    UICorner_2.Parent = UserProfile
    -- X button
    local function fadeOut(guiObject, duration)
       local fadeTween = game:GetService("TweenService"):Create(guiObject, TweenInfo.new(duration), {BackgroundTransparency = 1})
       fadeTween:Play()
       fadeTween.Completed:Wait()
       guiObject.Visible = false
    end
 
    local function tweenToPosition(guiObject, endPosition, duration)
       local tween = game:GetService("TweenService"):Create(guiObject, TweenInfo.new(duration), {Position = endPosition})
       tween:Play()
    end
 
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local endPosition = UDim2.new(0.79, 0, 0.680, 0)
    UserProfile.Position = UDim2.new(1.45, 0, 0.680, 0)
    tweenToPosition(UserProfile, endPosition, 0.5)
 
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TopBar
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(0.948, 0, 0, 0)
    CloseButton.Size = UDim2.new(0, 17, 0, 17)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 14.000
 
    CloseButton.MouseButton1Click:Connect(function()
    fadeOut(UserProfile, 0.05) 
    end)
 
    if _G.hasPerm then
       ImageLabel.ImageTransparency = 0;
    end
    if _G.hasPersons then
       ImageLabel_2.ImageTransparency = 0;
    end
 end
 
 promptProfileGUI("roblox")
