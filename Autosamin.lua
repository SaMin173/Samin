-- Kaiser Hub VIP Siêu Cấp Tối Thượng

-- Cấu hình
local ID_LOGO = "rbxassetid://1234567890" -- Asset ID logo Kaiser
local ID_MUSIC = "rbxassetid://1843525107" -- ID nhạc chào mừng
local KEY_ADMIN = "1"

-- Nhạc chào mừng
spawn(function()
    local Sound = Instance.new("Sound")
    Sound.SoundId = ID_MUSIC
    Sound.Volume = 5
    Sound.PlayOnRemove = true
    Sound.Parent = workspace
    Sound:Destroy()
end)

-- Hiệu ứng console
for i = 1, 5 do
    print("⚡ Đang khởi động Kaiser Hub"..string.rep(".", i))
    task.wait(0.3)
end
print("☠️ Xin chào Kaiser!")

-- Load Orion UI
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
local Window = OrionLib:MakeWindow({
    Name = "⚡ Kaiser Hub – VIP Siêu Cấp",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "KaiserHub",
    IntroText = "Xin chào Kaiser",
    IntroIcon = ID_LOGO,
    HideUIBind = Enum.KeyCode.RightShift
})

-- Hiệu ứng tuyết rơi
spawn(function()
    while task.wait(0.05) do
        local Snow = Instance.new("Part")
        Snow.Size = Vector3.new(0.2,0.2,0.2)
        Snow.Color = Color3.fromRGB(255,255,255)
        Snow.Anchored = true
        Snow.CanCollide = false
        Snow.Material = Enum.Material.Neon
        Snow.CFrame = CFrame.new(math.random(-20,20), 20, math.random(-20,20))
        Snow.Parent = game.CoreGui
        game:GetService("TweenService"):Create(Snow, TweenInfo.new(3), {CFrame = Snow.CFrame - Vector3.new(0,25,0)}):Play()
        game:GetService("Debris"):AddItem(Snow, 3)
    end
end)

-- Hiệu ứng sấm sét
spawn(function()
    while task.wait(math.random(3,8)) do
        local Lightning = Instance.new("Part")
        Lightning.Size = Vector3.new(0.2, math.random(5,15), 0.2)
        Lightning.Color = Color3.fromRGB(255,255,0)
        Lightning.Anchored = true
        Lightning.CanCollide = false
        Lightning.Material = Enum.Material.Neon
        Lightning.CFrame = CFrame.new(math.random(-10,10), math.random(5,15), math.random(-10,10))
        Lightning.Parent = game.CoreGui
        game:GetService("Debris"):AddItem(Lightning, 0.3)
    end
end)

-- Auto Farm
local AutoFarmTab = Window:MakeTab({Name = "Auto Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false})
AutoFarmTab:AddToggle({
    Name = "Bật Auto Farm",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        while _G.AutoFarm do
            -- Thay bằng code farm game của bạn
            print("Đang auto farm...")
            task.wait(1)
        end
    end
})

-- Shop
local ShopTab = Window:MakeTab({Name = "Shop", Icon = "rbxassetid://4483345998", PremiumOnly = false})
ShopTab:AddButton({
    Name = "Mua Item VIP",
    Callback = function()
        print("Mua thành công!")
    end
})

-- Event
local EventTab = Window:MakeTab({Name = "Event", Icon = "rbxassetid://4483345998", PremiumOnly = false})
EventTab:AddButton({
    Name = "Tham gia Event",
    Callback = function()
        print("Vào event!")
    end
})

-- Sell
local SellTab = Window:MakeTab({Name = "Sell", Icon = "rbxassetid://4483345998", PremiumOnly = false})
SellTab:AddToggle({
    Name = "Auto Sell",
    Default = false,
    Callback = function(Value)
        _G.AutoSell = Value
        while _G.AutoSell do
            print("Bán hàng...")
            task.wait(2)
        end
    end
})

-- Setting
local SettingTab = Window:MakeTab({Name = "Setting", Icon = "rbxassetid://4483345998", PremiumOnly = false})
SettingTab:AddButton({
    Name = "Reset Script",
    Callback = function()
        OrionLib:Destroy()
    end
})

-- Admin
local AdminTab = Window:MakeTab({Name = "Admin", Icon = "rbxassetid://4483345998", PremiumOnly = false})
AdminTab:AddTextbox({
    Name = "Nhập Key Admin",
    Default = "",
    TextDisappear = true,
    Callback = function(txt)
        if txt == KEY_ADMIN then
            OrionLib:MakeNotification({
                Name = "Kaiser Admin",
                Content = "Truy cập thành công!",
                Image = ID_LOGO,
                Time = 5
            })
        else
            OrionLib:MakeNotification({
                Name = "Kaiser Admin",
                Content = "Sai Key!",
                Image = ID_LOGO,
                Time = 5
            })
        end
    end
})

OrionLib:Init()
