local GameLeaveAnimation = Instance.new("ScreenGui")
local ExpandingCircle_1 = Instance.new("Frame")
local UICorner_1 = Instance.new("UICorner")

GameLeaveAnimation.Name = "GameLeaveAnimation"
GameLeaveAnimation.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

ExpandingCircle_1.Name = "ExpandingCircle"
ExpandingCircle_1.Parent = GameLeaveAnimation
ExpandingCircle_1.BackgroundColor3 = Color3.fromRGB(40,40,40)
ExpandingCircle_1.BackgroundTransparency = 0.30000001192092896
ExpandingCircle_1.BorderColor3 = Color3.fromRGB(0,64,255)
ExpandingCircle_1.BorderSizePixel = 0
ExpandingCircle_1.Position = UDim2.new(0.370000005, 0,-0.5, 0)
ExpandingCircle_1.Size = UDim2.new(0, 397,0, 131)
ExpandingCircle_1.ZIndex = 15

UICorner_1.Parent = ExpandingCircle_1
UICorner_1.CornerRadius = UDim.new(0,10)

local function odmjifPKpatfcnCu()
local script = Instance.new("LocalScript",ExpandingCircle_1)
function PlayLeavingAnimation(delay)
    if (type(delay) == "number") then
        task.wait(delay)
    end
game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
	local TweenService, circle, tween_info, tween_info_sizing, final_transparency, slide_down_middle_position, size_to_fill, size_to_fill_tween, slide_down_middle_tween, darken_tween

	do
		TweenService = game:GetService("TweenService")
		circle = script.Parent
		tween_info = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
		tween_info_sizing = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
		final_transparency = 0
		slide_down_middle_position = UDim2.new(0.37, 0, -0.055, 0)
		size_to_fill = UDim2.new(9e9 + 9e9, 9e9 + 9e9, 9e9 + 9e9, 9e9 + 9e9)
		size_to_fill_tween = TweenService:Create(circle, tween_info_sizing, {Size = size_to_fill})
		slide_down_middle_tween = TweenService:Create(circle, tween_info, {Position = slide_down_middle_position})
		darken_tween = TweenService:Create(circle, tween_info, {Transparency = final_transparency})
	end
	slide_down_middle_tween:Play()
	slide_down_middle_tween.Completed:Connect(function()
		size_to_fill_tween:Play()
		size_to_fill_tween.Completed:Connect(function()
			darken_tween:Play()
		end)
	end)
end
end
coroutine.wrap(odmjifPKpatfcnCu)()
