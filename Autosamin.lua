-- Grow Garden AdminVN Script
-- Menu Vip
-- By Samin

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- Gradient nền
local gradientFrame = Instance.new("Frame", gui)
gradientFrame.Size = UDim2.new(0, 300, 0, 350)
gradientFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
gradientFrame.BackgroundTransparency = 0
gradientFrame.Active = true
gradientFrame.Draggable = true

local uiGradient = Instance.new("UIGradient", gradientFrame)
uiGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255))
}
uiGradient.Rotation = 45

task.spawn(function()
    while task.wait(0.05) do
        uiGradient.Rotation = uiGradient.Rotation + 1
    end
end)

-- Viền phát sáng
local stroke = Instance.new("UIStroke", gradientFrame)
stroke.Thickness = 3
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Tiêu đề
local title = Instance.new("TextLabel", gradientFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🌩 Grow Garden Menu 🌩"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Container nút
local buttonContainer = Instance.new("Frame", gradientFrame)
buttonContainer.Size = UDim2.new(1, -20, 1, -60)
buttonContainer.Position = UDim2.new(0, 10, 0, 50)
buttonContainer.BackgroundTransparency = 1

-- Hàm tạo nút
local function createButton(text, callback)
    local btn = Instance.new("TextButton", buttonContainer)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.Text = text
    btn.MouseButton1Click:Connect(callback)

    local s = Instance.new("UIStroke", btn)
    s.Color = Color3.fromRGB(255, 255, 0)
    s.Thickness = 2
    return btn
end

-- Chức năng Auto Harvest
local autoHarvest = false
createButton("Auto Harvest Fruit", function()
    autoHarvest = not autoHarvest
end)

-- Chức năng Auto Sell
local autoSell = false
createButton("Auto Sell", function()
    autoSell = not autoSell
end)

-- Chức năng Auto Replant
local autoReplant = false
createButton("Auto Replant", function()
    autoReplant = not autoReplant
end)

-- TP to Fruit
createButton("TP to Fruit", function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "Fruit" and obj:IsA("Part") then
            player.Character:MoveTo(obj.Position)
            break
        end
    end
end)

-- Nút đóng menu
local menuVisible = true
createButton("Close Menu (Press M)", function()
    gradientFrame.Visible = false
    menuVisible = false
end)

-- Toggle bằng phím M
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.M then
        menuVisible = not menuVisible
        gradientFrame.Visible = menuVisible
    end
end)

-- Hàm click Part
local function clickPart(part)
    local cd = part:FindFirstChildOfClass("ClickDetector")
    if cd then fireclickdetector(cd) end
end

-- Loop chính
task.spawn(function()
    while task.wait(1) do
        if autoHarvest then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj.Name == "Fruit" and (obj:IsA("Part") or obj:IsA("Model")) then
                    clickPart(obj)
                end
            end
        end
        if autoSell then
            local npc = workspace:FindFirstChild("SellNPC")
            if npc and npc:FindFirstChildOfClass("ClickDetector") then
                clickPart(npc)
            end
        end
        if autoReplant then
            -- Giả sử có Part tên "Soil" để trồng lại
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj.Name == "Soil" and obj:IsA("Part") then
                    clickPart(obj)
                end
            end
        end
    end
end)
