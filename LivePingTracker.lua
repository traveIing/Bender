local function create_ping_tracker()
	local LivePingTracker = Instance.new("ScreenGui")
	local OuterLayer_1 = Instance.new("Frame")
	local UICorner_1 = Instance.new("UICorner")
	local PingStatus_1 = Instance.new("TextLabel")

	LivePingTracker.ResetOnSpawn = false

	LivePingTracker.Name = "LivePingTracker"
	LivePingTracker.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

	OuterLayer_1.Name = "OuterLayer"
	OuterLayer_1.Parent = LivePingTracker
	OuterLayer_1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	OuterLayer_1.BackgroundTransparency = 0.30000001192092896
	OuterLayer_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	OuterLayer_1.BorderSizePixel = 0
	OuterLayer_1.Position = UDim2.new(0.91, 0, -0.045, 0)
	OuterLayer_1.Size = UDim2.new(0, 75, 0, 37)

	UICorner_1.Parent = OuterLayer_1

	PingStatus_1.Name = "PingStatus"
	PingStatus_1.Parent = OuterLayer_1
	PingStatus_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PingStatus_1.BackgroundTransparency = 1
	PingStatus_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PingStatus_1.BorderSizePixel = 0
	PingStatus_1.Position = UDim2.new(0, 0, -0.0201473758, 0)
	PingStatus_1.Size = UDim2.new(0, 75, 0, 37)
	PingStatus_1.Font = Enum.Font.SourceSans
	PingStatus_1.Text = "25"
	PingStatus_1.TextColor3 = Color3.fromRGB(198, 198, 198)
	PingStatus_1.TextSize = 25

	task.spawn(function()
		local function round(int)
			return math.floor(int + 0.5)
		end
		local stationaryTime = 0
		local pingTextRed = false
		while true do
			local ping = round(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
			PingStatus_1.Text = ping
			if (ping == recent_ping) then
				stationaryTime = stationaryTime + 0.1
			else
				stationaryTime = 0
				pingTextRed = false
			end
			if (stationaryTime >= 2) and (not pingTextRed) then
				PingStatus_1.TextColor3 = Color3.fromRGB(255, 0, 0)
				pingTextRed = true
			elseif (not pingTextRed) then
				PingStatus_1.TextColor3 = Color3.fromRGB(198, 198, 198)
			end
			recent_ping = ping
			task.wait(0.1)
		end
	end)
end

task.spawn(function()
	create_ping_tracker()
end)
print("fired")
