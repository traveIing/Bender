local BAR_WIDTH = 300
local BAR_HEIGHT = 30
local BAR_PADDING = 10
local TOGGLE_KEY = Enum.KeyCode.RightBracket

local gui2 = Instance.new("ScreenGui")
gui2.Name = "CommandBar"
gui2.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Name = "Main"
frame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
frame.BorderSizePixel = 0
frame.Position = UDim2.new(1, -BAR_WIDTH - BAR_PADDING, 1, -BAR_HEIGHT - BAR_PADDING)
frame.Size = UDim2.new(0, BAR_WIDTH, 0, BAR_HEIGHT)
frame.Parent = gui2

local textBox = Instance.new("TextBox")
textBox.Name = "Input"
textBox.BackgroundTransparency = 1
textBox.BorderSizePixel = 0
textBox.ClearTextOnFocus = false
textBox.Font = Enum.Font.SourceSans
textBox.PlaceholderText = "Type a command... ']'"
textBox.Position = UDim2.new(0, 5, 0, 5)
textBox.Size = UDim2.new(1, -50, 1, -10)
textBox.Text = ""
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.TextSize = 18
textBox.Parent = frame

local button = Instance.new("TextButton")
button.Name = "Submit"
button.BackgroundColor3 = Color3.fromRGB(0, 162, 232)
button.BorderSizePixel = 0
button.Position = UDim2.new(1, -40, 0, 5)
button.Size = UDim2.new(0, 35, 1, -10)
button.Font = Enum.Font.SourceSansBold
button.Text = "SEND"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 16
button.AutoButtonColor = false
button.Parent = frame

local function onSubmit()
    local input = textBox.Text
    if input ~= "" then
        if input:sub(1, 1) == "]" then
            game.Players:Chat(input:sub(2))
        else
            game.Players:Chat(input)
        end
        textBox.Text = ""
    end
end

button.MouseButton1Click:Connect(onSubmit)
textBox.FocusLost:Connect(onSubmit)

local function onInput(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == TOGGLE_KEY then
        task.wait(0.001)
        textBox:CaptureFocus()
    end
end

game:GetService("UserInputService").InputBegan:Connect(onInput)
