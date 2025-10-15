-- ⚡ PHANTOM MENU v25.0 - ADVANCED BYPASS & STEALTH
-- استفاده از پیشرفته‌ترین تکنیک‌های لوا

if game:GetService("CoreGui"):FindFirstChild("PhantomEngine") then
    game:GetService("CoreGui"):FindFirstChild("PhantomEngine"):Destroy()
end

task.wait(0.5)

-- ============================================
-- 🔧 CORE INITIALIZATION
-- ============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Camera = workspace.CurrentCamera

-- ============================================
-- 🛡️ ADVANCED BYPASS SYSTEM
-- ============================================
local BypassEngine = {}
BypassEngine.Active = false
BypassEngine.Hooks = {}

function BypassEngine:Initialize()
    if self.Active then return end
    self.Active = true
    
    -- Layer 1: Metamethod Hooks
    task.spawn(function()
        local success = pcall(function()
            local mt = getrawmetatable(game)
            local backup = {
                __namecall = mt.__namecall,
                __index = mt.__index,
                __newindex = mt.__newindex
            }
            
            setreadonly(mt, false)
            
            -- Advanced __namecall hook
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                local args = {...}
                local caller = getcallingscript()
                
                -- Block damage/death
                if method == "TakeDamage" or method == "BreakJoints" then
                    return nil
                end
                
                -- Block kicks
                if method == "Kick" then
                    return nil
                end
                
                -- Filter remotes
                if method == "FireServer" or method == "InvokeServer" then
                    local name = tostring(self):lower()
                    local blocked = {"kick", "ban", "kill", "damage", "death", "anticheat", "detected", "flag"}
                    for _, word in ipairs(blocked) do
                        if name:find(word) then
                            return nil
                        end
                    end
                end
                
                return backup.__namecall(self, ...)
            end)
            
            -- Advanced __index hook
            mt.__index = newcclosure(function(self, key)
                -- Hide modifications
                if self:IsA("Humanoid") and self.Parent == Player.Character then
                    if key == "WalkSpeed" then
                        return 16
                    elseif key == "JumpPower" or key == "JumpHeight" then
                        return 50
                    elseif key == "Health" then
                        return self:GetPropertyChangedSignal("Health"):Wait() or 100
                    end
                end
                
                return backup.__index(self, key)
            end)
            
            -- Advanced __newindex hook
            mt.__newindex = newcclosure(function(self, key, value)
                -- Block external health changes
                if self:IsA("Humanoid") and self.Parent == Player.Character then
                    if key == "Health" and value < self.MaxHealth then
                        if caller and caller ~= Player then
                            return
                        end
                    end
                end
                
                return backup.__newindex(self, key, value)
            end)
            
            setreadonly(mt, true)
        end)
        
        if success then
            print("✅ Metamethod Bypass: Active")
        end
    end)
    
    -- Layer 2: Connection Disabler
    task.spawn(function()
        pcall(function()
            for _, v in pairs(getconnections(Player.Idled)) do
                v:Disable()
            end
        end)
    end)
    
    -- Layer 3: Script Scanner & Destroyer
    task.spawn(function()
        while self.Active do
            pcall(function()
                for _, obj in pairs(game:GetDescendants()) do
                    if obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
                        local name = obj.Name:lower()
                        if name:find("anti") or name:find("detect") or name:find("ban") or name:find("kick") then
                            obj.Disabled = true
                            task.wait(0.1)
                            obj:Destroy()
                        end
                    end
                end
            end)
            task.wait(2)
        end
    end)
    
    -- Layer 4: Remote Spy & Blocker
    task.spawn(function()
        pcall(function()
            for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
                if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
                    local name = remote.Name:lower()
                    if name:find("log") or name:find("report") or name:find("flag") then
                        remote:Destroy()
                    end
                end
            end
        end)
    end)
end

-- ============================================
-- 💎 GOD MODE ENGINE
-- ============================================
local GodMode = {}
GodMode.Active = false
GodMode.Connections = {}

function GodMode:Enable()
    self.Active = true
    
    -- Cleanup old connections
    for _, conn in pairs(self.Connections) do
        conn:Disconnect()
    end
    self.Connections = {}
    
    -- Multi-layer protection
    local conn = RunService.Heartbeat:Connect(function()
        if not self.Active then return end
        
        pcall(function()
            local Char = Player.Character
            if not Char then return end
            
            local Humanoid = Char:FindFirstChildOfClass("Humanoid")
            local RootPart = Char:FindFirstChild("HumanoidRootPart")
            
            if Humanoid then
                -- Layer 1: Infinite health
                Humanoid.MaxHealth = math.huge
                Humanoid.Health = math.huge
                
                -- Layer 2: Disable death states
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                
                -- Layer 3: Remove fall damage
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                
                -- Layer 4: Disconnect death events
                for _, signal in pairs(getconnections(Humanoid.Died)) do
                    signal:Disable()
                end
                
                for _, signal in pairs(getconnections(Humanoid.HealthChanged)) do
                    signal:Disable()
                end
            end
            
            if RootPart then
                -- Layer 5: Anti-void
                if RootPart.Position.Y < -100 then
                    RootPart.CFrame = CFrame.new(0, 100, 0)
                end
                
                -- Layer 6: Network ownership
                RootPart:SetNetworkOwner(Player)
            end
            
            -- Layer 7: Force field
            if not Char:FindFirstChildOfClass("ForceField") then
                local ff = Instance.new("ForceField")
                ff.Visible = false
                ff.Parent = Char
            end
        end)
    end)
    
    table.insert(self.Connections, conn)
end

function GodMode:Disable()
    self.Active = false
    
    for _, conn in pairs(self.Connections) do
        conn:Disconnect()
    end
    self.Connections = {}
    
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
end

-- ============================================
-- 👻 ADVANCED INVISIBLE SYSTEM
-- ============================================
local InvisibleMode = {}
InvisibleMode.Active = false
InvisibleMode.OriginalParts = {}

function InvisibleMode:Enable()
    if self.Active then return end
    self.Active = true
    
    task.spawn(function()
        pcall(function()
            local Char = Player.Character
            if not Char then return end
            
            local RootPart = Char:FindFirstChild("HumanoidRootPart")
            if not RootPart then return end
            
            -- Method 1: Character cloning technique
            local Clone = Char:Clone()
            Clone.Parent = workspace
            Clone.Name = Player.Name .. "_Clone"
            
            -- Hide original
            for _, part in pairs(Char:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    self.OriginalParts[part] = part.Transparency
                    part.Transparency = 1
                elseif part:IsA("Accessory") then
                    part.Handle.Transparency = 1
                end
            end
            
            -- Method 2: Remove name tag
            if Char:FindFirstChild("Head") then
                for _, child in pairs(Char.Head:GetChildren()) do
                    if child:IsA("BillboardGui") or child:IsA("SurfaceGui") then
                        child:Destroy()
                    end
                end
            end
            
            -- Method 3: Remove character mesh
            for _, obj in pairs(Char:GetDescendants()) do
                if obj:IsA("SpecialMesh") or obj:IsA("CharacterMesh") then
                    obj:Destroy()
                end
            end
            
            -- Method 4: FE invisible (works on some games)
            local FEInvis = RunService.Heartbeat:Connect(function()
                if not self.Active then return end
                pcall(function()
                    RootPart.CFrame = RootPart.CFrame * CFrame.new(0, 0, 0)
                    for _, part in pairs(Char:GetChildren()) do
                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                            part.CFrame = CFrame.new(0, -1000, 0)
                        end
                    end
                end)
            end)
            
            InvisibleMode.Connection = FEInvis
        end)
    end)
end

function InvisibleMode:Disable()
    self.Active = false
    
    if self.Connection then
        self.Connection:Disconnect()
    end
    
    pcall(function()
        local Char = Player.Character
        if Char then
            for part, transparency in pairs(self.OriginalParts) do
                if part and part.Parent then
                    part.Transparency = transparency
                end
            end
        end
        
        -- Remove clone
        if workspace:FindFirstChild(Player.Name .. "_Clone") then
            workspace[Player.Name .. "_Clone"]:Destroy()
        end
    end)
    
    self.OriginalParts = {}
end

-- ============================================
-- 🦅 MOBILE FLY SYSTEM
-- ============================================
local FlySystem = {}
FlySystem.Active = false
FlySystem.Speed = 50
FlySystem.BodyVelocity = nil
FlySystem.BodyGyro = nil

function FlySystem:Start()
    if self.Active then return end
    self.Active = true
    
    pcall(function()
        local Char = Player.Character
        if not Char then return end
        
        local RootPart = Char:FindFirstChild("HumanoidRootPart")
        if not RootPart then return end
        
        -- Create physics objects
        self.BodyVelocity = Instance.new("BodyVelocity")
        self.BodyVelocity.Velocity = Vector3.new(0, 0, 0)
        self.BodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        self.BodyVelocity.P = 9e4
        self.BodyVelocity.Parent = RootPart
        
        self.BodyGyro = Instance.new("BodyGyro")
        self.BodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        self.BodyGyro.P = 9e4
        self.BodyGyro.CFrame = RootPart.CFrame
        self.BodyGyro.Parent = RootPart
    end)
end

function FlySystem:Stop()
    self.Active = false
    
    if self.BodyVelocity then
        self.BodyVelocity:Destroy()
        self.BodyVelocity = nil
    end
    
    if self.BodyGyro then
        self.BodyGyro:Destroy()
        self.BodyGyro = nil
    end
end

function FlySystem:Move(direction)
    if not self.Active or not self.BodyVelocity then return end
    
    pcall(function()
        local velocity = Vector3.new(0, 0, 0)
        
        if direction == "up" then
            velocity = Vector3.new(0, self.Speed, 0)
        elseif direction == "down" then
            velocity = Vector3.new(0, -self.Speed, 0)
        elseif direction == "left" then
            velocity = -Camera.CFrame.RightVector * self.Speed
        elseif direction == "right" then
            velocity = Camera.CFrame.RightVector * self.Speed
        elseif direction == "forward" then
            velocity = Camera.CFrame.LookVector * self.Speed
        elseif direction == "backward" then
            velocity = -Camera.CFrame.LookVector * self.Speed
        end
        
        self.BodyVelocity.Velocity = velocity
        self.BodyGyro.CFrame = Camera.CFrame
    end)
end

-- ============================================
-- 👁️ ESP SYSTEM
-- ============================================
local ESP = {}
ESP.Active = false
ESP.Objects = {}

function ESP:Enable()
    self.Active = true
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character then
            self:AddESP(plr.Character)
        end
    end
    
    Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function(char)
            if self.Active then
                task.wait(0.5)
                self:AddESP(char)
            end
        end)
    end)
end

function ESP:AddESP(character)
    pcall(function()
        if character:FindFirstChild("ESP_Highlight") then return end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.FillColor = Color3.fromRGB(255, 50, 50)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = character
        
        table.insert(self.Objects, highlight)
    end)
end

function ESP:Disable()
    self.Active = false
    
    for _, obj in pairs(self.Objects) do
        pcall(function() obj:Destroy() end)
    end
    
    self.Objects = {}
end

-- ============================================
-- 🚫 NOCLIP SYSTEM
-- ============================================
local Noclip = {}
Noclip.Active = false
Noclip.Connection = nil

function Noclip:Enable()
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
end

-- ============================================
-- ⚡ SPEED & JUMP BOOST
-- ============================================
local SpeedBoost = {}
SpeedBoost.Active = false
SpeedBoost.OriginalSpeed = 16

function SpeedBoost:Toggle()
    self.Active = not self.Active
    
    pcall(function()
        local Char = Player.Character
        if Char then
            local Humanoid = Char:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                if self.Active then
                    self.OriginalSpeed = Humanoid.WalkSpeed
                    Humanoid.WalkSpeed = 100
                else
                    Humanoid.WalkSpeed = self.OriginalSpeed
                end
            end
        end
    end)
    
    return self.Active
end

local JumpBoost = {}
JumpBoost.Active = false
JumpBoost.OriginalJump = 50

function JumpBoost:Toggle()
    self.Active = not self.Active
    
    pcall(function()
        local Char = Player.Character
        if Char then
            local Humanoid = Char:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                if self.Active then
                    self.OriginalJump = Humanoid.JumpPower
                    Humanoid.JumpPower = 200
                    Humanoid.UseJumpPower = true
                else
                    Humanoid.JumpPower = self.OriginalJump
                end
            end
        end
    end)
    
    return self.Active
end

-- ============================================
-- 🎨 GUI CREATION
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PhantomEngine"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

-- Mini Toggle Button
local MiniButton = Instance.new("TextButton")
MiniButton.Name = "MiniToggle"
MiniButton.Size = UDim2.new(0, 60, 0, 60)
MiniButton.Position = UDim2.new(0, 20, 0.5, -30)
MiniButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MiniButton.BorderSizePixel = 0
MiniButton.Text = ""
MiniButton.Active = true
MiniButton.Draggable = true
MiniButton.Parent = ScreenGui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(1, 0)
MiniCorner.Parent = MiniButton

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Thickness = 3
MiniStroke.Parent = MiniButton

-- Rainbow effect for mini button
task.spawn(function()
    local hue = 0
    while MiniButton.Parent do
        hue = (hue + 1) % 360
        MiniStroke.Color = Color3.fromHSV(hue/360, 1, 1)
        task.wait(0.03)
    end
end)

local MiniIcon = Instance.new("TextLabel")
MiniIcon.Size = UDim2.new(1, 0, 1, 0)
MiniIcon.BackgroundTransparency = 1
MiniIcon.Text = "👻"
MiniIcon.TextScaled = true
MiniIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniIcon.Font = Enum.Font.GothamBold
MiniIcon.Parent = MiniButton

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 500)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
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
MainStroke.Parent = MainFrame

task.spawn(function()
    local hue = 0
    while MainFrame.Parent do
        hue = (hue + 1) % 360
        MainStroke.Color = Color3.fromHSV(hue/360, 1, 1)
        task.wait(0.03)
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
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 28
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

local CloseBtnCorner = Instance.new("UICorner")
CloseBtnCorner.CornerRadius = UDim.new(0, 10)
CloseBtnCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Scroll Frame
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -70)
ScrollFrame.Position = UDim2.new(0, 10, 0, 60)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 255)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.Parent = MainFrame

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 10)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = ScrollFrame

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
end)

-- Button Creator
local function CreateButton(text, icon, color, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 55)
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
    BtnStroke.Transparency = 0.6
    BtnStroke.Parent = Button
    
    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(0, 45, 0, 45)
    Icon.Position = UDim2.new(0, 5, 0.5, -22.5)
    Icon.BackgroundTransparency = 1
    Icon.Text = icon
    Icon.TextColor3 = color
    Icon.TextSize = 30
    Icon.Font = Enum.Font.GothamBold
    Icon.Parent = Button
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -120, 1, 0)
    Label.Position = UDim2.new(0, 55, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 16
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Button
    
    local Status = Instance.new("Frame")
    Status.Size = UDim2.new(0, 50, 0, 30)
    Status.Position = UDim2.new(1, -55, 0.5, -15)
    Status.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Status.BorderSizePixel = 0
    Status.Parent = Button
    
    local StatusCorner = Instance.new("UICorner")
    StatusCorner.CornerRadius = UDim.new(0, 8)
    StatusCorner.Parent = Status
    
    local StatusText = Instance.new("TextLabel")
    StatusText.Size = UDim2.new(1, 0, 1, 0)
    StatusText.BackgroundTransparency = 1
    StatusText.Text = "OFF"
    StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatusText.TextSize = 14
    StatusText.Font = Enum.Font.GothamBold
    StatusText.Parent = Status
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 40)}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 30)}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0.6}):Play()
    end)
    
    Button.MouseButton1Click:Connect(function()
        local state = callback()
        if state then
            Status.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            StatusText.Text = "ON"
        else
            Status.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            StatusText.Text = "OFF"
        end
    end)
    
    return Button
end

-- ============================================
-- 🎮 FLY CONTROLS (MOBILE)
-- ============================================
local FlyControls = Instance.new("Frame")
FlyControls.Name = "FlyControls"
FlyControls.Size = UDim2.new(0, 220, 0, 220)
FlyControls.Position = UDim2.new(1, -240, 0.5, -110)
FlyControls.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
FlyControls.BorderSizePixel = 0
FlyControls.Visible = false
FlyControls.Active = true
FlyControls.Draggable = true
FlyControls.Parent = ScreenGui

local FlyControlsCorner = Instance.new("UICorner")
FlyControlsCorner.CornerRadius = UDim.new(0, 15)
FlyControlsCorner.Parent = FlyControls

local FlyControlsStroke = Instance.new("UIStroke")
FlyControlsStroke.Thickness = 3
FlyControlsStroke.Parent = FlyControls

task.spawn(function()
    local hue = 0
    while FlyControls.Parent do
        hue = (hue + 1) % 360
        FlyControlsStroke.Color = Color3.fromHSV(hue/360, 1, 1)
        task.wait(0.03)
    end
end)

local function CreateFlyButton(text, position, direction)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 60, 0, 60)
    btn.Position = position
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 24
    btn.Font = Enum.Font.GothamBold
    btn.Parent = FlyControls
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = btn
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 100, 255)
    stroke.Thickness = 2
    stroke.Transparency = 0.5
    stroke.Parent = btn
    
    btn.MouseButton1Down:Connect(function()
        FlySystem:Move(direction)
        btn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        stroke.Transparency = 0
    end)
    
    btn.MouseButton1Up:Connect(function()
        FlySystem:Move("stop")
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        stroke.Transparency = 0.5
    end)
    
    return btn
end

-- Fly Buttons Layout
CreateFlyButton("⬆", UDim2.new(0.5, -30, 0, 10), "up")
CreateFlyButton("⬇", UDim2.new(0.5, -30, 1, -70), "down")
CreateFlyButton("⬅", UDim2.new(0, 10, 0.5, -30), "left")
CreateFlyButton("➡", UDim2.new(1, -70, 0.5, -30), "right")

-- Speed Control
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -20, 0, 25)
SpeedLabel.Position = UDim2.new(0, 10, 0.5, 40)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: " .. FlySystem.Speed
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 16
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.Parent = FlyControls

local function CreateSpeedButton(text, pos, change)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.45, 0, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 20
    btn.Font = Enum.Font.GothamBold
    btn.Parent = FlyControls
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        FlySystem.Speed = math.clamp(FlySystem.Speed + change, 10, 300)
        SpeedLabel.Text = "Speed: " .. FlySystem.Speed
    end)
end

CreateSpeedButton("-", UDim2.new(0.025, 0, 0.5, 70), -10)
CreateSpeedButton("+", UDim2.new(0.525, 0, 0.5, 70), 10)

-- ============================================
-- 📋 CREATE ALL BUTTONS
-- ============================================

CreateButton("Bypass Anti-Cheat", "🛡️", Color3.fromRGB(0, 255, 255), function()
    BypassEngine:Initialize()
    return true
end)

CreateButton("God Mode (Immortal)", "👑", Color3.fromRGB(255, 215, 0), function()
    if not GodMode.Active then
        GodMode:Enable()
    else
        GodMode:Disable()
    end
    return GodMode.Active
end)

CreateButton("Invisible Mode (EXTREME)", "👻", Color3.fromRGB(150, 0, 255), function()
    if not InvisibleMode.Active then
        InvisibleMode:Enable()
    else
        InvisibleMode:Disable()
    end
    return InvisibleMode.Active
end)

CreateButton("Fly Mode (Mobile Controls)", "🦅", Color3.fromRGB(100, 200, 255), function()
    if not FlySystem.Active then
        FlySystem:Start()
        FlyControls.Visible = true
    else
        FlySystem:Stop()
        FlyControls.Visible = false
    end
    return FlySystem.Active
end)

CreateButton("ESP (See All Players)", "👁️", Color3.fromRGB(255, 100, 100), function()
    if not ESP.Active then
        ESP:Enable()
    else
        ESP:Disable()
    end
    return ESP.Active
end)

CreateButton("Noclip (Walk Through Walls)", "🚪", Color3.fromRGB(200, 100, 255), function()
    if not Noclip.Active then
        Noclip:Enable()
    else
        Noclip:Disable()
    end
    return Noclip.Active
end)

CreateButton("Speed Boost (x6)", "⚡", Color3.fromRGB(255, 255, 0), function()
    return SpeedBoost:Toggle()
end)

CreateButton("Jump Boost (x4)", "🚀", Color3.fromRGB(0, 255, 150), function()
    return JumpBoost:Toggle()
end)

CreateButton("Teleport to Mouse (Click)", "🎯", Color3.fromRGB(255, 100, 200), function()
    Mouse.Button1Down:Connect(function()
        pcall(function()
            local Char = Player.Character
            if Char and Char:FindFirstChild("HumanoidRootPart") then
                Char.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 5, 0))
            end
        end)
    end)
    return true
end)

-- ============================================
-- 🎮 TOGGLE MENU
-- ============================================
MiniButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    
    if MainFrame.Visible then
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 400, 0, 500)
        }):Play()
    end
end)

-- ============================================
-- 🔄 AUTO-REAPPLY ON RESPAWN
-- ============================================
Player.CharacterAdded:Connect(function(char)
    task.wait(1)
    
    if GodMode.Active then
        GodMode.Active = false
        GodMode:Enable()
    end
    
    if SpeedBoost.Active then
        task.wait(0.5)
        pcall(function()
            local Humanoid = char:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                Humanoid.WalkSpeed = 100
            end
        end)
    end
    
    if JumpBoost.Active then
        task.wait(0.5)
        pcall(function()
            local Humanoid = char:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                Humanoid.JumpPower = 200
                Humanoid.UseJumpPower = true
            end
        end)
    end
end)

-- ============================================
-- ✅ INITIALIZATION
-- ============================================
print("👻 PHANTOM MENU v25.0 LOADED")
print("✅ Advanced Bypass System: Ready")
print("✅ Multi-Layer God Mode: Ready")
print("✅ Stealth Invisible: Ready")
print("✅ Mobile Fly Controls: Ready")
print("✅ All Features: Operational")

-- Auto-activate bypass
BypassEngine:Initialize()

-- Notification
local notification = Instance.new("TextLabel")
notification.Size = UDim2.new(0, 300, 0, 50)
notification.Position = UDim2.new(0.5, -150, 0, 20)
notification.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
notification.BorderSizePixel = 0
notification.Text = "✅ PHANTOM MENU LOADED"
notification.TextColor3 = Color3.fromRGB(0, 255, 100)
notification.TextScaled = true
notification.Font = Enum.Font.GothamBold
notification.Parent = ScreenGui

local notifCorner = Instance.new("UICorner")
notifCorner.CornerRadius = UDim.new(0, 10)
notifCorner.Parent = notification

task.wait(3)
notification:Destroy()
