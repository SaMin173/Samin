-- Auto Harvest Menu (sấm sét + tuyết rơi)
-- By AdminVN Custom

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

-- Khung menu
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 150)
frame.Position = UDim2.new(0.5, -125, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.3
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Icon sấm sét động
local lightning = Instance.new("ImageLabel", frame)
lightning.Size = UDim2.new(0, 100, 0, 100)
lightning.Position = UDim2.new(0.5, -50, 0, -40)
lightning.BackgroundTransparency = 1
lightning.Image = "rbxassetid://391053117" -- icon sấm sét
lightning.ImageColor3 = Color3.fromRGB(255, 255, 0)

-- Hiệu ứng xoay sấm sét
task.spawn(function()
	while task.wait() do
		lightning.Rotation = (lightning.Rotation + 1) % 360
	end
end)

-- Nút bật/tắt
local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0, 200, 0, 50)
toggle.Position = UDim2.new(0.5, -100, 1, -60)
toggle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
toggle.Text = "Auto Harvest: OFF"
toggle.TextScaled = true
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.GothamBold
toggle.AutoButtonColor = true

local auto = false
toggle.MouseButton1Click:Connect(function()
	auto = not auto
	if auto then
		toggle.Text = "Auto Harvest: ON"
		toggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
	else
		toggle.Text = "Auto Harvest: OFF"
		toggle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
	end
end)

-- Hạt tuyết rơi
task.spawn(function()
	while true do
		local snow = Instance.new("Frame", gui)
		snow.Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5))
		snow.Position = UDim2.new(math.random(), 0, 0, 0)
		snow.BackgroundColor3 = Color3.new(1, 1, 1)
		snow.BorderSizePixel = 0
		game:GetService("TweenService"):Create(snow, TweenInfo.new(math.random(3, 6)), {Position = UDim2.new(snow.Position.X.Scale, 0, 1, 0)}):Play()
		game.Debris:AddItem(snow, 6)
		task.wait(0.05)
	end
end)

-- Hàm click trái cây
local function clickPart(part)
	local cd = part:FindFirstChildOfClass("ClickDetector")
	if cd then
		fireclickdetector(cd)
	end
end

-- Auto harvest loop
task.spawn(function()
	while true do
		if auto then
			for _, obj in ipairs(workspace:GetDescendants()) do
				if obj.Name == "Fruit" and (obj:IsA("Model") or obj:IsA("Part")) then
					clickPart(obj)
				end
			end
		end
		task.wait(1)
	end
end)
