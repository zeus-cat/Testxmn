-- ⚡ ULTIMATE GHOST MENU v40.0 - FAKE CHARACTER SYSTEM
-- اینویزیبل حرفه‌ای با Fake Character

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

-- Clean old GUI
for _, gui in pairs(Player.PlayerGui:GetChildren()) do
    if gui.Name == "GhostMenuV40" then
        gui:Destroy()
    end
end

-- ============================================
-- 🛡️ ADVANCED BYPASS ENGINE
-- ============================================
local BypassEngine = {
    Active = false
}

function BypassEngine:Initialize()
    if self.Active then return end
    self.Active = true
    
    task.spawn(function()
        pcall(function()
            if not getrawmetatable then return end
            
            local mt = getrawmetatable(game)
            local oldNC = mt.__namecall
            
            setreadonly(mt, false)
            
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                
                if method == "TakeDamage" or method == "BreakJoints" then
                    return nil
                end
                
                if method == "Kick" then
                    return nil
                end
                
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
    
    pcall(function()
        Player.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end)
    
    print("🛡️ Bypass: Active")
end

-- ============================================
-- 👑 GOD MODE ENGINE
-- ============================================
local GodMode = {
    Active = false,
    Connections = {}
}

function GodMode:Enable()
    if self.Active then return end
    self.Active = true
    
    for _, conn in pairs(self.Connections) do
        pcall(function() conn:Disconnect() end)
    end
    self.Connections = {}
    
    local conn = RunService.Heartbeat:Connect(function()
        if not self.Active then return end
        
        pcall(function()
            local Char = Player.Character
            if not Char then return end
            
            local Humanoid = Char:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                Humanoid.MaxHealth = math.huge
                Humanoid.Health = math.huge
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                
                if getconnections then
                    for _, signal in pairs(getconnections(Humanoid.Died)) do
                        signal:Disable()
                    end
                end
            end
            
            local Root = Char:FindFirstChild("HumanoidRootPart")
            if Root and Root.Position.Y < -50 then
                Root.CFrame = CFrame.new(0, 100, 0)
            end
            
            if not Char:FindFirstChildOfClass("ForceField") then
                local ff = Instance.new("ForceField")
                ff.Visible = false
                ff.Parent = Char
            end
        end)
    end)
    
    table.insert(self.Connections, conn)
    print("👑 God Mode: ON")
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
    
    print("👑 God Mode: OFF")
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
-- 👻 FAKE CHARACTER INVISIBLE SYSTEM
-- ============================================
local FakeInvisible = {
    Active = false,
    FakeCharacter = nil,
    UpdateConnection = nil
}

function FakeInvisible:Enable()
    if self.Active then return end
    self.Active = true
    
    task.spawn(function()
        pcall(function()
            local RealChar = Player.Character
            if not RealChar then return end
            
            local RealRoot = RealChar:FindFirstChild("HumanoidRootPart")
            if not RealRoot then return end
            
            -- Create Fake Character (Clone)
            self.FakeCharacter = RealChar:Clone()
            
            -- Remove scripts from fake
            for _, obj in pairs(self.FakeCharacter:GetDescendants()) do
                if obj:IsA("Script") or obj:IsA("LocalScript") then
                    obj:Destroy()
                end
            end
            
            -- Make fake humanoid not functional
            local FakeHumanoid = self.FakeCharacter:FindFirstChildOfClass("Humanoid")
            if FakeHumanoid then
                FakeHumanoid.Health = 100
                FakeHumanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            end
            
            -- Position fake at current location
            self.FakeCharacter.Name = Player.Name
            self.FakeCharacter:SetPrimaryPartCFrame(RealRoot.CFrame)
            
            -- Anchor fake character
            for _, part in pairs(self.FakeCharacter:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Anchored = true
                    part.CanCollide = false
                end
            end
            
            self.FakeCharacter.Parent = workspace
            
            -- Make REAL character invisible
            for _, part in pairs(RealChar:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                    if part.Name == "Head" then
                        for _, child in pairs(part:GetChildren()) do
                            if child:IsA("Decal") then
                                child.Transparency = 1
                            end
                        end
                    end
                elseif part:IsA("Accessory") then
                    local Handle = part:FindFirstChild("Handle")
                    if Handle then
                        Handle.Transparency = 1
                    end
                elseif part:IsA("Decal") then
                    part.Transparency = 1
                end
            end
            
            -- Force first person (optional, makes it cleaner)
            Player.CameraMode = Enum.CameraMode.LockFirstPerson
            task.wait(0.1)
            Player.CameraMode = Enum.CameraMode.Classic
            Player.CameraMaxZoomDistance = 0.5
            
            print("👻 Fake Invisible: ON")
            print("✅ Fake character placed at your location")
            print("✅ You are now invisible and can move freely!")
        end)
    end)
end

function FakeInvisible:Disable()
    self.Active = false
    
    pcall(function()
        -- Remove fake character
        if self.FakeCharacter then
            self.FakeCharacter:Destroy()
            self.FakeCharacter = nil
        end
        
        -- Restore real character visibility
        local RealChar = Player.Character
        if RealChar then
            for _, part in pairs(RealChar:GetDescendants()) do
                if part:IsA("BasePart") then
                    if part.Name == "HumanoidRootPart" then
                        part.Transparency = 1
                    else
                        part.Transparency = 0
                    end
                    
                    if part.Name == "Head" then
                        for _, child in pairs(part:GetChildren()) do
                            if child:IsA("Decal") then
                                child.Transparency = 0
                            end
                        end
                    end
                elseif part:IsA("Accessory") then
                    local Handle = part:FindFirstChild("Handle")
                    if Handle then
                        Handle.Transparency = 0
                    end
                elseif part:IsA("Decal") then
                    part.Transparency = 0
                end
            end
        end
        
        -- Restore camera
        Player.CameraMaxZoomDistance = 400
        
        print("👻 Fake Invisible: OFF")
    end)
end

function FakeInvisible:Toggle()
    if self.Active then
        self:Disable()
    else
        self:Enable()
    end
    return self.Active
end

-- ============================================
-- 🦅 ADVANCED FLY SYSTEM
-- ============================================
local FlySystem = {
    Active = false,
    Speed = 50,
    BodyVel = nil,
    BodyGyro = nil,
    NoclipConnection = nil
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
            
            print("🦅 Fly: ON (Auto Noclip)")
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
        
        local Char = Player.Character
        if Char then
            for _, part in pairs(Char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
        
        print("🦅 Fly: OFF")
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
-- 📍 WAYPOINT TELEPORT SYSTEM
-- ============================================
local WaypointSystem = {
    SavedPosition = nil
}

function WaypointSystem:SavePosition()
    pcall(function()
        local Char = Player.Character
        if Char and Char:FindFirstChild("HumanoidRootPart") then
            self.SavedPosition = Char.HumanoidRootPart.CFrame
            print("📍 Position Saved!")
            return true
        end
    end)
    return false
end

function WaypointSystem:TeleportToSaved()
    if not self.SavedPosition then
        warn("⚠️ No position saved!")
        return false
    end
    
    pcall(function()
        local Char = Player.Character
        if Char and Char:FindFirstChild("HumanoidRootPart") then
            Char.HumanoidRootPart.CFrame = self.SavedPosition
            print("📍 Teleported to saved position!")
            return true
        end
    end)
    return false
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
    
    Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function(char)
            if self.Active then
                task.wait(0.5)
                self:AddPlayer(char)
            end
        end)
    end)
    
    print("👁️ ESP: ON")
end

function ESP:AddPlayer(char)
    pcall(function()
        if char:FindFirstChild("ESP_HL") then return end
        
        local hl = Instance.new("Highlight")
        hl.Name = "ESP_HL"
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
    print("👁️ ESP: OFF")
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
    
    print("🚫 Noclip: ON")
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
    
    print("🚫 Noclip: OFF")
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
-- ⚡ SPEED & JUMP SYSTEMS
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
-- 🎨 GUI CREATION
-- ============================================
local Gui = Instance.new("ScreenGui")
Gui.Name = "GhostMenuV40"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = Player.PlayerGui

-- Mini Button
local MiniBtn = Instance.new("TextButton")
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

task.spawn(function()
    while MiniBtn.Parent do
        for hue = 0, 360, 3 do
            if not MiniBtn.Parent then break end
            MiniStroke.Color = Color3.fromHSV(hue/360, 1, 1)
            task.wait(0.05)
        end
    end
end)

-- Main Frame
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 420, 0, 540)
Main.Position = UDim2.new(0.5, -210, 0.5, -270)
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

-- Header
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
Title.Text = "👻 GHOST MENU v40"
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

-- Scroll Frame
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

-- Button Creator
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
    
    Btn.MouseButton1Click:Connect(function()
        local state = callback()
        
        if state then
            Status.BackgroundColor3 = Color3.fromRGB(0, 220, 100)
            StatusText.Text = "ON"
        else
            Status.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
            StatusText.Text = "OFF"
        end
    end)
end

-- Special Waypoint Button
local function CreateWaypointButton()
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -12, 0, 100)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Frame.BorderSizePixel = 0
    Frame.Parent = Scroll
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Frame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(255, 150, 0)
    Stroke.Thickness = 2.5
    Stroke.Transparency = 0.5
    Stroke.Parent = Frame
    
    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(0, 50, 0, 50)
    Icon.Position = UDim2.new(0, 8, 0, 8)
    Icon.BackgroundTransparency = 1
    Icon.Text = "📍"
    Icon.TextColor3 = Color3.fromRGB(255, 150, 0)
    Icon.TextSize = 32
    Icon.Font = Enum.Font.GothamBold
    Icon.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -70, 0, 30)
    Label.Position = UDim2.new(0, 65, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = "Waypoint System"
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 18
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    -- Save Button
    local SaveBtn = Instance.new("TextButton")
    SaveBtn.Size = UDim2.new(0.45, -10, 0, 40)
    SaveBtn.Position = UDim2.new(0, 10, 1, -48)
    SaveBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    SaveBtn.Text = "💾 SAVE"
    SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SaveBtn.TextSize = 16
    SaveBtn.Font = Enum.Font.GothamBold
    SaveBtn.Parent = Frame
    
    local SaveCorner = Instance.new("UICorner")
    SaveCorner.CornerRadius = UDim.new(0, 10)
    SaveCorner.Parent = SaveBtn
    
    -- Teleport Button
    local TpBtn = Instance.new("TextButton")
    TpBtn.Size = UDim2.new(0.45, -10, 0, 40)
    TpBtn.Position = UDim2.new(0.55, 0, 1, -48)
    TpBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    TpBtn.Text = "⚡ TELEPORT"
    TpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TpBtn.TextSize = 16
    TpBtn.Font = Enum.Font.GothamBold
    TpBtn.Parent = Frame
    
    local TpCorner = Instance.new("UICorner")
    TpCorner.CornerRadius = UDim.new(0, 10)
    TpCorner.Parent = TpBtn
    
    SaveBtn.MouseButton1Click:Connect(function()
        WaypointSystem:SavePosition()
        SaveBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        task.wait(0.3)
        SaveBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end)
    
    TpBtn.MouseButton1Click:Connect(function()
        WaypointSystem:TeleportToSaved()
        TpBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
        task.wait(0.3)
        TpBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    end)
end

-- Fly Controls
local FlyControls = Instance.new("Frame")
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
    end)
    
    btn.MouseButton1Up:Connect(function()
        FlySystem:StopMovement()
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        stroke.Transparency = 0.5
    end)
    
    btn.MouseLeave:Connect(function()
        FlySystem:StopMovement()
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        stroke.Transparency = 0.5
    end)
end

CreateFlyBtn("↑", UDim2.new(0.5, -32.5, 0, 50), "forward")
CreateFlyBtn("↓", UDim2.new(0.5, -32.5, 0, 125), "backward")
CreateFlyBtn("←", UDim2.new(0, 12, 0, 87.5), "left")
CreateFlyBtn("→", UDim2.new(1, -77, 0, 87.5), "right")

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

-- Create Buttons
CreateButton("Bypass Anti-Cheat", "🛡️", Color3.fromRGB(0, 255, 255), function()
    BypassEngine:Initialize()
    return true
end)

CreateButton("God Mode", "👑", Color3.fromRGB(255, 215, 0), function()
    return GodMode:Toggle()
end)

CreateButton("Fake Invisible (Clone)", "👻", Color3.fromRGB(170, 0, 255), function()
    return FakeInvisible:Toggle()
end)

CreateButton("Fly + Auto Noclip", "🦅", Color3.fromRGB(100, 200, 255), function()
    local state = FlySystem:Toggle()
    FlyControls.Visible = state
    return state
end)

CreateButton("ESP (See Players)", "👁️", Color3.fromRGB(255, 100, 100), function()
    return ESP:Toggle()
end)

CreateButton("Noclip", "🚪", Color3.fromRGB(200, 100, 255), function()
    return Noclip:Toggle()
end)

CreateButton("Speed x6", "⚡", Color3.fromRGB(255, 255, 0), function()
    return Speed:Toggle()
end)

CreateButton("Jump x4", "🚀", Color3.fromRGB(0, 255, 150), function()
    return Jump:Toggle()
end)

CreateWaypointButton()

-- Menu Toggle
MiniBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    
    if Main.Visible then
        Main.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 420, 0, 540)
        }):Play()
    end
end)

-- Auto-reapply
Player.CharacterAdded:Connect(function(char)
    task.wait(1)
    
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

-- Notification
local Notif = Instance.new("TextLabel")
Notif.Size = UDim2.new(0, 350, 0, 50)
Notif.Position = UDim2.new(0.5, -175, 0, 25)
Notif.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Notif.BorderSizePixel = 0
Notif.Text = "✅ GHOST MENU v40 | FAKE CLONE SYSTEM"
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
    Position = UDim2.new(0.5, -175, 0, -60)
}):Play()
task.wait(0.5)
Notif:Destroy()

print("============================================")
print("👻 GHOST MENU v40.0 - FAKE CHARACTER SYSTEM")
print("============================================")
print("✅ Fake Character Invisible: Ready")
print("✅ Waypoint System: Ready")
print("✅ All Features: Online")
print("============================================")

BypassEngine:Initialize()
