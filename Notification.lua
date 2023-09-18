function notify(titletxt, text, time)
    local GUI = Instance.new("ScreenGui")
    local Main = Instance.new("Frame", GUI)
    local UICorner = Instance.new("UICorner", Main)
    local title = Instance.new("TextLabel", Main)
    local message = Instance.new("TextLabel", Main)
    GUI.Name = "Notification"
    GUI.Parent = game.CoreGui
    Main.Name = "MainFrame"
    Main.BackgroundColor3 = Color3.fromRGB(71, 71, 71)
    Main.BackgroundTransparency = 0.2
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(1, 330, 0, 50) -- Starting position outside the screen
    Main.Size = UDim2.new(0, 330, 0, 100)

    title.BackgroundColor3 = Color3.fromRGB(71, 71, 71)
    title.BackgroundTransparency = 0.9
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Font = Enum.Font.SourceSansSemibold
    title.Text = titletxt
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 20
    title.TextWrapped = true

    message.BackgroundColor3 = Color3.fromRGB(71, 71, 71)
    message.BackgroundTransparency = 1
    message.Position = UDim2.new(0, 0, 0, 30)
    message.Size = UDim2.new(1, 0, 1, -30)
    message.Font = Enum.Font.SourceSans
    message.Text = text
    message.TextColor3 = Color3.new(1, 1, 1)
    message.TextSize = 16
    message.TextWrapped = true

    -- Tween the Main frame in
    Main:TweenPosition(UDim2.new(1, -330, 0, 50), "Out", "Sine", 0.5)

    coroutine.wrap(function()
        task.wait(time)
        Main:TweenPosition(UDim2.new(1, 5, 0, 50), "Out", "Sine", 0.5)
        task.wait(0.6)
        GUI:Destroy()
    end)()
end
function notifyError(titletx, txt, time)
    playAudio("Error")
    notify(titletx, txt, time)
end
function chatNotify(messageText, messageColor)
    local chatSettings = {
        Text = messageText,
        Font = Enum.Font.SourceSansBold,
        FontSize = Enum.FontSize.Size36,
        Color = messageColor
    }
    game.StarterGui:SetCore("ChatMakeSystemMessage", chatSettings)
end
function promptBetaInfo()
    chatNotify("Developer Beta | Commands may potentially be buggy or unstable. Please report any issues on our Discord server!", Color3.new(0, 0, 1)) 
    chatNotify("https://discord.gg/UCvJatDRfp", Color3.new(0, 0, 1))
 end
