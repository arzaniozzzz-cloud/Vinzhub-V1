-- Vinzhub V1
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Ganti ID ini
local ID_BG = "rbxassetid://0"
local ID_LOGO = "rbxassetid://0"

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VinzhubV1"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 260, 0, 440)
Main.Position = UDim2.new(0, 20, 0, 100)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

-- Latar belakang
local Bg = Instance.new("ImageLabel")
Bg.Size = UDim2.new(1, 0, 1, 0)
Bg.Position = UDim2.new(0, 0, 0, 0)
Bg.BackgroundTransparency = 1
Bg.Image = ID_BG
Bg.ImageTransparency = 0.4
Bg.ZIndex = 0
Bg.Parent = Main

-- Logo
local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(0, 55, 0, 55)
Logo.Position = UDim2.new(0, 10, 0, 45)
Logo.BackgroundTransparency = 1
Logo.Image = ID_LOGO
Logo.ZIndex = 2
Logo.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundColor3 = Color3.fromRGB(40,40,40)
Title.Text = "Vinzhub V1"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.ZIndex = 3
Title.Parent = Main

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 35, 0, 35)
Close.Position = UDim2.new(1, -40, 0, 2)
Close.BackgroundColor3 = Color3.fromRGB(200,50,50)
Close.Text = "X"
Close.TextColor3 = Color3.new(1,1,1)
Close.Font = Enum.Font.SourceSansBold
Close.TextSize = 18
Close.ZIndex = 4
Close.Parent = Main

local Open = Instance.new("TextButton")
Open.Size = UDim2.new(0, 120, 0, 40)
Open.Position = UDim2.new(0, 20, 0, 20)
Open.BackgroundColor3 = Color3.fromRGB(0,150,255)
Open.Text = "Buka Vinzhub"
Open.TextColor3 = Color3.new(1,1,1)
Open.Font = Enum.Font.SourceSansBold
Open.TextSize = 16
Open.Visible = false
Open.Parent = ScreenGui

-- State
local autoBreak = false
local autoSteal = false
local antiPukul = false
local autoFarm = false
local speedHack = false
local infiniteJump = false

-- Buttons
local function createButton(text, y)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    btn.Text = text .. ": OFF"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.ZIndex = 2
    btn.Parent = Main
    return btn
end

local AutoBreakBtn = createButton("Auto Break", 110)
local AutoStealBtn = createButton("Auto Steal", 155)
local AntiPukulBtn = createButton("Anti Pukul", 200)
local AutoFarmBtn = createButton("Auto Farm", 245)
local SpeedBtn = createButton("Speed Hack", 290)
local JumpBtn = createButton("Infinite Jump", 335)
local RejoinBtn = createButton("Rejoin Server", 380)
local HopBtn = createButton("Server Hop", 425)

local function toggle(btn, state, name)
    state = not state
    btn.Text = name .. ": " .. (state and "ON" or "OFF")
    btn.BackgroundColor3 = state and Color3.fromRGB(0,170,0) or Color3.fromRGB(60,60,60)
    return state
end

AutoBreakBtn.MouseButton1Click:Connect(function()
    autoBreak = toggle(AutoBreakBtn, autoBreak, "Auto Break")
end)

AutoStealBtn.MouseButton1Click:Connect(function()
    autoSteal = toggle(AutoStealBtn, autoSteal, "Auto Steal")
end)

AntiPukulBtn.MouseButton1Click:Connect(function()
    antiPukul = toggle(AntiPukulBtn, antiPukul, "Anti Pukul")
end)

AutoFarmBtn.MouseButton1Click:Connect(function()
    autoFarm = toggle(AutoFarmBtn, autoFarm, "Auto Farm")
end)

SpeedBtn.MouseButton1Click:Connect(function()
    speedHack = toggle(SpeedBtn, speedHack, "Speed Hack")
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = speedHack and 100 or 16
    end
end)

JumpBtn.MouseButton1Click:Connect(function()
    infiniteJump = toggle(JumpBtn, infiniteJump, "Infinite Jump")
end)

RejoinBtn.MouseButton1Click:Connect(function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)

HopBtn.MouseButton1Click:Connect(function()
    local TS = game:GetService("TeleportService")
    local Http = game:GetService("HttpService")
    local servers = Http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    for _, s in pairs(servers.data) do
        if s.playing < s.maxPlayers and s.id ~= game.JobId then
            TS:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer)
            break
        end
    end
end)

Close.MouseButton1Click:Connect(function()
    Main.Visible = false
    Open.Visible = true
end)

Open.MouseButton1Click:Connect(function()
    Main.Visible = true
    Open.Visible = false
end)

-- Auto Break
spawn(function()
    while wait(0.1) do
        if autoBreak then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("ClickDetector") and obj.Parent and obj.Parent.Name:lower():find("egg") then
                    pcall(function() fireclickdetector(obj) end)
                end
                if obj:IsA("ProximityPrompt") and obj.Parent and obj.Parent.Name:lower():find("egg") then
                    pcall(function() fireproximityprompt(obj) end)
                end
            end
        end
    end
end)

-- Auto Steal
spawn(function()
    while wait(0.2) do
        if autoSteal then
            local lp = LocalPlayer
            if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= lp and plr.Character then
                        local egg = plr.Character:FindFirstChild("Egg", true)
                        if egg then
                            lp.Character.HumanoidRootPart.CFrame = egg.CFrame
                            break
                        end
                    end
                end
            end
        end
    end
end)

-- Anti Pukul
spawn(function()
    while wait(0.1) do
        if antiPukul then
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.MaxHealth = math.huge
                    hum.Health = math.huge
                end
            end
        end
    end
end)

-- Auto Farm
spawn(function()
    while wait(0.3) do
        if autoFarm then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("ClickDetector") and obj.Parent and obj.Parent.Name:lower():find("egg") then
                    pcall(function() fireclickdetector(obj) end)
                end
                if obj:IsA("ProximityPrompt") and obj.Parent and obj.Parent.Name:lower():find("egg") then
                    pcall(function() fireproximityprompt(obj) end)
                end
            end
            local lp = LocalPlayer
            if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= lp and plr.Character then
                        local egg = plr.Character:FindFirstChild("Egg", true)
                        if egg then
                            lp.Character.HumanoidRootPart.CFrame = egg.CFrame
                            break
                        end
                    end
                end
            end
        end
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if infiniteJump then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState("Jumping")
            end
        end
    end
end)

-- Anti AFK
spawn(function()
    while wait(60) do
        local vu = game:GetService("VirtualUser")
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end
end)
