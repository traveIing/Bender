function Notify(titletxt, text, time)
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
    Main.Position = UDim2.new(1, 330, 0, 50)
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

    Main:TweenPosition(UDim2.new(1, -330, 0, 50), "Out", "Sine", 0.5)

    coroutine.wrap(function()
        task.wait(time)
        Main:TweenPosition(UDim2.new(1, 5, 0, 50), "Out", "Sine", 0.5)
        task.wait(0.6)
        GUI:Destroy()
    end)()
end
function NotifyError(titletx, txt, time)
    PlaySound("Error")
    Notify(titletx, txt, time)
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

function SendAlert(title, text)
    local TweenService = game:GetService("TweenService")
    local TextAlert = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local TextContainer = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TextLabel = Instance.new("TextLabel")
    local UICorner_2 = Instance.new("UICorner")
    local TextTitle = Instance.new("Frame")
    local UICorner_3 = Instance.new("UICorner")
    local Text = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local UICorner_4 = Instance.new("UICorner")

    TextAlert.Name = "TextAlert"
    TextAlert.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    TextAlert.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Main.Name = "Main"
    Main.Parent = TextAlert
    Main.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
    Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(-0.9, 0, 0.400000024, 0)
    Main.Size = UDim2.new(0, 251, 0, 313)

    TextContainer.Name = "TextContainer"
    TextContainer.Parent = Main
    TextContainer.BackgroundColor3 = Color3.fromRGB(83, 83, 83)
    TextContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextContainer.BorderSizePixel = 0
    TextContainer.Position = UDim2.new(0.0438247025, 0, 0.140575081, 0)
    TextContainer.Size = UDim2.new(0, 228, 0, 254)

    UICorner.Parent = TextContainer

    TextLabel.Parent = TextContainer
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BorderSizePixel = 0
    TextLabel.Position = UDim2.new(0.0438596494, 0, 0.0236220472, 0)
    TextLabel.Size = UDim2.new(0, 208, 0, 242)
    TextLabel.Font = Enum.Font.SourceSans
    pcall(function()
        TextLabel.Text = text
        end)
    TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 14.000
    TextLabel.TextWrapped = true

    UICorner_2.Parent = Main

    TextTitle.Name = "TextTitle"
    TextTitle.Parent = Main
    TextTitle.BackgroundColor3 = Color3.fromRGB(83, 83, 83)
    TextTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextTitle.BorderSizePixel = 0
    TextTitle.Position = UDim2.new(0.0438247025, 0, 0.025559105, 0)
    TextTitle.Size = UDim2.new(0, 208, 0, 28)

    UICorner_3.Parent = TextTitle

    Text.Name = "Text"
    Text.Parent = TextTitle
    Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Text.BackgroundTransparency = 1.000
    Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Text.BorderSizePixel = 0
    Text.Position = UDim2.new(0.0192307699, 0, 0, 0)
    Text.Size = UDim2.new(0, 200, 0, 28)
    Text.Font = Enum.Font.Cartoon
    pcall(function()
        Text.Text = title
    end)
    Text.TextColor3 = Color3.fromRGB(0, 0, 0)
    Text.TextSize = 20.000

    CloseButton.Name = "CloseButton"
    CloseButton.Parent = Main
    CloseButton.BackgroundColor3 = Color3.fromRGB(83, 83, 83)
    CloseButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(0.912350595, 0, 0.0351437703, 0)
    CloseButton.Size = UDim2.new(0, 12, 0, 22)
    CloseButton.Font = Enum.Font.SourceSans
    CloseButton.Text = ""
    CloseButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    CloseButton.TextSize = 14.000
    UICorner_4.Parent = CloseButton
    local function KQIZG_fake_script()
        local script = Instance.new('LocalScript', CloseButton)
        local closeButton = script.Parent
        closeButton.MouseButton1Click:Connect(function()
            local properties = {
                Position = UDim2.new(-0.9, 0, 0.400000024, 0)
            }
            local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.1)
            local tween = TweenService:Create(Main, tweenInfo, properties)
            tween.Completed:Connect(function()
                closeButton.Parent.Parent:Destroy()
            end)
            tween:Play()
        end)
    end
    coroutine.wrap(KQIZG_fake_script)()
    local TweenService = game:GetService("TweenService")
    local properties = {
        Position = UDim2.new(0.01, 0, 0.400000024, 0)
    }
    local tweenInfo = TweenInfo.new(
        0.5,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    )
    local tween = TweenService:Create(Main, tweenInfo, properties)
    tween:Play()
end

function promptBetaInfo()
    chatNotify("Developer Beta | Commands may potentially be buggy or unstable. Please report any issues on our Discord server!", Color3.new(0, 0, 1)) 
    chatNotify("https://discord.gg/UCvJatDRfp", Color3.new(0, 0, 1))
end
