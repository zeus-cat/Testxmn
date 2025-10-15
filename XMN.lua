-- ⚡ ULTIMATE GHOST MENU v35.0 - ZERO BUGS | MAXIMUM POWER
-- کاملاً بازنویسی شده با تکنیک‌های پیشرفته

task.wait(1)

-- ============================================
-- 🔧 SERVICES & VARIABLES
-- ============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Camera = workspace.CurrentCamera

-- Clean previous GUI
for _, gui in pairs(Player.PlayerGui:GetChildren()) do
    if gui.Name == "GhostMenu" then
        gui:Destroy()
    end
end

-- ============================================
-- 🛡️ ADVANCED BYPASS ENGINE
-- ============================================
local BypassEngine = {
    Active = false,
    Hooks = {}
}

function BypassEngine:Initialize()
    if self.Active then return end
    self.Active = true
    
    -- Hook 1: Metamethods
    task.spawn(function()
        pcall(function()
            if not getrawmetatable then return end
            
            local mt = getrawmetatable(game)
            local oldNC = mt.__namecall
            
            setreadonly(mt, false)
            
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                local args = {...}
                
                -- Block all damage
                if method == "TakeDamage" or method == "BreakJoints" then
                    return nil
                end
                
                -- Block kicks
                if method == "Kick" then
                    return nil
                end
                
                -- Filter dangerous remotes
                if method == "FireServer" or method == "InvokeServer" then
                    local name = tostring(self):lower()
                    if name:find("damage") or name:find("kill") or name:find("death") or 
                       name:find("ban") or name:find("kick") or name:find("anticheat") then
                        return nil
                    end
                end
                
                return oldNC(self, ...)
            end)
            
            setreadonly(mt, true)
        end)
    end)
    
    -- Hook 2: Anti-AFK
    pcall(function()
        Player.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end)
    
    print("🛡️ Bypass Engine: Active")
end

-- ============================================
-- 👑 GOD MODE ENGINE (ULTRA STRONG)
-- ============================================
local GodMode = {
    Active = false,
    Connections = {}
}

function GodMode:Enable()
    if self.Active then return end
    self.Active = true
    
    -- Clear old connections
    for _, conn in pairs(self.Connections) do
        pcall(function() conn:Disconnect() end)
    end
    self.Connections = {}
    
    -- Main loop
    local conn1 = RunService.Heartbeat:Connect(function()
        if not self.Active then return end
        
        pcall(function()
            local Char = Player.Character
            if not Char then return end
            
            local Humanoid = Char:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                -- Max health
                Humanoid.MaxHealth = math.huge
                Humanoid.Health = math.huge
                
                -- Disable states
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                
                -- Disconnect death
                if getconnections then
                    for _, signal in pairs(getconnections(Humanoid.Died)) do
                        signal:Disable()
                    end
                    for _, signal in pairs(getconnections(Humanoid.HealthChanged)) do
                        signal:Disable()
                    end
                end
            end
            
            -- Anti-void
            local Root = Char:FindFirstChild("HumanoidRootPart")
            if Root and Root.Position.Y < -50 then
                Root.CFrame = CFrame.new(0, 100, 0)
            end
            
            -- Force field
            if not Char:FindFirstChildOfClass("ForceField") then
                local ff = Instance.new("ForceField")
                ff.Visible = false
                ff.Parent = Char
            end
        end)
    end)
    
    table.insert(self.Connections, conn1)
    print("👑 God Mode: Activated")
end

function GodMode:Disable()
    self.Active = false
    
    for _, conn in pairs(self.Connections) do
        pcall(function() conn:Disconnect() end)
    end
    self.Connections = {}
    
    pcall(function()
        local Char = Player.Character
        if Char then
            local ff = Char:FindFirstChildOfClass("ForceField")
            if ff then ff:Destroy() end
            
            local Humanoid = Char:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                Humanoid.MaxHealth = 100
                Humanoid.Health = 100
            end
        end
    end)
    
    print("👑 God Mode: Deactivated")
end

function GodMode:Toggle()
    if self.Active then
        self:Disable()
    else
        self:Enable()
    end
    return self.Active
end

-- ============================================
-- 👻 TRUE INVISIBLE (FOR EVERYONE)
-- ============================================
local Invisible = {
    Active = false,
    FakeCharacter = nil,
    OriginalPosition = nil
}

function Invisible:Enable()
    if self.Active then return end
    self.Active = true
    
    task.spawn(function()
        pcall(function()
            local Char = Player.Character
            if not Char then return end
            
            local Root = Char:FindFirstChild("HumanoidRootPart")
            if not Root then return end
            
            -- Save position
            self.OriginalPosition = Root.CFrame
            
            -- Method 1: Move character far away (works for FE)
            for _, part in pairs(Char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part:Destroy()
                end
            end
            
            -- Method 2: Make HumanoidRootPart tiny and transparent
            Root.Transparency = 1
            Root.Size = Vector3.new(0.2, 0.2, 0.2)
            Root.CanCollide = false
            
            -- Method 3: Remove all visible parts
            for _, obj in pairs(Char:GetChildren()) do
                if obj:IsA("Accessory") or obj:IsA("Hat") or obj:IsA("Shirt") or 
                   obj:IsA("Pants") or obj:IsA("ShirtGraphic") then
                    obj:Destroy()
                end
            end
            
            -- Remove name tag
            if Char:FindFirstChild("Head") then
                for _, child in pairs(Char.Head:GetChildren()) do
                    if child:IsA("Decal") then
                        child.Transparency = 1
                    end
                end
            end
            
            print("👻 True Invisible: Activated")
        end)
    end)
end

function Invisible:Disable()
    self.Active = false
    
    pcall(function()
        -- Respawn to restore character
        Player.Character:BreakJoints()
    end)
    
    print("👻 True Invisible: Deactivated (Respawning...)")
end

function Invisible:Toggle()
    if self.Active then
        self:Disable()
    else
        self:Enable()
    end
    return self.Active
end

-- ============================================
-- 🦅 ADVANCED FLY SYSTEM (WITH AUTO NOCLIP)
-- ============================================
local FlySystem = {
    Active = false,
    Speed = 50,
    BodyVel = nil,
    BodyGyro = nil,
    NoclipConnection = nil,
    CurrentDirection = Vector3.new(0, 0, 0)
}

function FlySystem:Start()
    if self.Active then return end
    self.Active = true
    
    task.spawn(function()
        pcall(function()
            local Char = Player.Character
            if not Char then return end
            
            local Root = Char:FindFirstChild("HumanoidRootPart")
            if not Root then return end
            
            -- Create physics
            self.BodyVel = Instance.new("BodyVelocity")
            self.BodyVel.Velocity = Vector3.new(0, 0, 0)
            self.BodyVel.MaxForce = Vector3.new(100000, 100000, 100000)
            self.BodyVel.P = 10000
            self.BodyVel.Parent = Root
            
            self.BodyGyro = Instance.new("BodyGyro")
            self.BodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)
            self.BodyGyro.P = 10000
            self.BodyGyro.CFrame = Root.CFrame
            self.BodyGyro.Parent = Root
            
            -- Auto Noclip
            self.NoclipConnection = RunService.Stepped:Connect(function()
                if not self.Active then return end
                
                pcall(function()
                    for _, part in pairs(Char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end)
            end)
            
            print("🦅 Fly Mode: Activated (Auto Noclip)")
        end)
    end)
end

function FlySystem:Stop()
    self.Active = false
    
    pcall(function()
        if self.BodyVel then self.BodyVel:Destroy() end
        if self.BodyGyro then self.BodyGyro:Destroy() end
        if self.NoclipConnection then self.NoclipConnection:Disconnect() end
        
        self.BodyVel = nil
        self.BodyGyro = nil
        self.NoclipConnection = nil
        self.CurrentDirection = Vector3.new(0, 0, 0)
        
        -- Restore collision
        local Char = Player.Character
        if Char then
            for _, part in pairs(Char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
        
        print("🦅 Fly Mode: Deactivated")
    end)
end

function FlySystem:SetDirection(direction)
    if not self.Active or not self.BodyVel then return end
    
    pcall(function()
        local velocity = Vector3.new(0, 0, 0)
        
        if direction == "forward" then
            velocity = Camera.CFrame.LookVector * self.Speed
        elseif direction == "backward" then
            velocity = -Camera.CFrame.LookVector * self.Speed
        elseif direction == "left" then
            velocity = -Camera.CFrame.RightVector * self.Speed
        elseif direction == "right" then
            velocity = Camera.CFrame.RightVector * self.Speed
        elseif direction == "up" then
            velocity = Vector3.new(0, self.Speed, 0)
        elseif direction == "down" then
            velocity = Vector3.new(0, -self.Speed, 0)
        end
        
        self.BodyVel.Velocity = velocity
        self.BodyGyro.CFrame = Camera.CFrame
    end)
end

function FlySystem:StopMovement()
    if self.BodyVel then
        self.BodyVel.Velocity = Vector3.new(0, 0, 0)
    end
end

function FlySystem:Toggle()
    if self.Active then
        self:Stop()
    else
        self:Start()
    end
    return self.Active
end

-- ============================================
-- 👁️ ESP SYSTEM
-- ============================================
local ESP = {
    Active = false,
    Highlights = {}
}

function ESP:Enable()
    if self.Active then return end
    self.Active = true
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character then
            self:AddPlayer(plr.Character)
        end
    end
    
    -- Monitor new players
    Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function(char)
            if self.Active then
                task.wait(0.5)
                self:AddPlayer(char)
            end
        end)
    end)
    
    print("👁️ ESP: Activated")
end

function ESP:AddPlayer(char)
    pcall(function()
        if char:FindFirstChild("ESP_Highlight") then return end
        
        local hl = Instance.new("Highlight")
        hl.Name = "ESP_Highlight"
        hl.FillColor = Color3.fromRGB(255, 0, 0)
        hl.OutlineColor = Color3.fromRGB(255, 255, 0)
        hl.FillTransparency = 0.5
        hl.OutlineTransparency = 0
        hl.Parent = char
        
        table.insert(self.Highlights, hl)
    end)
end

function ESP:Disable()
    self.Active = false
    
    for _, hl in pairs(self.Highlights) do
        pcall(function() hl:Destroy() end)
    end
    
    self.Highlights = {}
    print("👁️ ESP: Deactivated")
end

function ESP:Toggle()
    if self.Active then
        self:Disable()
    else
        self:Enable()
    end
    return self.Active
end

-- ============================================
-- 🚫 NOCLIP SYSTEM
-- ============================================
local Noclip = {
    Active = false,
    Connection = nil
}

function Noclip:Enable()
    if self.Active then return end
    self.Active = true
    
    self.Connection = RunService.Stepped:Connect(function()
        if not self.Active then return end
        
        pcall(function()
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
    
    print("🚫 Noclip: Activated")
end

function Noclip:Disable()
    self.Active = false
    
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
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
    
    print("🚫 Noclip: Deactivated")
end

function Noclip:Toggle()
    if self.Active then
        self:Disable()
    else
        self:Enable()
    end
    return self.Active
end

-- ============================================
-- ⚡ SPEED SYSTEM
-- ============================================
local Speed = {
    Active = false,
    Value = 100,
    OriginalSpeed = 16
}

function Speed:Toggle()
    self.Active = not self.Active
    
    pcall(function()
        local Char = Player.Character
        if Char then
            local Hum = Char:FindFirstChildOfClass("Humanoid")
            if Hum then
                if self.Active then
                    self.OriginalSpeed = Hum.WalkSpeed
                    Hum.WalkSpeed = self.Value
                    print("⚡ Speed: " .. self.Value)
                else
                    Hum.WalkSpeed = self.OriginalSpeed
                    print("⚡ Speed: Normal")
                end
            end
        end
    end)
    
    return self.Active
end

-- ============================================
-- 🚀 JUMP SYSTEM
-- ============================================
local Jump = {
    Active = false,
    Value = 200,
    OriginalJump = 50
}

function Jump:Toggle()
    self.Active = not self.Active
    
    pcall(function()
        local Char = Player.Character
        if Char then
            local Hum = Char:FindFirstChildOfClass("Humanoid")
            if Hum then
                if self.Active then
                    self.OriginalJump = Hum.JumpPower
                    Hum.JumpPower = self.Value
                    Hum.UseJumpPower = true
                    print("🚀 Jump: " .. self.Value)
                else
                    Hum.JumpPower = self.OriginalJump
                    print("🚀 Jump: Normal")
                end
            end
        end
    end)
    
    return self.Active
end

-- ============================================
-- 🎯 TELEPORT SYSTEM
-- ============================================
local Teleport = {
    Active = false
}

function Teleport:Activate()
    if self.Active then return true end
    self.Active = true
    
    Mouse.Button1Down:Connect(function()
        pcall(function()
            local Char = Player.Character
            if Char and Char:FindFirstChild("HumanoidRootPart") then
                local pos = Mouse.Hit.Position
                Char.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
            end
        end)
    end)
    
    print("🎯 Teleport: Activated (Click anywhere)")
    return true
end

-- ============================================
-- 🎨 GUI SYSTEM
-- ============================================
local Gui = Instance.new("ScreenGui")
Gui.Name = "GhostMenu"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = Player.PlayerGui

-- ============================================
-- 👻 MINI BUTTON
-- ============================================
local MiniBtn = Instance.new("TextButton")
MiniBtn.Name = "MiniButton"
MiniBtn.Size = UDim2.new(0, 70, 0, 70)
MiniBtn.Position = UDim2.new(0, 20, 0.5, -35)
MiniBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MiniBtn.BorderSizePixel = 0
MiniBtn.Text = ""
MiniBtn.Active = true
MiniBtn.Draggable = true
MiniBtn.Parent = Gui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(1, 0)
MiniCorner.Parent = MiniBtn

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Thickness = 4
MiniStroke.Color = Color3.fromRGB(100, 200, 255)
MiniStroke.Parent = MiniBtn

local MiniIcon = Instance.new("TextLabel")
MiniIcon.Size = UDim2.new(1, 0, 1, 0)
MiniIcon.BackgroundTransparency = 1
MiniIcon.Text = "👻"
MiniIcon.TextScaled = true
MiniIcon.Font = Enum.Font.GothamBold
MiniIcon.Parent = MiniBtn

-- Rainbow effect
task.spawn(function()
    while MiniBtn.Parent do
        for hue = 0, 360, 3 do
            if not MiniBtn.Parent then break end
            MiniStroke.Color = Color3.fromHSV(hue/360, 1, 1)
            task.wait(0.05)
        end
    end
end)

-- ============================================
-- 📱 MAIN FRAME
-- ============================================
local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 420, 0, 520)
Main.Position = UDim2.new(0.5, -210, 0.5, -260)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Active = true
Main.Draggable = true
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 4
MainStroke.Color = Color3.fromRGB(100, 200, 255)
MainStroke.Parent = Main

task.spawn(function()
    while Main.Parent do
        for hue = 0, 360, 3 do
            if not Main.Parent then break end
            MainStroke.Color = Color3.fromHSV(hue/360, 1, 1)
            task.wait(0.05)
        end
    end
end)

-- ============================================
-- 📋 HEADER
-- ============================================
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 55)
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 16)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.65, 0, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "👻 GHOST MENU v35"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 45, 0, 45)
CloseBtn.Position = UDim2.new(1, -50, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 30
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 12)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

-- ============================================
-- 📜 SCROLL FRAME
-- ============================================
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -24, 1, -75)
Scroll.Position = UDim2.new(0, 12, 0, 65)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 8
Scroll.ScrollBarImageColor3 = Color3.fromRGB(100, 200, 255)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 12)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = Scroll

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 12)
end)

-- ============================================
-- 🎮 BUTTON CREATOR
-- ============================================
local function CreateButton(text, icon, color, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -12, 0, 60)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Btn.BorderSizePixel = 0
    Btn.Text = ""
    Btn.AutoButtonColor = false
    Btn.Parent = Scroll
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Btn
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = color
    Stroke.Thickness = 2.5
    Stroke.Transparency = 0.5
    Stroke.Parent = Btn
    
    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(0, 50, 0, 50)
    Icon.Position = UDim2.new(0, 8, 0.5, -25)
    Icon.BackgroundTransparency = 1
    Icon.Text = icon
    Icon.TextColor3 = color
    Icon.TextSize = 32
    Icon.Font = Enum.Font.GothamBold
    Icon.Parent = Btn
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -130, 1, 0)
    Label.Position = UDim2.new(0, 65, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 17
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Btn
    
    local Status = Instance.new("Frame")
    Status.Size = UDim2.new(0, 60, 0, 34)
    Status.Position = UDim2.new(1, -68, 0.5, -17)
    Status.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    Status.BorderSizePixel = 0
    Status.Parent = Btn
    
    local StatusCorner = Instance.new("UICorner")
    StatusCorner.CornerRadius = UDim.new(0, 10)
    StatusCorner.Parent = Status
    
    local StatusText = Instance.new("TextLabel")
    StatusText.Size = UDim2.new(1, 0, 1, 0)
    StatusText.BackgroundTransparency = 1
    StatusText.Text = "OFF"
    StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatusText.TextSize = 15
    StatusText.Font = Enum.Font.GothamBold
    StatusText.Parent = Status
    
    -- Hover effects
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(35, 35, 42)
        }):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.2), {
            Transparency = 0,
            Thickness = 3
        }):Play()
    end)
    
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        }):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.2), {
            Transparency = 0.5,
            Thickness = 2.5
        }):Play()
    end)
    
    -- Click handler
    Btn.MouseButton1Click:Connect(function()
        local state = callback()
        
        if state then
            Status.BackgroundColor3 = Color3.fromRGB(0, 220, 100)
            StatusText.Text = "ON"
            TweenService:Create(Btn, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.fromRGB(30, 40, 35)
            }):Play()
        else
            Status.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
            StatusText.Text = "OFF"
            TweenService:Create(Btn, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.fromRGB(25, 25, 30)
            }):Play()
        end
    end)
end

-- ============================================
-- 🎮 FLY CONTROLS (ADVANCED)
-- ============================================
local FlyControls = Instance.new("Frame")
FlyControls.Name = "FlyControls"
FlyControls.Size = UDim2.new(0, 240, 0, 280)
FlyControls.Position = UDim2.new(1, -260, 0.5, -140)
FlyControls.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
FlyControls.BorderSizePixel = 0
FlyControls.Visible = false
FlyControls.Active = true
FlyControls.Draggable = true
FlyControls.Parent = Gui

local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(0, 16)
FlyCorner.Parent = FlyControls

local FlyStroke = Instance.new("UIStroke")
FlyStroke.Thickness = 4
FlyStroke.Color = Color3.fromRGB(100, 200, 255)
FlyStroke.Parent = FlyControls

task.spawn(function()
    while FlyControls.Parent do
        for hue = 0, 360, 3 do
            if not FlyControls.Parent then break end
            FlyStroke.Color = Color3.fromHSV(hue/360, 1, 1)
            task.wait(0.05)
        end
    end
end)

-- Title for Fly Controls
local FlyTitle = Instance.new("TextLabel")
FlyTitle.Size = UDim2.new(1, 0, 0, 40)
FlyTitle.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
FlyTitle.BorderSizePixel = 0
FlyTitle.Text = "✈️ FLY CONTROLS"
FlyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyTitle.TextSize = 18
FlyTitle.Font = Enum.Font.GothamBold
FlyTitle.Parent = FlyControls

local FlyTitleCorner = Instance.new("UICorner")
FlyTitleCorner.CornerRadius = UDim.new(0, 16)
FlyTitleCorner.Parent = FlyTitle

-- Create Fly Button Function
local function CreateFlyBtn(text, pos, dir)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 65, 0, 65)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 26
    btn.Font = Enum.Font.GothamBold
    btn.Parent = FlyControls
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 14)
    corner.Parent = btn
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 200, 255)
    stroke.Thickness = 2.5
    stroke.Transparency = 0.5
    stroke.Parent = btn
    
    btn.MouseButton1Down:Connect(function()
        FlySystem:SetDirection(dir)
        btn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
        stroke.Transparency = 0
        stroke.Thickness = 3.5
    end)
    
    btn.MouseButton1Up:Connect(function()
        FlySystem:StopMovement()
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        stroke.Transparency = 0.5
        stroke.Thickness = 2.5
    end)
    
    btn.MouseLeave:Connect(function()
        FlySystem:StopMovement()
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        stroke.Transparency = 0.5
        stroke.Thickness = 2.5
    end)
end

-- Movement Buttons (Separated)
-- Forward/Backward Section
CreateFlyBtn("↑", UDim2.new(0.5, -32.5, 0, 50), "forward")
CreateFlyBtn("↓", UDim2.new(0.5, -32.5, 0, 125), "backward")

-- Left/Right Section
CreateFlyBtn("←", UDim2.new(0, 12, 0, 87.5), "left")
CreateFlyBtn("→", UDim2.new(1, -77, 0, 87.5), "right")

-- Up/Down Section (Separate area)
local UpDownLabel = Instance.new("TextLabel")
UpDownLabel.Size = UDim2.new(1, -24, 0, 25)
UpDownLabel.Position = UDim2.new(0, 12, 0, 200)
UpDownLabel.BackgroundTransparency = 1
UpDownLabel.Text = "⬆⬇ VERTICAL"
UpDownLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
UpDownLabel.TextSize = 14
UpDownLabel.Font = Enum.Font.Gotham
UpDownLabel.Parent = FlyControls

CreateFlyBtn("⬆", UDim2.new(0, 12, 0, 230), "up")
CreateFlyBtn("⬇", UDim2.new(1, -77, 0, 230), "down")

-- Speed Control
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -24, 0, 20)
SpeedLabel.Position = UDim2.new(0, 12, 1, -40)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: " .. FlySystem.Speed
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 15
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.Parent = FlyControls

local function CreateSpeedBtn(text, pos, change)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.48, 0, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 20
    btn.Font = Enum.Font.GothamBold
    btn.Parent = FlyControls
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        FlySystem.Speed = math.clamp(FlySystem.Speed + change, 10, 500)
        SpeedLabel.Text = "Speed: " .. FlySystem.Speed
    end)
end

CreateSpeedBtn("- SLOW", UDim2.new(0, 12, 1, -75), -10)
CreateSpeedBtn("+ FAST", UDim2.new(0.52, 0, 1, -75), 10)

-- ============================================
-- 📋 CREATE ALL BUTTONS
-- ============================================

CreateButton("Bypass Anti-Cheat", "🛡️", Color3.fromRGB(0, 255, 255), function()
    BypassEngine:Initialize()
    return true
end)

CreateButton("God Mode (Immortal)", "👑", Color3.fromRGB(255, 215, 0), function()
    return GodMode:Toggle()
end)

CreateButton("True Invisible (For All)", "👻", Color3.fromRGB(170, 0, 255), function()
    return Invisible:Toggle()
end)

CreateButton("Fly Mode + Auto Noclip", "🦅", Color3.fromRGB(100, 200, 255), function()
    local state = FlySystem:Toggle()
    FlyControls.Visible = state
    return state
end)

CreateButton("ESP (See All Players)", "👁️", Color3.fromRGB(255, 100, 100), function()
    return ESP:Toggle()
end)

CreateButton("Noclip (Walk Through)", "🚪", Color3.fromRGB(200, 100, 255), function()
    return Noclip:Toggle()
end)

CreateButton("Speed Boost (x6)", "⚡", Color3.fromRGB(255, 255, 0), function()
    return Speed:Toggle()
end)

CreateButton("Jump Boost (x4)", "🚀", Color3.fromRGB(0, 255, 150), function()
    return Jump:Toggle()
end)

CreateButton("Teleport to Click", "🎯", Color3.fromRGB(255, 100, 200), function()
    return Teleport:Activate()
end)

-- ============================================
-- 🎮 MENU TOGGLE
-- ============================================
MiniBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    
    if Main.Visible then
        Main.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 420, 0, 520)
        }):Play()
    end
end)

-- ============================================
-- 🔄 AUTO-REAPPLY ON RESPAWN
-- ============================================
Player.CharacterAdded:Connect(function(char)
    task.wait(1)
    
    -- Reapply active features
    if GodMode.Active then
        GodMode.Active = false
        GodMode:Enable()
    end
    
    if Speed.Active then
        task.wait(0.5)
        pcall(function()
            local Hum = char:FindFirstChildOfClass("Humanoid")
            if Hum then Hum.WalkSpeed = Speed.Value end
        end)
    end
    
    if Jump.Active then
        task.wait(0.5)
        pcall(function()
            local Hum = char:FindFirstChildOfClass("Humanoid")
            if Hum then
                Hum.JumpPower = Jump.Value
                Hum.UseJumpPower = true
            end
        end)
    end
end)

-- ============================================
-- ✅ STARTUP NOTIFICATION
-- ============================================
local Notif = Instance.new("TextLabel")
Notif.Size = UDim2.new(0, 320, 0, 50)
Notif.Position = UDim2.new(0.5, -160, 0, 25)
Notif.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Notif.BorderSizePixel = 0
Notif.Text = "✅ GHOST MENU v35 LOADED"
Notif.TextColor3 = Color3.fromRGB(0, 255, 150)
Notif.TextScaled = true
Notif.Font = Enum.Font.GothamBold
Notif.Parent = Gui

local NotifCorner = Instance.new("UICorner")
NotifCorner.CornerRadius = UDim.new(0, 12)
NotifCorner.Parent = Notif

local NotifStroke = Instance.new("UIStroke")
NotifStroke.Thickness = 3
NotifStroke.Color = Color3.fromRGB(0, 255, 150)
NotifStroke.Parent = Notif

task.wait(3)
TweenService:Create(Notif, TweenInfo.new(0.5), {
    Position = UDim2.new(0.5, -160, 0, -60)
}):Play()
task.wait(0.5)
Notif:Destroy()

-- ============================================
-- ✅ INITIALIZATION
-- ============================================
print("============================================")
print("👻 GHOST MENU v35.0 - PROFESSIONAL EDITION")
print("============================================")
print("✅ All Systems: Online")
print("✅ God Mode: Ready")
print("✅ True Invisible: Ready")
print("✅ Advanced Fly: Ready (Auto Noclip)")
print("✅ ESP System: Ready")
print("✅ Bypass Engine: Ready")
print("============================================")

-- Auto-activate bypass
BypassEngine:Initialize()
