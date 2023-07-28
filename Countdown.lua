

function Countdown(duration)
local ScreenGui = Instance.new("ScreenGui")
local CountdownFrame = Instance.new("Frame")
local CountdownText = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

CountdownFrame.Name = "CountdownFrame"
CountdownFrame.Parent = ScreenGui
CountdownFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 45)
CountdownFrame.Position = UDim2.new(0, -200, 0.9, -80)
CountdownFrame.Size = UDim2.new(0, 150, 0, 80)

local UICorner = Instance.new("UICorner")
UICorner.Parent = CountdownFrame

CountdownText.Name = "CountdownText"
CountdownText.Parent = CountdownFrame
CountdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CountdownText.BackgroundTransparency = 1
CountdownText.Size = UDim2.new(1, 0, 1, 0)
CountdownText.Font = Enum.Font.SourceSansBold
CountdownText.Text = "3"
CountdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
CountdownText.TextSize = 48

local TweenService = game:GetService("TweenService")
    local countdownDuration = duration
    local countdownTexts = {}
    for i = countdownDuration, 1, -1 do
        table.insert(countdownTexts, tostring(i))
    end
    table.insert(countdownTexts, "☑️")

    local targetPosition = UDim2.new(0, 30, 0.9, -80)
    local tweenPosition = TweenService:Create(CountdownFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = targetPosition })
    tweenPosition:Play()

    for i = 1, countdownDuration + 1 do
        CountdownText.Text = countdownTexts[i]
        task.wait(1)
    end

    local originalPosition = UDim2.new(0, -200, 0.9, -80)
    local tweenBackPosition = TweenService:Create(CountdownFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = originalPosition })
    tweenBackPosition:Play()

    task.wait(1)
    ScreenGui:Destroy()
end
