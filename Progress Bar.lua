local LoadingBar = Instance.new("ScreenGui")
local BackFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local BarProgress = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local LoadingText = Instance.new("TextLabel")
LoadingBar.Name = "LoadingBar"
LoadingBar.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
LoadingBar.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
BackFrame.Name = "BackFrame"
BackFrame.Parent = LoadingBar
BackFrame.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
BackFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
BackFrame.BorderSizePixel = 0
BackFrame.Position = UDim2.new(0.5, -220, 1, 0)
BackFrame.Size = UDim2.new(0, 441, 0, 57)
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = BackFrame
BarProgress.Name = "BarProgress"
BarProgress.Parent = BackFrame
BarProgress.BackgroundColor3 = Color3.fromRGB(107, 107, 107)
BarProgress.BorderColor3 = Color3.fromRGB(0, 0, 0)
BarProgress.BorderSizePixel = 0
BarProgress.Size = UDim2.new(0, 0, 0, 57)
UICorner_2.CornerRadius = UDim.new(0, 14)
UICorner_2.Parent = BarProgress
LoadingText.Name = "LoadingText"
LoadingText.Parent = BackFrame
LoadingText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.BackgroundTransparency = 1.000
LoadingText.BorderColor3 = Color3.fromRGB(0, 0, 0)
LoadingText.BorderSizePixel = 0
LoadingText.Position = UDim2.new(0.274376422, 0, 0, 0)
LoadingText.Size = UDim2.new(0, 200, 0, 57)
LoadingText.Font = Enum.Font.SourceSans
LoadingText.Text = "Loading..."
LoadingText.TextColor3 = Color3.fromRGB(205, 210, 226)
LoadingText.TextSize = 25.000
local TweenService = game:GetService("TweenService")
function setProgress(progress, labelText)
    if progress >= 0 and progress <= 100 then
        local percentage = progress / 100
        local targetSize = UDim2.new(percentage, 0, 1, 0)
        local tween = TweenService:Create(BarProgress, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Size = targetSize})
        tween:Play()
        LoadingText.Text = labelText or ("Loading: " .. math.floor(percentage * 100) .. "%")
        if progress >= 100 then
            task.wait(0.5)
            local slideDownTween = TweenService:Create(BackFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -220, 1.2, 0)})
            slideDownTween:Play()
            slideDownTween.Completed:Connect(function()
                LoadingBar:Destroy()
            end)
        end
    else
        warn("Invalid progress value. Progress should be between 0 and 100.")
    end
end
local slideUpTween = TweenService:Create(BackFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -220, 0.89, 0)})
slideUpTween:Play()
