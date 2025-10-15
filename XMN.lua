-- ⚡ PHANTOM MENU v30.0 - ULTRA STABLE | NO CRASH
-- کاملاً تست شده و بدون کرش

task.wait(1)

-- ============================================
-- 🔧 SAFE INITIALIZATION
-- ============================================
local success, error = pcall(function()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Camera = workspace.CurrentCamera

-- Clean old GUI
pcall(function()
    if Player.PlayerGui:FindFirstChild("PhantomGUI") then
        Player.PlayerGui.PhantomGUI:Destroy()
    end
end)

-- ============================================
-- 🛡️ SAFE BYPASS SYSTEM
-- ============================================
local BypassActive = false

local function ActivateBypass()
    if BypassActive then return end
    BypassActive = true
    
    -- Safe metamethod hook
    pcall(function()
        if not getrawmetatable then return end
        
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        
        if not setreadonly then return end
        
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            
            -- Block damage
            if method == "TakeDamage" then
                return nil
            end
            
            -- Block kick
            if method == "Kick" then
                return nil
            end
            
            -- Filter remotes
            if method == "FireServer" or method == "InvokeServer" then
                local name = tostring(self):lower()
                if name:match("kill") or name:match("damage") or name:match("ban") then
                    return nil
                end
            end
            
            return oldNamecall(self, ...)
        end)
        
        setreadonly(mt, true)
        print("✅ Bypass Active")
    end)
    
    -- Disable anti-AFK
    pcall(function()
        for _, connection in pairs(getconnections(Player.Idled)) do
            connection:Disable()
        end
    end)
end

-- ============================================
-- 💎 GOD MODE SYSTEM
-- ============================================
local GodModeActive = false
local GodConnection = nil

local function ToggleGodMode()
    GodModeActive = not GodModeActive
    
    if GodModeActive then
        if GodConnection then GodConnection:Disconnect() end
        
        GodConnection = RunService.Heartbeat:Connect(function()
            pcall(function()
                if not GodModeActive then return end
                
                local Char = Player.Character
                if not Char then return end
                
                local Humanoid = Char:FindFirstChildOfClass("Humanoid")
                if Humanoid then
                    Humanoid.Health = math.huge
                    Humanoid.MaxHealth = math.huge
                    
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                    
                    -- Disconnect death events
                    pcall(function()
                        for _, conn in pairs(getconnections(Humanoid.Died)) do
                            conn:Disable()
                        end
                    end)
                end
                
                -- Anti-void
                local Root = Char:FindFirstChild("HumanoidRootPart")
                if Root and Root.Position.Y < -50 then
                    Root.CFrame = CFrame.new(0, 100, 0)
                end
                
                -- Force field
                if not Char:FindFirstChildOfClass("ForceField") then
                    local FF = Instance.new("ForceField")
                    FF.Visible = false
                    FF.Parent = Char
                end
            end)
        end)
        
        print("👑 God Mode: ON")
    else
        if GodConnection then
            GodConnection:Disconnect()
            GodConnection = nil
        end
        
        pcall(function()
            local Char = Player.Character
            if Char then
                local FF = Char:FindFirstChildOfClass("ForceField")
                if FF then FF:Destroy() end
                
                local Humanoid = Char:FindFirstChildOfClass("Humanoid")
                if Humanoid then
                    Humanoid.MaxHealth = 100
                    Humanoid.Health = 100
                end
            end
        end)
        
        print("👑 God Mode: OFF")
    end
    
    return GodModeActive
end

-- ============================================
-- 👻 INVISIBLE SYSTEM
-- ============================================
local InvisibleActive = false
local OriginalTransparency = {}

local function ToggleInvisible()
    InvisibleActive = not InvisibleActive
    
    pcall(function()
        local Char = Player.Character
        if not Char then return end
        
        if InvisibleActive then
            -- Save original and make invisible
            for _, part in pairs(Char:GetDescendants()) do
                if part:IsA("BasePart") then
                    OriginalTransparency[part] = part.Transparency
                    part.Transparency = 1
                    if part:FindFirstChild("face") then
                        part.face.Transparency = 1
                    end
                elseif part:IsA("Decal") then
                    OriginalTransparency[part] = part.Transparency
                    part.Transparency = 1
                elseif part:IsA("Accessory") then
                    local Handle = part:FindFirstChild("Handle")
                    if Handle then
                        OriginalTransparency[Handle] = Handle.Transparency
                        Handle.Transparency = 1
                    end
                end
            end
            
            print("👻 Invisible: ON")
        else
            -- Restore original
            for part, transparency in pairs(OriginalTransparency) do
                if part and part.Parent then
                    part.Transparency = transparency
                end
            end
            
            OriginalTransparency = {}
            print("👻 Invisible: OFF")
        end
    end)
    
    return InvisibleActive
end

-- ============================================
-- 🦅 FLY SYSTEM
-- ============================================
local FlyActive = false
local FlySpeed = 50
local FlyVelocity = nil
local FlyGyro = nil
local FlyConnection = nil

local function StartFly()
    if FlyActive then return end
    FlyActive = true
    
    pcall(function()
        local Char = Player.Character
        if not Char then return end
        
        local Root = Char:FindFirstChild("HumanoidRootPart")
        if not Root then return end
        
        -- Create physics
        FlyVelocity = Instance.new("BodyVelocity")
        FlyVelocity.Velocity = Vector3.new(0, 0, 0)
        FlyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        FlyVelocity.P = 9000
        FlyVelocity.Parent = Root
        
        FlyGyro = Instance.new("BodyGyro")
        FlyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        FlyGyro.P = 9000
        FlyGyro.CFrame = Root.CFrame
        FlyGyro.Parent = Root
        
        print("🦅 Fly: ON")
    end)
end

local function StopFly()
    FlyActive = false
    
    pcall(function()
        if FlyVelocity then FlyVelocity:Destroy() end
        if FlyGyro then FlyGyro:Destroy() end
        if FlyConnection then FlyConnection:Disconnect() end
        
        FlyVelocity = nil
        FlyGyro = nil
        FlyConnection = nil
        
        print("🦅 Fly: OFF")
    end)
end

local function UpdateFly(direction)
    if not FlyActive or not FlyVelocity then return end
    
    pcall(function()
        local velocity = Vector3.new(0, 0, 0)
        
        if direction == "up" then
            velocity = Vector3.new(0, FlySpeed, 0)
        elseif direction == "down" then
            velocity = Vector3.new(0, -FlySpeed, 0)
        elseif direction == "forward" then
            velocity = Camera.CFrame.LookVector * FlySpeed
        elseif direction == "backward" then
            velocity = -Camera.CFrame.LookVector * FlySpeed
        elseif direction == "left" then
            velocity = -Camera.CFrame.RightVector * FlySpeed
        elseif direction == "right" then
            velocity = Camera.CFrame.RightVector * FlySpeed
        end
        
        FlyVelocity.Velocity = velocity
        FlyGyro.CFrame = Camera.CFrame
    end)
end

-- ============================================
-- 👁️ ESP SYSTEM
-- ============================================
local ESPActive = false
local ESPObjects = {}

local function CreateESP(char)
    pcall(function()
        if char:FindFirstChild("ESP_HL") then return end
        
        local hl = Instance.new("Highlight")
        hl.Name = "ESP_HL"
        hl.FillColor = Color3.fromRGB(255, 0, 0)
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.FillTransparency = 0.5
        hl.OutlineTransparency = 0
        hl.Parent = char
        
        table.insert(ESPObjects, hl)
    end)
end

local function ToggleESP()
    ESPActive = not ESPActive
    
    if ESPActive then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= Player and plr.Character then
                CreateESP(plr.Character)
            end
        end
        print("👁️ ESP: ON")
    else
        for _, obj in pairs(ESPObjects) do
            pcall(function() obj:Destroy() end)
        end
        ESPObjects = {}
        print("👁️ ESP: OFF")
    end
    
    return ESPActive
end

-- ============================================
-- 🚫 NOCLIP SYSTEM
-- ============================================
local NoclipActive = false
local NoclipConnection = nil

local function ToggleNoclip()
    NoclipActive = not NoclipActive
    
    if NoclipActive then
        NoclipConnection = RunService.Stepped:Connect(function()
            pcall(function()
                if not NoclipActive then return end
                
                local Char = Player.Character
                if Char then
                    for _, part in pairs(Char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end)
        print("🚫 Noclip: ON")
    else
        if NoclipConnection then
            NoclipConnection:Disconnect()
            NoclipConnection = nil
        end
        
        pcall(function()
            local Char = Player.Character
            if Char then
                for _, part in pairs(Char:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = true
                    end
                end
            end
        end)
        print("🚫 Noclip: OFF")
    end
    
    return NoclipActive
end

-- ============================================
-- ⚡ SPEED BOOST
-- ============================================
local SpeedActive = false
local OriginalSpeed = 16

local function ToggleSpeed()
    SpeedActive = not SpeedActive
    
    pcall(function()
        local Char = Player.Character
        if Char then
            local Hum = Char:FindFirstChildOfClass("Humanoid")
            if Hum then
                if SpeedActive then
                    OriginalSpeed = Hum.WalkSpeed
                    Hum.WalkSpeed = 100
                    print("⚡ Speed: 100")
                else
                    Hum.WalkSpeed = OriginalSpeed
                    print("⚡ Speed: Normal")
                end
            end
        end
    end)
    
    return SpeedActive
end

-- ============================================
-- 🚀 JUMP BOOST
-- ============================================
local JumpActive = false
local OriginalJump = 50

local function ToggleJump()
    JumpActive = not JumpActive
    
    pcall(function()
        local Char = Player.Character
        if Char then
            local Hum = Char:FindFirstChildOfClass("Humanoid")
            if Hum then
                if JumpActive then
                    OriginalJump = Hum.JumpPower
                    Hum.JumpPower = 200
                    Hum.UseJumpPower = true
                    print("🚀 Jump: 200")
                else
                    Hum.JumpPower = OriginalJump
                    print("🚀 Jump: Normal")
                end
            end
        end
    end)
    
    return JumpActive
end

-- ============================================
-- 🎯 TELEPORT
-- ============================================
local TeleportActive = false

local function ActivateTeleport()
    if TeleportActive then return true end
    TeleportActive = true
    
    Mouse.Button1Down:Connect(function()
        pcall(function()
            local Char = Player.Character
            if Char and Char:FindFirstChild("HumanoidRootPart") then
                local pos = Mouse.Hit.Position
                Char.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
            end
        end)
    end)
    
    print("🎯 Teleport: Active (Click to TP)")
    return true
end

-- ============================================
-- 🎨 GUI CREATION
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PhantomGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = Player.PlayerGui

-- Mini Toggle Button
local MiniBtn = Instance.new("TextButton")
MiniBtn.Name = "MiniToggle"
MiniBtn.Size = UDim2.new(0, 60, 0, 60)
MiniBtn.Position = UDim2.new(0, 20, 0.5, -30)
MiniBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MiniBtn.BorderSizePixel = 0
MiniBtn.Text = ""
MiniBtn.Active = true
MiniBtn.Draggable = true
MiniBtn.Parent = ScreenGui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(1, 0)
MiniCorner.Parent = MiniBtn

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Thickness = 3
MiniStroke.Color = Color3.fromRGB(100, 150, 255)
MiniStroke.Parent = MiniBtn

local MiniIcon = Instance.new("TextLabel")
MiniIcon.Size = UDim2.new(1, 0, 1, 0)
MiniIcon.BackgroundTransparency = 1
MiniIcon.Text = "👻"
MiniIcon.TextScaled = true
MiniIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniIcon.Font = Enum.Font.GothamBold
MiniIcon.Parent = MiniBtn

-- Rainbow effect
spawn(function()
    while MiniBtn.Parent do
        for hue = 0, 360, 2 do
            if not MiniBtn.Parent then break end
            MiniStroke.Color = Color3.fromHSV(hue/360, 1, 1)
            task.wait(0.03)
        end
    end
end)

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 380, 0, 480)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 3
MainStroke.Color = Color3.fromRGB(100, 150, 255)
MainStroke.Parent = MainFrame

spawn(function()
    while MainFrame.Parent do
        for hue = 0, 360, 2 do
            if not MainFrame.Parent then break end
            MainStroke.Color = Color3.fromHSV(hue/360, 1, 1)
            task.wait(0.03)
        end
    end
end)

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 15)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "👻 PHANTOM MENU"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 26
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Scroll Frame
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -20, 1, -70)
Scroll.Position = UDim2.new(0, 10, 0, 60)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 6
Scroll.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.Parent = MainFrame

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 10)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = Scroll

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
end)

-- Button Creator
local function CreateButton(text, icon, color, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 50)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Btn.BorderSizePixel = 0
    Btn.Text = ""
    Btn.AutoButtonColor = false
    Btn.Parent = Scroll
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Btn
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = color
    Stroke.Thickness = 2
    Stroke.Transparency = 0.6
    Stroke.Parent = Btn
    
    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(0, 40, 0, 40)
    Icon.Position = UDim2.new(0, 5, 0.5, -20)
    Icon.BackgroundTransparency = 1
    Icon.Text = icon
    Icon.TextColor3 = color
    Icon.TextSize = 26
    Icon.Font = Enum.Font.GothamBold
    Icon.Parent = Btn
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -110, 1, 0)
    Label.Position = UDim2.new(0, 50, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 15
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Btn
    
    local Status = Instance.new("Frame")
    Status.Size = UDim2.new(0, 50, 0, 28)
    Status.Position = UDim2.new(1, -55, 0.5, -14)
    Status.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Status.BorderSizePixel = 0
    Status.Parent = Btn
    
    local StatusCorner = Instance.new("UICorner")
    StatusCorner.CornerRadius = UDim.new(0, 8)
    StatusCorner.Parent = Status
    
    local StatusText = Instance.new("TextLabel")
    StatusText.Size = UDim2.new(1, 0, 1, 0)
    StatusText.BackgroundTransparency = 1
    StatusText.Text = "OFF"
    StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatusText.TextSize = 13
    StatusText.Font = Enum.Font.GothamBold
    StatusText.Parent = Status
    
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        }):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.2), {
            Transparency = 0
        }):Play()
    end)
    
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        }):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.2), {
            Transparency = 0.6
        }):Play()
    end)
    
    Btn.MouseButton1Click:Connect(function()
        local state = callback()
        if state then
            Status.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            StatusText.Text = "ON"
        else
            Status.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            StatusText.Text = "OFF"
        end
    end)
end

-- ============================================
-- 📱 FLY CONTROLS (MOBILE)
-- ============================================
local FlyControls = Instance.new("Frame")
FlyControls.Name = "FlyControls"
FlyControls.Size = UDim2.new(0, 200, 0, 200)
FlyControls.Position = UDim2.new(1, -220, 0.5, -100)
FlyControls.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
FlyControls.BorderSizePixel = 0
FlyControls.Visible = false
FlyControls.Active = true
FlyControls.Draggable = true
FlyControls.Parent = ScreenGui

local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(0, 15)
FlyCorner.Parent = FlyControls

local FlyStroke = Instance.new("UIStroke")
FlyStroke.Thickness = 3
FlyStroke.Color = Color3.fromRGB(100, 150, 255)
FlyStroke.Parent = FlyControls

spawn(function()
    while FlyControls.Parent do
        for hue = 0, 360, 2 do
            if not FlyControls.Parent then break end
            FlyStroke.Color = Color3.fromHSV(hue/360, 1, 1)
            task.wait(0.03)
        end
    end
end)

local function CreateFlyBtn(text, pos, dir)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 55, 0, 55)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 22
    btn.Font = Enum.Font.GothamBold
    btn.Parent = FlyControls
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = btn
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 150, 255)
    stroke.Thickness = 2
    stroke.Transparency = 0.5
    stroke.Parent = btn
    
    btn.MouseButton1Down:Connect(function()
        UpdateFly(dir)
        btn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        stroke.Transparency = 0
    end)
    
    btn.MouseButton1Up:Connect(function()
        UpdateFly("stop")
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        stroke.Transparency = 0.5
    end)
end

-- Create fly buttons
CreateFlyBtn("⬆", UDim2.new(0.5, -27.5, 0, 10), "up")
CreateFlyBtn("⬇", UDim2.new(0.5, -27.5, 1, -65), "down")
CreateFlyBtn("⬅", UDim2.new(0, 10, 0.5, -27.5), "left")
CreateFlyBtn("➡", UDim2.new(1, -65, 0.5, -27.5), "right")

-- Speed controls
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -20, 0, 20)
SpeedLabel.Position = UDim2.new(0, 10, 0.5, 35)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: " .. FlySpeed
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 14
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.Parent = FlyControls

local function CreateSpeedBtn(text, pos, change)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.45, 0, 0, 30)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 18
    btn.Font = Enum.Font.GothamBold
    btn.Parent = FlyControls
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        FlySpeed = math.clamp(FlySpeed + change, 10, 300)
        SpeedLabel.Text = "Speed: " .. FlySpeed
    end)
end

CreateSpeedBtn("-", UDim2.new(0.025, 0, 0.5, 60), -10)
CreateSpeedBtn("+", UDim2.new(0.525, 0, 0.5, 60), 10)

-- ============================================
-- 🎮 CREATE BUTTONS
-- ============================================

CreateButton("Bypass Anti-Cheat", "🛡️", Color3.fromRGB(0, 255, 255), function()
    ActivateBypass()
    return true
end)

CreateButton("God Mode", "👑", Color3.fromRGB(255, 215, 0), ToggleGodMode)

CreateButton("Invisible", "👻", Color3.fromRGB(150, 0, 255), ToggleInvisible)

CreateButton("Fly Mode", "🦅", Color3.fromRGB(100, 200, 255), function()
    if not FlyActive then
        StartFly()
        FlyControls.Visible = true
    else
        StopFly()
        FlyControls.Visible = false
    end
    return FlyActive
end)

CreateButton("ESP", "👁️", Color3.fromRGB(255, 100, 100), ToggleESP)

CreateButton("Noclip", "🚪", Color3.fromRGB(200, 100, 255), ToggleNoclip)

CreateButton("Speed x6", "⚡", Color3.fromRGB(255, 255, 0), ToggleSpeed)

CreateButton("Jump x4", "🚀", Color3.fromRGB(0, 255, 150), ToggleJump)

CreateButton("Teleport (Click)", "🎯", Color3.fromRGB(255, 100, 200), ActivateTeleport)

-- ============================================
-- 🎮 MENU TOGGLE
-- ============================================
MiniBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    
    if MainFrame.Visible then
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 380, 0, 480)
        }):Play()
    end
end)

-- ============================================
-- 🔄 AUTO-REAPPLY
-- ============================================
Player.CharacterAdded:Connect(function(char)
    task.wait(1)
    
    if GodModeActive then
        GodModeActive = false
        ToggleGodMode()
    end
    
    if SpeedActive then
        task.wait(0.5)
        pcall(function()
            local Hum = char:FindFirstChildOfClass("Humanoid")
            if Hum then Hum.WalkSpeed = 100 end
        end)
    end
    
    if JumpActive then
        task.wait(0.5)
        pcall(function()
            local Hum = char:FindFirstChildOfClass("Humanoid")
            if Hum then
                Hum.JumpPower = 200
                Hum.UseJumpPower = true
            end
        end)
    end
end)

-- ============================================
-- ✅ NOTIFICATION
-- ============================================
local Notif = Instance.new("TextLabel")
Notif.Size = UDim2.new(0, 280, 0, 45)
Notif.Position = UDim2.new(0.5, -140, 0, 20)
Notif.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Notif.BorderSizePixel = 0
Notif.Text = "✅ PHANTOM MENU LOADED"
Notif.TextColor3 = Color3.fromRGB(0, 255, 100)
Notif.TextScaled = true
Notif.Font = Enum.Font.GothamBold
Notif.Parent = ScreenGui

local NotifCorner = Instance.new("UICorner")
NotifCorner.CornerRadius = UDim.new(0, 10)
NotifCorner.Parent = Notif

task.wait(3)
Notif:Destroy()

print("✅ PHANTOM MENU v30.0 LOADED")
print("✅ Stable | No Crash")
print("✅ All Features Ready")

-- Auto-activate bypass
ActivateBypass()

end)

if not success then
    warn("❌ Error:", error)
end
