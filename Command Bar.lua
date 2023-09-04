local CommandBar = Instance.new("ScreenGui")
CommandBar.ResetOnSpawn = false
local Main = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local BarTextBox = Instance.new("TextBox")
local ToggleKey = Enum.KeyCode.Semicolon

CommandBar.Name = "CommandBar"
CommandBar.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
CommandBar.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
CommandBar.zIndex = 90000;

Main.Name = "Main"
Main.Parent = CommandBar
Main.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Main.BackgroundTransparency = 0.3
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.794447303, 0, 0.930463552, 0)
Main.Size = UDim2.new(0, 292, 0, 42)

UICorner.Parent = Main

BarTextBox.Name = "BarTextBox"
BarTextBox.Parent = Main
BarTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BarTextBox.BackgroundTransparency = 1.000
BarTextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
BarTextBox.BorderSizePixel = 0
BarTextBox.Size = UDim2.new(0, 292, 0, 41)
BarTextBox.Font = Enum.Font.SourceSans
BarTextBox.PlaceholderText = "Type a command... ';'"
BarTextBox.Text = ""
BarTextBox.TextColor3 = Color3.fromRGB(160, 160, 160)
BarTextBox.TextSize = 21.000

local function onSubmit()
    local input = BarTextBox.Text
    if (input ~= "") then
        game.Players:Chat(input)
        BarTextBox.Text = ""
    end
end

local function onInput(input, gameProcessedEvent)
    if (not gameProcessedEvent) and (input.KeyCode == ToggleKey) then
        task.wait(0.0001)
        BarTextBox:CaptureFocus()
    end
end

BarTextBox.FocusLost:Connect(onSubmit)
game:GetService("UserInputService").InputBegan:Connect(onInput)
