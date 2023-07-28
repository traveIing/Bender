function notify(titletxt, text, time)
    local GUI = Instance.new("ScreenGui")
    local Main = Instance.new("Frame", GUI)
    local title = Instance.new("TextLabel", Main)
    local message = Instance.new("TextLabel", Main)
    GUI.Name = "Notification"
    GUI.Parent = game.CoreGui
    Main.Name = "MainFrame"
	Main.BackgroundColor3 = Color3.fromRGB(23, 32, 42)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(1, 5, 0, 50)
    Main.Size = UDim2.new(0, 330, 0, 100)

    title.BackgroundColor3 = Color3.new(0, 0, 0)
    title.BackgroundTransparency = 0.89999997615814
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Font = Enum.Font.SourceSansSemibold
    title.Text = titletxt
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 17
    
    message.BackgroundColor3 = Color3.new(0, 0, 0)
    message.BackgroundTransparency = 1
    message.Position = UDim2.new(0, 0, 0, 30)
    message.Size = UDim2.new(1, 0, 1, -30)
    message.Font = Enum.Font.SourceSans
    message.Text = text
    message.TextColor3 = Color3.new(1, 1, 1)
    message.TextSize = 16

    task.wait(0.1)
    Main:TweenPosition(UDim2.new(1, -330, 0, 50), "Out", "Sine", 0.5)
    
    coroutine.wrap(function()
        task.wait(time)
        Main:TweenPosition(UDim2.new(1, 5, 0, 50), "Out", "Sine", 0.5)
        task.wait(0.6)
        GUI:Destroy();
    end)()
end
function notifyError(titletxt, text, time)
    -- Error Sound
    local Error = Instance.new("Sound")
    Error.Name = "Error Sound"
    Error.SoundId = "http://www.roblox.com/asset/?id=4841731967"
    Error.Volume = 2
    Error.Looped = false
    Error.archivable = false
    Error.Parent = game.Workspace
    Error:Play()
    -- Notification Code
    local GUI = Instance.new("ScreenGui")
    local Main = Instance.new("Frame", GUI)
    local title = Instance.new("TextLabel", Main)
    local message = Instance.new("TextLabel", Main)
    GUI.Name = "Notification"
    GUI.Parent = game.CoreGui
    Main.Name = "MainFrame"
	Main.BackgroundColor3 = Color3.fromRGB(23, 32, 42)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(1, 5, 0, 50)
    Main.Size = UDim2.new(0, 330, 0, 100)

    title.BackgroundColor3 = Color3.new(0, 0, 0)
    title.BackgroundTransparency = 0.89999997615814
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Font = Enum.Font.SourceSansSemibold
    title.Text = titletxt
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 17
    
    message.BackgroundColor3 = Color3.new(0, 0, 0)
    message.BackgroundTransparency = 1
    message.Position = UDim2.new(0, 0, 0, 30)
    message.Size = UDim2.new(1, 0, 1, -30)
    message.Font = Enum.Font.SourceSans
    message.Text = text
    message.TextColor3 = Color3.new(1, 1, 1)
    message.TextSize = 16

    task.wait(0.1)
    Main:TweenPosition(UDim2.new(1, -330, 0, 50), "Out", "Sine", 0.5)
    
    coroutine.wrap(function()
        task.wait(time)
        Main:TweenPosition(UDim2.new(1, 5, 0, 50), "Out", "Sine", 0.5)
        task.wait(0.6)
        GUI:Destroy();
    end)()
end
function chatNotify(reqMsg, reqColor)
    game.StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = reqMsg; 
        Font = Enum.Font.SourceSansBold;
        FontSize = Enum.FontSize.Size36;
        Color = Color3.new(reqColor);
    })
end
function promptBetaInfo()
    chatNotify("Developer Beta | Commands may potentially be buggy or unstable. Please report any issues on our Discord server!", 0) 
    chatNotify("https://discord.gg/UCvJatDRfp", 0)
 end
--
