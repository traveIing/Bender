-- Gamepass Check
local function hasPerm(plr)
    local PermNBC = 66254
    local PermBC = 64354
    local UserID = plr.UserId

    if string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PermNBC), PermNBC)
        or string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PermBC), PermBC) then
        return true
    else
        return false
    end
end

local function hasPersons(plr)
    local PersonNBC = 35748
    local PersonBC = 37127
    local UserID = plr.UserId

    if string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PersonNBC), PersonNBC)
        or string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PersonBC), PersonBC) then
        return true
    else
        return false
    end
end

-- PlayerList Code
local PlayerList = game:GetService("CoreGui").PlayerList

local MAX_BUBBLES = 7
local BUBBLE_HEIGHT = 50
local BUBBLE_SPACING = 5
local THUMBNAIL_SIZE = 30
local THUMBNAIL_PADDING = 5
local THUMBNAIL_VERTICAL_OFFSET = 10

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, (BUBBLE_HEIGHT + BUBBLE_SPACING) * MAX_BUBBLES)
frame.Position = UDim2.new(1, -220, 0.5, -((BUBBLE_HEIGHT + BUBBLE_SPACING) * MAX_BUBBLES) / 2)
frame.BackgroundTransparency = 1
frame.BorderSizePixel = 0
frame.Parent = PlayerList

local function createBubble(parent)
    local bubble = Instance.new("Frame")
    bubble.Size = UDim2.new(1, 0, 0, BUBBLE_HEIGHT)
    bubble.BackgroundTransparency = 1

    local cornerRadius = Instance.new("UICorner")
    cornerRadius.CornerRadius = UDim.new(0, 10)
    cornerRadius.Parent = bubble

    local displayNameLabel = Instance.new("TextLabel")
    displayNameLabel.Size = UDim2.new(1, -10, 0, BUBBLE_HEIGHT * 0.5)
    displayNameLabel.Position = UDim2.new(0, 5, 0, 0)
    displayNameLabel.BackgroundTransparency = 1
    displayNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    displayNameLabel.TextSize = 16
    displayNameLabel.Font = Enum.Font.SourceSansBold
    displayNameLabel.Parent = bubble

    local usernameLabel = Instance.new("TextLabel")
    usernameLabel.Size = UDim2.new(1, -10, 0, BUBBLE_HEIGHT * 0.5)
    usernameLabel.Position = UDim2.new(0, 5, 0, BUBBLE_HEIGHT * 0.5)
    usernameLabel.BackgroundTransparency = 1
    usernameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    usernameLabel.TextSize = 14
    usernameLabel.Font = Enum.Font.SourceSans
    usernameLabel.Parent = bubble

    local thumbnailImage = Instance.new("ImageLabel")
    thumbnailImage.Size = UDim2.new(0, THUMBNAIL_SIZE, 0, THUMBNAIL_SIZE)
    thumbnailImage.Position = UDim2.new(0, THUMBNAIL_PADDING, 0, BUBBLE_HEIGHT * 0.5 + THUMBNAIL_VERTICAL_OFFSET)
    thumbnailImage.AnchorPoint = Vector2.new(0, 0.5)
    thumbnailImage.BackgroundTransparency = 1
    thumbnailImage.Parent = bubble

    bubble.Parent = parent
    return bubble, displayNameLabel, usernameLabel, thumbnailImage
end

local function updatePlayerList()
    for _, child in ipairs(frame:GetChildren()) do
        child:Destroy()
    end

    local players = game:GetService("Players"):GetPlayers()

    local totalHeight = frame.Size.Y.Offset
    local availableHeight = math.min(totalHeight, (#players * (BUBBLE_HEIGHT + BUBBLE_SPACING)) - BUBBLE_SPACING)
    local spacing = availableHeight / #players

    for i, player in ipairs(players) do
        local bubble, displayNameLabel, usernameLabel, thumbnailImage = createBubble(frame)

        bubble.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        bubble.BackgroundTransparency = 0.3
        if player.Name == game.Players.LocalPlayer.Name then
        displayNameLabel.Text = player.DisplayName
        displayNameLabel.TextColor3 = Color3.fromRGB(53, 186, 33)
        usernameLabel.Text = "@" .. player.Name
        usernameLabel.TextColor3 = Color3.fromRGB(53, 186, 33)
        else
            displayNameLabel.Text = player.DisplayName;
            usernameLabel.Text = "@" .. player.Name;
        end

        if hasPerm(player) then
            local permissionLabel = Instance.new("TextLabel")
            permissionLabel.Size = UDim2.new(0, 80, 0, 30)
            permissionLabel.Position = UDim2.new(1, -90, 0, 0)
            permissionLabel.BackgroundTransparency = 1
            permissionLabel.Text = "Perm"
            permissionLabel.TextColor3 = Color3.fromRGB(186, 33, 33)
            permissionLabel.TextSize = 14
            permissionLabel.Font = Enum.Font.SourceSans
            permissionLabel.TextXAlignment = Enum.TextXAlignment.Right
            permissionLabel.TextYAlignment = Enum.TextYAlignment.Center
            permissionLabel.Parent = bubble
        end

        if hasPersons(player) then
            local permissionLabelr = Instance.new("TextLabel")
            permissionLabelr.Size = UDim2.new(0, 80, 0, 30)
            permissionLabelr.Position = UDim2.new(1, -90, 0, 22)
            permissionLabelr.BackgroundTransparency = 1
            permissionLabelr.Text = "Person299"
            permissionLabelr.TextColor3 = Color3.fromRGB(33, 101, 186)
            permissionLabelr.TextSize = 14
            permissionLabelr.Font = Enum.Font.SourceSans
            permissionLabelr.TextXAlignment = Enum.TextXAlignment.Right
            permissionLabelr.TextYAlignment = Enum.TextYAlignment.Center
            permissionLabelr.Parent = bubble
        end

        local yOffset = (i - 1) * (BUBBLE_HEIGHT + BUBBLE_SPACING) + 5
        bubble.Position = UDim2.new(0, 15, 0, yOffset)

        -- Fetch and set the user's thumbnail image
        local thumbnailType = Enum.ThumbnailType.HeadShot
        local thumbnailSize = Enum.ThumbnailSize.Size420x420
        local thumbnailUrl = game:GetService("Players"):GetUserThumbnailAsync(player.UserId, thumbnailType, thumbnailSize)
        thumbnailImage.Image = thumbnailUrl
        thumbnailImage.Size = UDim2.new(0, THUMBNAIL_SIZE, 0, THUMBNAIL_SIZE)

        -- Scale down the thumbnail image if it exceeds the maximum size
        local aspectRatio = thumbnailImage.ImageRectSize.X / thumbnailImage.ImageRectSize.Y
        if thumbnailImage.Size.X.Offset > THUMBNAIL_SIZE or thumbnailImage.Size.Y.Offset > THUMBNAIL_SIZE then
            if aspectRatio > 1 then
                thumbnailImage.Size = UDim2.new(0, THUMBNAIL_SIZE, 0, THUMBNAIL_SIZE / aspectRatio)
            else
                thumbnailImage.Size = UDim2.new(0, THUMBNAIL_SIZE * aspectRatio, 0, THUMBNAIL_SIZE)
            end
        end
    end
end

local function slidePlayerList()
    isSlided = not isSlided -- Toggle the state

    local slidePosition = UDim2.new(1, -220, 0.5, -((BUBBLE_HEIGHT + BUBBLE_SPACING) * MAX_BUBBLES) / 2)
    local slideOutPosition = UDim2.new(1, 0, 0.5, -((BUBBLE_HEIGHT + BUBBLE_SPACING) * MAX_BUBBLES) / 2)
    
    local targetPosition = isSlided and slideOutPosition or slidePosition

    frame:TweenPosition(targetPosition, Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.3, true)
end

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Tab then
        slidePlayerList()
    end
end)

frame.Position = isSlided and UDim2.new(1, 0, 0.5, -((BUBBLE_HEIGHT + BUBBLE_SPACING) * MAX_BUBBLES) / 2) or UDim2.new(1, -220, 0.5, -((BUBBLE_HEIGHT + BUBBLE_SPACING) * MAX_BUBBLES) / 2)

game:GetService("Players").PlayerAdded:Connect(updatePlayerList)
local function isLocalPlayerLeaving(player)
    if player == game.Players.LocalPlayer then
        return true
    else
        return false
    end
end

local Connections = {}
local function isLocalPlayerLeaving(player)
    if player == game.Players.LocalPlayer then
        return true
    else
        return false
    end
end
local function removeFunction()
    for _, Connection in ipairs(Connections) do
        Connection:Disconnect()
        break
    end
end
Connections[#Connections + 1] = game:GetService("Players").PlayerRemoving:Connect(function(player)
    if isLocalPlayerLeaving(player) then
        removeFunction()        
        return
    end
    updatePlayerList()
end)

updatePlayerList()
