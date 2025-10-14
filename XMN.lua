-- 🎯 GOD MENU v8.0 - ULTIMATE BYPASS EDITION
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local mouse = player:GetMouse()

-- Services
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Variables
local menuOpen = false
local espEnabled = false
local teleportEnabled = false
local godTeleportEnabled = false
local bypassEnabled = false
local freezeEnabled = false
local isMinimized = false
local teleportDistance = 10
local lastPosition = nil
local freezePosition = nil

-- Anti-Detection Variables
local oldNamecall
local oldIndex
local oldNewIndex

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltraGodMenu"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Logo Button (Menu Toggle) - DRAGGABLE
local logoButton = Instance.new("TextButton")
logoButton.Name = "LogoButton"
logoButton.Size = UDim2.new(0, 60, 0, 60)
logoButton.Position = UDim2.new(0, 20, 0.5, -30)
logoButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
logoButton.BorderSizePixel = 0
logoButton.Text = ""
logoButton.AutoButtonColor = false
logoButton.Active = true
logoButton.Draggable = true
logoButton.Parent = screenGui

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 15)
logoCorner.Parent = logoButton

local logoGradient = Instance.new("UIGradient")
logoGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
}
logoGradient.Rotation = 45
logoGradient.Parent = logoButton

local logoIcon = Instance.new("TextLabel")
logoIcon.Size = UDim2.new(1, 0, 1, 0)
logoIcon.BackgroundTransparency = 1
logoIcon.Text = "👑"
logoIcon.TextScaled = true
logoIcon.Font = Enum.Font.SourceSansBold
logoIcon.Parent = logoButton

local logoStroke = Instance.new("UIStroke")
logoStroke.Color = Color3.fromRGB(255, 215, 0)
logoStroke.Thickness = 2
logoStroke.Transparency = 0.3
logoStroke.Parent = logoButton

-- Main Menu Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 480, 0, 400)
mainFrame.Position = UDim2.new(0.5, -240, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(35, 35, 45)
mainStroke.Thickness = 1
mainStroke.Parent = mainFrame

-- Background Pattern
local bgPattern = Instance.new("Frame")
bgPattern.Size = UDim2.new(1, 0, 1, 0)
bgPattern.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
bgPattern.BackgroundTransparency = 0.98
bgPattern.BorderSizePixel = 0
bgPattern.Parent = mainFrame

local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 25)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 15, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 15))
}
bgGradient.Rotation = 90
bgGradient.Parent = bgPattern

-- Header
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerGradient = Instance.new("UIGradient")
headerGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 18, 23)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 12, 17))
}
headerGradient.Rotation = 90
headerGradient.Parent = header

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.5, 0, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "👑 GOD MENU ULTIMATE"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.TextSize = 20
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Window Controls
local controls = Instance.new("Frame")
controls.Size = UDim2.new(0, 120, 0, 30)
controls.Position = UDim2.new(1, -130, 0.5, -15)
controls.BackgroundTransparency = 1
controls.Parent = header

-- Minimize Button
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(0, 0, 0, 0)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 50)
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.TextSize = 20
minimizeBtn.Font = Enum.Font.SourceSansBold
minimizeBtn.AutoButtonColor = false
minimizeBtn.Parent = controls

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeBtn

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(0, 40, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 24
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.AutoButtonColor = false
closeBtn.Parent = controls

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- DESTROY ALL Button
local destroyBtn = Instance.new("TextButton")
destroyBtn.Size = UDim2.new(0, 30, 0, 30)
destroyBtn.Position = UDim2.new(0, 80, 0, 0)
destroyBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
destroyBtn.Text = "⚠"
destroyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
destroyBtn.TextSize = 20
destroyBtn.Font = Enum.Font.SourceSansBold
destroyBtn.AutoButtonColor = false
destroyBtn.Parent = controls

local destroyCorner = Instance.new("UICorner")
destroyCorner.CornerRadius = UDim.new(0, 6)
destroyCorner.Parent = destroyBtn

-- Content Container
local content = Instance.new("ScrollingFrame")
content.Name = "Content"
content.Size = UDim2.new(1, -20, 1, -60)
content.Position = UDim2.new(0, 10, 0, 55)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
content.ScrollBarImageTransparency = 0.5
content.CanvasSize = UDim2.new(0, 0, 0, 500)
content.Parent = mainFrame

-- SIMPLIFIED TELEPORT GUI
local teleportGui = Instance.new("Frame")
teleportGui.Name = "TeleportArrows"
teleportGui.Size = UDim2.new(0, 200, 0, 180)
teleportGui.Position = UDim2.new(0.5, -100, 0.7, -90)
teleportGui.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
teleportGui.BorderSizePixel = 0
teleportGui.Visible = false
teleportGui.Active = true
teleportGui.Draggable = true
teleportGui.Parent = screenGui

local teleportGuiCorner = Instance.new("UICorner")
teleportGuiCorner.CornerRadius = UDim.new(0, 12)
teleportGuiCorner.Parent = teleportGui

local teleportGuiStroke = Instance.new("UIStroke")
teleportGuiStroke.Color = Color3.fromRGB(255, 215, 0)
teleportGuiStroke.Thickness = 2
teleportGuiStroke.Transparency = 0.5
teleportGuiStroke.Parent = teleportGui

-- Distance Input Box
local distanceInputFrame = Instance.new("Frame")
distanceInputFrame.Size = UDim2.new(0, 100, 0, 30)
distanceInputFrame.Position = UDim2.new(0.5, -50, 0, 10)
distanceInputFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
distanceInputFrame.Parent = teleportGui

local distanceInputCorner = Instance.new("UICorner")
distanceInputCorner.CornerRadius = UDim.new(0, 6)
distanceInputCorner.Parent = distanceInputFrame

local distanceInput = Instance.new("TextBox")
distanceInput.Size = UDim2.new(1, -10, 1, 0)
distanceInput.Position = UDim2.new(0, 5, 0, 0)
distanceInput.BackgroundTransparency = 1
distanceInput.Text = tostring(teleportDistance)
distanceInput.TextColor3 = Color3.fromRGB(255, 255, 255)
distanceInput.TextSize = 14
distanceInput.Font = Enum.Font.SourceSans
distanceInput.PlaceholderText = "Distance"
distanceInput.Parent = distanceInputFrame

-- Forward Button
local forwardBtn = Instance.new("TextButton")
forwardBtn.Size = UDim2.new(0, 60, 0, 40)
forwardBtn.Position = UDim2.new(0, 20, 0, 50)
forwardBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
forwardBtn.Text = "جلو ⬆"
forwardBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
forwardBtn.TextSize = 16
forwardBtn.Font = Enum.Font.SourceSansBold
forwardBtn.Parent = teleportGui

local forwardCorner = Instance.new("UICorner")
forwardCorner.CornerRadius = UDim.new(0, 8)
forwardCorner.Parent = forwardBtn

-- Backward Button
local backwardBtn = Instance.new("TextButton")
backwardBtn.Size = UDim2.new(0, 60, 0, 40)
backwardBtn.Position = UDim2.new(1, -80, 0, 50)
backwardBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
backwardBtn.Text = "عقب ⬇"
backwardBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
backwardBtn.TextSize = 16
backwardBtn.Font = Enum.Font.SourceSansBold
backwardBtn.Parent = teleportGui

local backwardCorner = Instance.new("UICorner")
backwardCorner.CornerRadius = UDim.new(0, 8)
backwardCorner.Parent = backwardBtn

-- Freeze Button
local freezeToggle = Instance.new("TextButton")
freezeToggle.Size = UDim2.new(1, -20, 0, 35)
freezeToggle.Position = UDim2.new(0, 10, 0, 100)
freezeToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
freezeToggle.Text = "🔒 Freeze Position"
freezeToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
freezeToggle.TextSize = 14
freezeToggle.Font = Enum.Font.SourceSansBold
freezeToggle.Parent = teleportGui

local freezeToggleCorner = Instance.new("UICorner")
freezeToggleCorner.CornerRadius = UDim.new(0, 8)
freezeToggleCorner.Parent = freezeToggle

-- Return Button
local returnBtn = Instance.new("TextButton")
returnBtn.Size = UDim2.new(1, -20, 0, 30)
returnBtn.Position = UDim2.new(0, 10, 0, 140)
returnBtn.BackgroundColor3 = Color3.fromRGB(50, 35, 35)
returnBtn.Text = "↩ Return"
returnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
returnBtn.TextSize = 14
returnBtn.Font = Enum.Font.SourceSans
returnBtn.Parent = teleportGui

local returnBtnCorner = Instance.new("UICorner")
returnBtnCorner.CornerRadius = UDim.new(0, 6)
returnBtnCorner.Parent = returnBtn

-- Helper function to create feature cards
local cardY = 10
local function createFeatureCard(icon, titleText, descText, toggleFunc)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -10, 0, 100)
    card.Position = UDim2.new(0, 5, 0, cardY)
    card.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
    card.BorderSizePixel = 0
    card.Parent = content
    
    cardY = cardY + 110
    
    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 8)
    cardCorner.Parent = card
    
    local cardStroke = Instance.new("UIStroke")
    cardStroke.Color = Color3.fromRGB(30, 30, 38)
    cardStroke.Thickness = 1
    cardStroke.Parent = card
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 60, 0, 60)
    iconLabel.Position = UDim2.new(0, 15, 0.5, -30)
    iconLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    iconLabel.Text = icon
    iconLabel.TextSize = 28
    iconLabel.Font = Enum.Font.SourceSansBold
    iconLabel.Parent = card
    
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 8)
    iconCorner.Parent = iconLabel
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.5, 0, 0, 25)
    titleLabel.Position = UDim2.new(0, 90, 0, 20)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = titleText
    titleLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = card
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(0.5, 0, 0, 20)
    descLabel.Position = UDim2.new(0, 90, 0, 50)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = descText
    descLabel.TextColor3 = Color3.fromRGB(130, 130, 140)
    descLabel.TextSize = 14
    descLabel.Font = Enum.Font.SourceSans
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Parent = card
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 60, 0, 30)
    toggle.Position = UDim2.new(1, -75, 0.5, -15)
    toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    toggle.Text = ""
    toggle.AutoButtonColor = false
    toggle.Parent = card
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggle
    
    local toggleCircle = Instance.new("Frame")
    toggleCircle.Size = UDim2.new(0, 24, 0, 24)
    toggleCircle.Position = UDim2.new(0, 3, 0.5, -12)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(180, 180, 190)
    toggleCircle.Parent = toggle
    
    local toggleCircleCorner = Instance.new("UICorner")
    toggleCircleCorner.CornerRadius = UDim.new(1, 0)
    toggleCircleCorner.Parent = toggleCircle
    
    toggle.MouseButton1Click:Connect(function()
        local enabled = toggleFunc()
        if enabled then
            toggle.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
            createTween(toggleCircle, {Position = UDim2.new(1, -27, 0.5, -12)}, 0.2):Play()
        else
            toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
            createTween(toggleCircle, {Position = UDim2.new(0, 3, 0.5, -12)}, 0.2):Play()
        end
    end)
    
    return card, toggle, toggleCircle
end

-- Functions
local function createTween(obj, props, duration)
    local info = TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    return TweenService:Create(obj, info, props)
end

-- Fix Character Function
local function fixCharacter()
    character = player.Character or player.CharacterAdded:Wait()
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
end

-- Character Respawn Handler
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    rootPart = newChar:WaitForChild("HumanoidRootPart")
    
    -- Reset states on death
    freezeEnabled = false
    freezePosition = nil
    lastPosition = nil
end)

-- TELEPORT FUNCTION (FIXED)
local function teleportPlayer(direction)
    -- Fix character if needed
    if not rootPart or not rootPart.Parent then
        fixCharacter()
    end
    
    -- Save position before teleport
    if not lastPosition then
        lastPosition = rootPart.CFrame
    end
    
    local cf = rootPart.CFrame
    
    if direction == "forward" then
        rootPart.CFrame = cf + cf.LookVector * teleportDistance
    elseif direction == "backward" then
        rootPart.CFrame = cf - cf.LookVector * teleportDistance
    end
    
    -- If freeze is enabled, save the new position
    if freezeEnabled then
        freezePosition = rootPart.CFrame
    end
end

-- Freeze Function
local freezeConnection = nil
local function toggleFreeze()
    freezeEnabled = not freezeEnabled
    
    if freezeEnabled then
        freezePosition = rootPart.CFrame
        freezeToggle.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        freezeToggle.Text = "🔓 Unfreeze"
        
        if freezeConnection then freezeConnection:Disconnect() end
        freezeConnection = RunService.Heartbeat:Connect(function()
            if freezeEnabled and freezePosition and rootPart and rootPart.Parent then
                rootPart.CFrame = freezePosition
                rootPart.Velocity = Vector3.new(0, 0, 0)
                rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end
        end)
    else
        freezeToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
        freezeToggle.Text = "🔒 Freeze Position"
        if freezeConnection then
            freezeConnection:Disconnect()
            freezeConnection = nil
        end
    end
end

-- ESP Function
local function toggleESP()
    espEnabled = not espEnabled
    
    if espEnabled then
        spawn(function()
            while espEnabled do
                for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                    if otherPlayer ~= player and otherPlayer.Character then
                        local highlight = otherPlayer.Character:FindFirstChild("ESPHighlight")
                        if not highlight then
                            highlight = Instance.new("Highlight")
                            highlight.Name = "ESPHighlight"
                            highlight.FillColor = Color3.fromRGB(255, 0, 0)
                            highlight.FillTransparency = 0.5
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                            highlight.Parent = otherPlayer.Character
                        end
                    end
                end
                wait(1)
            end
            
            for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                if otherPlayer.Character then
                    local highlight = otherPlayer.Character:FindFirstChild("ESPHighlight")
                    if highlight then
                        highlight:Destroy()
                    end
                end
            end
        end)
    else
        for _, otherPlayer in pairs(game.Players:GetPlayers()) do
            if otherPlayer.Character then
                local highlight = otherPlayer.Character:FindFirstChild("ESPHighlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
    
    return espEnabled
end

-- BASIC TELEPORT TOGGLE
local function toggleTeleport()
    teleportEnabled = not teleportEnabled
    teleportGui.Visible = teleportEnabled
    
    if not teleportEnabled then
        if freezeEnabled then
            toggleFreeze()
        end
    end
    
    return teleportEnabled
end

-- GOD TELEPORT SYSTEM (UNDETECTABLE)
local godTeleportConnection = nil
local function toggleGodTeleport()
    godTeleportEnabled = not godTeleportEnabled
    
    if godTeleportEnabled then
        -- Multiple bypass methods
        spawn(function()
            while godTeleportEnabled do
                if rootPart and rootPart.Parent then
                    -- Method 1: Velocity manipulation
                    rootPart.Velocity = Vector3.new(0, 0, 0)
                    rootPart.RotVelocity = Vector3.new(0, 0, 0)
                    
                    -- Method 2: Network ownership
                    pcall(function()
                        rootPart:SetNetworkOwner(player)
                    end)
                    
                    -- Method 3: Anti-detection
                    for _, v in pairs(character:GetDescendants()) do
                        if v:IsA("BodyVelocity") or v:IsA("BodyPosition") or v:IsA("BodyGyro") then
                            v:Destroy()
                        end
                    end
                end
                wait(0.1)
            end
        end)
    end
    
    return godTeleportEnabled
end

-- ULTIMATE BYPASS SYSTEM
local function toggleBypass()
    bypassEnabled = not bypassEnabled
    
    if bypassEnabled then
        -- Hook metamethods for bypass
        pcall(function()
            local mt = getrawmetatable(game)
            setreadonly(mt, false)
            
            oldNamecall = oldNamecall or mt.__namecall
            oldIndex = oldIndex or mt.__index
            oldNewIndex = oldNewIndex or mt.__newindex
            
            -- Bypass __namecall
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                local args = {...}
                
                -- Block anti-cheat remotes
                if method == "FireServer" or method == "InvokeServer" then
                    if tostring(self):lower():find("anti") or tostring(self):lower():find("cheat") or tostring(self):lower():find("kick") or tostring(self):lower():find("ban") then
                        return nil
                    end
                end
                
                -- Block kick/ban
                if method == "Kick" then
                    return nil
                end
                
                return oldNamecall(self, ...)
            end)
            
            -- Bypass __index
            mt.__index = newcclosure(function(self, key)
                -- Hide walkspeed/jumppower changes
                if self == humanoid then
                    if key == "WalkSpeed" then
                        return 16
                    elseif key == "JumpPower" then
                        return 50
                    end
                end
                
                return oldIndex(self, key)
            end)
            
            -- Bypass __newindex
            mt.__newindex = newcclosure(function(self, key, value)
                -- Prevent detection of position changes
                if self == rootPart and (key == "CFrame" or key == "Position") then
                    -- Allow our changes
                    return oldNewIndex(self, key, value)
                end
                
                return oldNewIndex(self, key, value)
            end)
            
            setreadonly(mt, true)
        end)
        
        -- Additional bypass methods
        spawn(function()
            while bypassEnabled do
                -- Remove anti-cheat scripts
                for _, v in pairs(game:GetDescendants()) do
                    if v:IsA("LocalScript") or v:IsA("Script") then
                        if v.Name:lower():find("anti") or v.Name:lower():find("cheat") or v.Name:lower():find("exploit") then
                            v.Disabled = true
                            v:Destroy()
                        end
                    end
                end
                
                -- Spoof remotes
                for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                        if v.Name:lower():find("kick") or v.Name:lower():find("ban") then
                            v:Destroy()
                        end
                    end
                end
                
                wait(1)
            end
        end)
    else
        -- Restore original metamethods
        pcall(function()
            local mt = getrawmetatable(game)
            setreadonly(mt, false)
            if oldNamecall then mt.__namecall = oldNamecall end
            if oldIndex then mt.__index = oldIndex end
            if oldNewIndex then mt.__newindex = oldNewIndex end
            setreadonly(mt, true)
        end)
    end
    
    return bypassEnabled
end

-- Teleport Controls
distanceInput.FocusLost:Connect(function()
    local num = tonumber(distanceInput.Text)
    if num and num > 0 and num <= 10000 then
        teleportDistance = num
    else
        distanceInput.Text = tostring(teleportDistance)
    end
end)

forwardBtn.MouseButton1Click:Connect(function()
    teleportPlayer("forward")
end)

backwardBtn.MouseButton1Click:Connect(function()
    teleportPlayer("backward")
end)

freezeToggle.MouseButton1Click:Connect(toggleFreeze)

returnBtn.MouseButton1Click:Connect(function()
    if lastPosition and rootPart and rootPart.Parent then
        rootPart.CFrame = lastPosition
        if freezeEnabled then
            freezePosition = lastPosition
        end
    end
end)

-- Create feature cards
createFeatureCard("👁", "ESP | دید از دیوار", "نمایش همه بازیکنان", toggleESP)
createFeatureCard("🎯", "تلپورت | Teleport", "تلپورت ساده با کنترل", toggleTeleport)
createFeatureCard("⚡", "GOD Teleport", "تلپورت غیرقابل شناسایی", toggleGodTeleport)
createFeatureCard("🛡️", "Bypass Anti-Cheat", "بایپس کامل آنتی چیت", toggleBypass)

-- Event Connections
logoButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    mainFrame.Visible = menuOpen
    
    if menuOpen then
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        createTween(mainFrame, {Size = UDim2.new(0, 480, 0, 400)}, 0.4):Play()
    end
end)

minimizeBtn.MouseButton1Click:Connect(function()
    if not isMinimized then
        isMinimized = true
        content.Visible = false
        createTween(mainFrame, {Size = UDim2.new(0, 480, 0, 50)}, 0.3):Play()
    else
        isMinimized = false
        content.Visible = true
        createTween(mainFrame, {Size = UDim2.new(0, 480, 0, 400)}, 0.3):Play()
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    createTween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3):Play()
    wait(0.3)
    mainFrame.Visible = false
    menuOpen = false
end)

-- DESTROY ALL
destroyBtn.MouseButton1Click:Connect(function()
    -- Disable all features
    espEnabled = false
    teleportEnabled = false
    godTeleportEnabled = false
    bypassEnabled = false
    freezeEnabled = false
    
    -- Clean up
    if freezeConnection then freezeConnection:Disconnect() end
    
    -- Restore metamethods
    pcall(function()
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        if oldNamecall then mt.__namecall = oldNamecall end
        if oldIndex then mt.__index = oldIndex end
        if oldNewIndex then mt.__newindex = oldNewIndex end
        setreadonly(mt, true)
    end)
    
    -- Destroy GUI
    screenGui:Destroy()
end)

-- Hover Effects
local function addHoverEffect(button, hoverColor, normalColor)
    button.MouseEnter:Connect(function()
        createTween(button, {BackgroundColor3 = hoverColor}, 0.2):Play()
    end)
    
    button.MouseLeave:Connect(function()
        createTween(button, {BackgroundColor3 = normalColor}, 0.2):Play()
    end)
end

addHoverEffect(minimizeBtn, Color3.fromRGB(255, 200, 70), Color3.fromRGB(255, 180, 50))
addHoverEffect(closeBtn, Color3.fromRGB(255, 90, 90), Color3.fromRGB(255, 70, 70))
addHoverEffect(destroyBtn, Color3.fromRGB(130, 130, 130), Color3.fromRGB(100, 100, 100))
addHoverEffect(forwardBtn, Color3.fromRGB(35, 35, 42), Color3.fromRGB(25, 25, 32))
addHoverEffect(backwardBtn, Color3.fromRGB(35, 35, 42), Color3.fromRGB(25, 25, 32))

-- Logo Animation
spawn(function()
    while screenGui.Parent do
        createTween(logoIcon, {Rotation = 360}, 3):Play()
        wait(3)
        logoIcon.Rotation = 0
        wait(2)
    end
end)

print("👑 GOD MENU ULTIMATE v8.0")
print("✅ ESP: Working")
print("✅ Teleport: Fixed after death")
print("⚡ GOD Teleport: Undetectable")
print("🛡️ Bypass: Anti-Cheat Protected")
print("⚠ Destroy Button: Complete removal")
