local TweenService = game:GetService("TweenService")

local function showBetaBar()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LoadingScreenGui"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.3, 0, 0.05, 0)
    frame.Position = UDim2.new(0.5, 0, 1, -frame.Size.Y.Offset - 10)
    frame.AnchorPoint = Vector2.new(0.5, 1)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BorderColor3 = Color3.fromRGB(128, 128, 128)
    frame.BorderSizePixel = 2
    frame.Parent = screenGui
    frame.ClipsDescendants = true

    local fillBar = Instance.new("Frame")
    fillBar.Size = UDim2.new(0, 0, 1, 0)
    fillBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    fillBar.BorderSizePixel = 0
    fillBar.Parent = frame

    local progressText = Instance.new("TextLabel")
    progressText.Size = UDim2.new(1, 0, 1, 0)
    progressText.Position = UDim2.new(0, 0, 0, -5)
    progressText.BackgroundTransparency = 1
    progressText.Text = ""
    progressText.TextColor3 = Color3.fromRGB(255, 255, 255)
    progressText.Font = Enum.Font.SourceSans
    progressText.TextSize = 18
    progressText.Parent = frame

    local function updateLoadingBar(currentProgress, totalProgress, labelText)
        local percentage = currentProgress / totalProgress
        fillBar:TweenSize(UDim2.new(percentage, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
        progressText.Text = labelText or ("Loading: " .. math.floor(percentage * 100) .. "%")
    end

    local slideUpTween = TweenService:Create(frame, TweenInfo.new(1, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, 0, 0.95, -frame.Size.Y.Offset - 10)})
    slideUpTween:Play()

    local function setProgress(progress, labelText)
        if progress >= 0 and progress <= 100 then
            updateLoadingBar(progress, 100, labelText)
            if progress >= 100 then
                local slideDownTween = TweenService:Create(frame, TweenInfo.new(1, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, 0, 1.5, 0)})
                slideDownTween:Play()
                slideDownTween.Completed:Connect(function()
                    screenGui:Destroy()
                end)
            end
        else
            warn("Invalid progress value. Progress should be between 0 and 100.")
        end
    end

    return setProgress
end

procBar = showBetaBar()
