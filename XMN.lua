-- ⚡ ULTIMATE GOD MENU v20.0 - NO CRASH | FULL BYPASS
-- ساخته شده با پیشرفته‌ترین تکنیک‌ها

wait(0.5)

-- ============================================
-- 🔧 CORE SERVICES
-- ============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Camera = Workspace.CurrentCamera

-- ============================================
-- 🛡️ SAFE BYPASS SYSTEM
-- ============================================
local BypassActive = false

local function SafeBypass()
    if BypassActive then return end
    BypassActive = true
    
    -- Safe metamethod hook
    local success = pcall(function()
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            -- Block damage only
            if method == "TakeDamage" then
                return nil
            end
            
            -- Block kick
            if method == "Kick" then
                return nil
            end
            
            -- Filter dangerous remotes
            if method == "FireServer" or method == "InvokeServer" then
                local name = tostring(self)
                if name:lower():match("kill") or name:lower():match("damage") then
                    return nil
                end
            end
            
            return oldNamecall(self, ...)
        end)
        
        setreadonly(mt, true)
    end)
    
    if success then
        print("✅ Bypass: Active")
    else
        print("⚠️ Bypass: Limited mode")
    end
end

-- ============================================
-- 💪 GOD MODE SYSTEM
-- ============================================
local GodModeActive = false
local GodModeConnection = nil

local function ToggleGodMode()
    GodModeActive = not GodModeActive
    
    if GodModeActive then
        if GodModeConnection then GodModeConnection:Disconnect() end
        
        GodModeConnection = RunService.Heartbeat:Connect(function()
            pcall(function()
                local Character = Player.Character
                if Character then
                    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                    local RootPart = Character:FindFirstChild("HumanoidRootPart")
                    
                    if Humanoid then
                        -- Layer 1: Infinite Health
                        Humanoid.MaxHealth = math.huge
                        Humanoid.Health = math.huge
                        
                        -- Layer 2: Disable death
                        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                        Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                        
                        -- Layer 3: Remove damage connections
                        for _, connection in pairs(getconnections(Humanoid.Died)) do
                            connection:Disable()
                        end
                    end
                    
                    if RootPart then
                        -- Layer 4: Position safety
                        RootPart.Anchored = false
                        if RootPart.Position.Y < -100 then
                            RootPart.CFrame = CFrame.new(0, 100, 0)
                        end
                    end
                    
                    -- Layer 5: Invisible ForceField
                    if not Character:FindFirstChild("GodFF") then
                        local FF = Instance.new("ForceField")
                        FF.Name = "GodFF"
                        FF.Visible = false
                        FF.Parent = Character
                    end
                end
            end)
        end)
        print("👑 God Mode: ON")
    else
        if GodModeConnection then
            GodModeConnection:Disconnect()
            GodModeConnection = nil
        end
        
        pcall(function()
            local Character = Player.Character
            if Character then
                local FF = Character:FindFirstChild("GodFF")
                if FF then FF:Destroy() end
                
                local Humanoid = Character:FindFirstChildOfClass("Humanoid")
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
-- 👁️ ESP SYSTEM
-- ============================================
local ESPActive = false
local ESPObjects = {}

local function CreateESP(character)
    if not character then return end
    
    pcall(function()
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "ESP_Highlight"
        Highlight.FillColor = Color3.fromRGB(255, 0, 0)
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        Highlight.FillTransparency = 0.5
        Highlight.OutlineTransparency = 0
        Highlight.Parent = character
        
        table.insert(ESPObjects, Highlight)
    end)
end

local function ClearESP()
    for _, obj in pairs(ESPObjects) do
        pcall(function() obj:Destroy() end)
    end
    ESPObjects = {}
end

local function ToggleESP()
    ESPActive = not ESPActive
    
    if ESPActive then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Player and player.Character then
                CreateESP(player.Character)
            end
        end
        
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function(character)
                if ESPActive then
                    wait(0.5)
                    CreateESP(character)
                end
            end)
        end)
        print("👁️ ESP: ON")
    else
        ClearESP()
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
        if NoclipConnection then NoclipConnection:Disconnect() end
        
        NoclipConnection = RunService.Stepped:Connect(function()
            pcall(function()
                local Character = Player.Character
                if Character then
                    for _, part in pairs(Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end)
        print("👻 Noclip: ON")
    else
        if NoclipConnection then
            NoclipConnection:Disconnect()
            NoclipConnection = nil
        end
        
        pcall(function()
            local Character = Player.Character
            if Character then
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = true
                    end
                end
            end
        end)
        print("👻 Noclip: OFF")
    end
    
    return NoclipActive
end

-- ============================================
-- 🦅 FLY SYSTEM (MOBILE OPTIMIZED)
-- ============================================
local FlyActive = false
local FlySpeed = 50
local FlyBodyVelocity = nil
local FlyBodyGyro = nil

local function StopFly()
    if FlyBodyVelocity then FlyBodyVelocity:Destroy() end
    if FlyBodyGyro then FlyBodyGyro:Destroy() end
    FlyBodyVelocity = nil
    FlyBodyGyro = nil
end

local function StartFly()
    pcall(function()
        local Character = Player.Character
        if not Character then return end
        
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        if not RootPart then return end
        
        StopFly()
        
        FlyBodyVelocity = Instance.new("BodyVelocity")
        FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        FlyBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        FlyBodyVelocity.Parent = RootPart
        
        FlyBodyGyro = Instance.new("BodyGyro")
        FlyBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        FlyBodyGyro.CFrame = RootPart.CFrame
        FlyBodyGyro.Parent = RootPart
    end)
end

local function UpdateFlyDirection(direction)
    if not FlyActive or not FlyBodyVelocity then return end
    
    pcall(function()
        local Character = Player.Character
        if not Character then return end
        
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        if not RootPart then return end
        
        local velocity = Vector3.new(0, 0, 0)
        
        if direction == "forward" then
            velocity = Camera.CFrame.LookVector * FlySpeed
        elseif direction == "backward" then
            velocity = -Camera.CFrame.LookVector * FlySpeed
        elseif direction == "up" then
            velocity = Vector3.new(0, FlySpeed, 0)
        elseif direction == "down" then
            velocity = Vector3.new(0, -FlySpeed, 0)
        elseif direction == "left" then
            velocity = -Camera.CFrame.RightVector * FlySpeed
        elseif direction == "right" then
            velocity = Camera.CFrame.RightVector * FlySpeed
        end
        
        FlyBodyVelocity.Velocity = velocity
        FlyBodyGyro.CFrame = Camera.CFrame
    end)
end

local function ToggleFly()
    FlyActive = not FlyActive
    
    if FlyActive then
        StartFly()
        print("🦅 Fly: ON")
    else
        StopFly()
        print("🦅 Fly: OFF")
    end
    
    return FlyActive
end

-- ============================================
-- ⚡ SPEED BOOST
-- ============================================
local SpeedBoostActive = false
local OriginalSpeed = 16

local function ToggleSpeed()
    SpeedBoostActive = not SpeedBoostActive
    
    pcall(function()
        local Character = Player.Character
        if Character then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                if SpeedBoostActive then
                    OriginalSpeed = Humanoid.WalkSpeed
                    Humanoid.WalkSpeed = 100
                    print("⚡ Speed: 100")
                else
                    Humanoid.WalkSpeed = OriginalSpeed
                    print("⚡ Speed: Normal")
                end
            end
        end
    end)
    
    return SpeedBoostActive
end

-- ============================================
-- 🚀 JUMP BOOST
-- ============================================
local JumpBoostActive = false
local OriginalJump = 50

local function ToggleJump()
    JumpBoostActive = not JumpBoostActive
    
    pcall(function()
        local Character = Player.Character
        if Character then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                if JumpBoostActive then
                    OriginalJump = Humanoid.JumpPower
                    Humanoid.JumpPower = 200
                    print("🚀 Jump: 200")
                else
                    Humanoid.JumpPower = OriginalJump
                    print("🚀 Jump: Normal")
                end
            end
        end
    end)
    
    return JumpBoostActive
end

-- ============================================
-- 🎯 TELEPORT SYSTEM
-- ============================================
local function TeleportToMouse()
    pcall(function()
        local Character = Player.Character
        if Character then
            local RootPart = Character:FindFirstChild("HumanoidRootPart")
            if RootPart then
                local targetPos = Mouse.Hit.Position
                RootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 5, 0))
                print("🎯 Teleported!")
            end
        end
    end)
end

-- ============================================
-- 🎨 GUI CREATION
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateGodMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 550)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -275)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Rainbow Stroke
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 3
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

spawn(function()
    local hue = 0
    while MainFrame.Parent do
        hue = (hue + 0.5) % 360
        MainStroke.Color = Color3.fromHSV(hue/360, 1, 1)
        wait(0.01)
    end
end)

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ ULTIMATE GOD MENU ⚡"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 30
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

local CloseBtnCorner = Instance.new("UICorner")
CloseBtnCorner.CornerRadius = UDim.new(0, 8)
CloseBtnCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Scroll Frame
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -70)
ScrollFrame.Position = UDim2.new(0, 10, 0, 60)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.Parent = MainFrame

local ScrollLayout = Instance.new("UIListLayout")
ScrollLayout.Padding = UDim.new(0, 10)
ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScrollLayout.Parent = ScrollFrame

ScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollLayout.AbsoluteContentSize.Y + 10)
end)

-- Button Creator Function
local function CreateButton(text, icon, color, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 50)
    Button.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = ScrollFrame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = Button
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = color
    BtnStroke.Thickness = 2
    BtnStroke.Transparency = 0.5
    BtnStroke.Parent = Button
    
    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(0, 40, 0, 40)
    Icon.Position = UDim2.new(0, 5, 0.5, -20)
    Icon.BackgroundTransparency = 1
    Icon.Text = icon
    Icon.TextColor3 = color
    Icon.TextSize = 28
    Icon.Font = Enum.Font.GothamBold
    Icon.Parent = Button
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -100, 1, 0)
    Label.Position = UDim2.new(0, 50, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 16
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Button
    
    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(0, 50, 0, 30)
    Status.Position = UDim2.new(1, -55, 0.5, -15)
    Status.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Status.Text = "OFF"
    Status.TextColor3 = Color3.fromRGB(255, 255, 255)
    Status.TextSize = 14
    Status.Font = Enum.Font.GothamBold
    Status.Parent = Button
    
    local StatusCorner = Instance.new("UICorner")
    StatusCorner.CornerRadius = UDim.new(0, 6)
    StatusCorner.Parent = Status
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 40)}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 30)}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0.5}):Play()
    end)
    
    Button.MouseButton1Click:Connect(function()
        local state = callback()
        if state then
            Status.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            Status.Text = "ON"
        else
            Status.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Status.Text = "OFF"
        end
    end)
    
    return Button
end

-- ============================================
-- 📱 MOBILE FLY CONTROLS
-- ============================================
local FlyControlsFrame = Instance.new("Frame")
FlyControlsFrame.Name = "FlyControls"
FlyControlsFrame.Size = UDim2.new(0, 200, 0, 200)
FlyControlsFrame.Position = UDim2.new(1, -220, 0.5, -100)
FlyControlsFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
FlyControlsFrame.BorderSizePixel = 0
FlyControlsFrame.Visible = false
FlyControlsFrame.Active = true
FlyControlsFrame.Draggable = true
FlyControlsFrame.Parent = ScreenGui

local FlyControlsCorner = Instance.new("UICorner")
FlyControlsCorner.CornerRadius = UDim.new(0, 12)
FlyControlsCorner.Parent = FlyControlsFrame

local FlyControlsStroke = Instance.new("UIStroke")
FlyControlsStroke.Color = Color3.fromRGB(100, 200, 255)
FlyControlsStroke.Thickness = 2
FlyControlsStroke.Parent = FlyControlsFrame

-- Fly Control Buttons
local function CreateFlyButton(text, position, direction)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 50, 0, 50)
    btn.Position = position
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 20
    btn.Font = Enum.Font.GothamBold
    btn.Parent = FlyControlsFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    btn.MouseButton1Down:Connect(function()
        UpdateFlyDirection(direction)
        btn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
    end)
    
    btn.MouseButton1Up:Connect(function()
        UpdateFlyDirection("stop")
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    end)
    
    return btn
end

CreateFlyButton("⬆", UDim2.new(0.5, -25, 0, 10), "up")
CreateFlyButton("⬇", UDim2.new(0.5, -25, 1, -60), "down")
CreateFlyButton("⬅", UDim2.new(0, 10, 0.5, -25), "left")
CreateFlyButton("➡", UDim2.new(1, -60, 0.5, -25), "right")

-- Forward/Backward buttons
CreateFlyButton("↑", UDim2.new(0.5, -25, 0, 70), "forward")
CreateFlyButton("↓", UDim2.new(0.5, -25, 1, -120), "backward")

-- Speed Control
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -20, 0, 20)
SpeedLabel.Position = UDim2.new(0, 10, 0.5, 30)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: " .. FlySpeed
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 14
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.Parent = FlyControlsFrame

local SpeedSlider = Instance.new("TextButton")
SpeedSlider.Size = UDim2.new(0.4, 0, 0, 30)
SpeedSlider.Position = UDim2.new(0.05, 0, 0.5, 55)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
SpeedSlider.Text = "-"
SpeedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedSlider.TextSize = 20
SpeedSlider.Font = Enum.Font.GothamBold
SpeedSlider.Parent = FlyControlsFrame

local SpeedSliderCorner = Instance.new("UICorner")
SpeedSliderCorner.Parent = SpeedSlider

SpeedSlider.MouseButton1Click:Connect(function()
    FlySpeed = math.max(10, FlySpeed - 10)
    SpeedLabel.Text = "Speed: " .. FlySpeed
end)

local SpeedSlider2 = Instance.new("TextButton")
SpeedSlider2.Size = UDim2.new(0.4, 0, 0, 30)
SpeedSlider2.Position = UDim2.new(0.55, 0, 0.5, 55)
SpeedSlider2.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
SpeedSlider2.Text = "+"
SpeedSlider2.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedSlider2.TextSize = 20
SpeedSlider2.Font = Enum.Font.GothamBold
SpeedSlider2.Parent = FlyControlsFrame

local SpeedSlider2Corner = Instance.new("UICorner")
SpeedSlider2Corner.Parent = SpeedSlider2

SpeedSlider2.MouseButton1Click:Connect(function()
    FlySpeed = math.min(200, FlySpeed + 10)
    SpeedLabel.Text = "Speed: " .. FlySpeed
end)

-- ============================================
-- 🎮 CREATE ALL BUTTONS
-- ============================================

CreateButton("Bypass Anti-Cheat", "🛡️", Color3.fromRGB(0, 255, 255), function()
    SafeBypass()
    return true
end)

CreateButton("God Mode (Immortal)", "👑", Color3.fromRGB(255, 215, 0), ToggleGodMode)

CreateButton("ESP (See Players)", "👁️", Color3.fromRGB(255, 100, 100), ToggleESP)

CreateButton("Fly Mode", "🦅", Color3.fromRGB(100, 200, 255), function()
    local state = ToggleFly()
    FlyControlsFrame.Visible = state
    return state
end)

CreateButton("Noclip (Walk Through Walls)", "👻", Color3.fromRGB(150, 100, 255), ToggleNoclip)

CreateButton("Speed Boost (x6)", "⚡", Color3.fromRGB(255, 255, 0), ToggleSpeed)

CreateButton("Jump Boost (x4)", "🚀", Color3.fromRGB(0, 255, 150), ToggleJump)

CreateButton("Teleport to Mouse (Click)", "🎯", Color3.fromRGB(255, 100, 200), function()
    Mouse.Button1Down:Connect(TeleportToMouse)
    return true
end)

-- ============================================
-- ⚙️ AUTO-SETUP ON CHARACTER SPAWN
-- ============================================
Player.CharacterAdded:Connect(function(character)
    wait(0.5)
    
    -- Re-apply active features
    if GodModeActive then
        GodModeActive = false
        ToggleGodMode()
    end
    
    if SpeedBoostActive then
        wait(0.5)
        pcall(function()
            local Humanoid = character:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                Humanoid.WalkSpeed = 100
            end
        end)
    end
    
    if JumpBoostActive then
        wait(0.5)
        pcall(function()
            local Humanoid = character:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                Humanoid.JumpPower = 200
            end
        end)
    end
end)

-- ============================================
-- ✅ INITIALIZATION
-- ============================================
print("⚡ ULTIMATE GOD MENU v20.0 LOADED")
print("✅ All systems ready")
print("🎮 Mobile & PC compatible")
print("🛡️ Anti-crash protection active")

SafeBypass()
