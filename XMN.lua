-- 🎯 ULTRA GOD MENU v5.0 - PERSIAN EDITION
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
local autoWalking = false
local bulletTrackEnabled = false
local espEnabled = false
local speedHackEnabled = false
local godModeEnabled = false
local flyEnabled = false
local isMinimized = false
local flySpeed = 50
local originalHealth = humanoid.MaxHealth

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
mainFrame.Size = UDim2.new(0, 520, 0, 450)
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -225)
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
title.Size = UDim2.new(0.6, 0, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "👑 منوی گاد | GOD MENU"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.TextSize = 20
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Window Controls
local controls = Instance.new("Frame")
controls.Size = UDim2.new(0, 80, 0, 30)
controls.Position = UDim2.new(1, -90, 0.5, -15)
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
content.CanvasSize = UDim2.new(0, 0, 0, 800)
content.Parent = mainFrame

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

-- BULLET TRACK SYSTEM - ADVANCED
local function toggleBulletTrack()
    bulletTrackEnabled = not bulletTrackEnabled
    
    if bulletTrackEnabled then
        -- Hook into tool activation
        local connection
        connection = RunService.Heartbeat:Connect(function()
            if not bulletTrackEnabled then
                connection:Disconnect()
                return
            end
            
            -- Find nearest enemy
            local nearestEnemy = nil
            local shortestDistance = math.huge
            
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= player and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Humanoid") then
                    if v.Character.Humanoid.Health > 0 then
                        local distance = (v.Character.Head.Position - character.Head.Position).Magnitude
                        if distance < shortestDistance and distance < 1000 then
                            shortestDistance = distance
                            nearestEnemy = v.Character
                        end
                    end
                end
            end
            
            -- Redirect bullets
            if nearestEnemy then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and (obj.Name:lower():find("bullet") or obj.Name:lower():find("projectile") or obj.Size.Magnitude < 3) then
                        if obj.AssemblyLinearVelocity.Magnitude > 50 then
                            local direction = (nearestEnemy.Head.Position - obj.Position).Unit
                            obj.AssemblyLinearVelocity = direction * obj.AssemblyLinearVelocity.Magnitude
                            obj.CFrame = CFrame.lookAt(obj.Position, nearestEnemy.Head.Position)
                        end
                    end
                end
            end
        end)
        
        -- Advanced bullet redirect for all gun types
        spawn(function()
            while bulletTrackEnabled do
                local tool = character:FindFirstChildOfClass("Tool")
                if tool then
                    local handle = tool:FindFirstChild("Handle")
                    if handle then
                        -- Override RemoteEvents
                        for _, remote in pairs(game:GetDescendants()) do
                            if remote:IsA("RemoteEvent") and (remote.Name:lower():find("fire") or remote.Name:lower():find("shoot")) then
                                local oldFire = remote.FireServer
                                remote.FireServer = function(...)
                                    local args = {...}
                                    if nearestEnemy and nearestEnemy:FindFirstChild("Head") then
                                        -- Modify args to target enemy
                                        for i, v in pairs(args) do
                                            if typeof(v) == "Vector3" then
                                                args[i] = nearestEnemy.Head.Position
                                            elseif typeof(v) == "CFrame" then
                                                args[i] = nearestEnemy.Head.CFrame
                                            end
                                        end
                                    end
                                    return oldFire(remote, unpack(args))
                                end
                            end
                        end
                    end
                end
                wait(0.1)
            end
        end)
    end
    
    return bulletTrackEnabled
end

-- GOD MODE SYSTEM
local function toggleGodMode()
    godModeEnabled = not godModeEnabled
    
    if godModeEnabled then
        -- Store original health
        originalHealth = humanoid.MaxHealth
        
        -- Set infinite health
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
        
        -- Prevent death
        local godConnection
        godConnection = humanoid.HealthChanged:Connect(function()
            if godModeEnabled then
                humanoid.Health = humanoid.MaxHealth
            else
                godConnection:Disconnect()
            end
        end)
        
        -- Anti-kill protection
        spawn(function()
            while godModeEnabled do
                if humanoid.Health < humanoid.MaxHealth then
                    humanoid.Health = humanoid.MaxHealth
                end
                -- Remove kill bricks effect
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                wait(0.1)
            end
        end)
    else
        -- Restore original health
        humanoid.MaxHealth = originalHealth or 100
        humanoid.Health = humanoid.MaxHealth
    end
    
    return godModeEnabled
end

-- FLY SYSTEM
local bodyVelocity
local bodyGyro
local function toggleFly()
    flyEnabled = not flyEnabled
    
    if flyEnabled then
        -- Create BodyVelocity and BodyGyro
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = rootPart
        
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyGyro.D = 500
        bodyGyro.P = 10000
        bodyGyro.CFrame = rootPart.CFrame
        bodyGyro.Parent = rootPart
        
        -- Fly control
        spawn(function()
            while flyEnabled do
                local camera = workspace.CurrentCamera
                local moveVector = humanoid.MoveDirection * flySpeed
                
                if moveVector.Magnitude > 0 then
                    bodyVelocity.Velocity = camera.CFrame:VectorToWorldSpace(Vector3.new(moveVector.X, 0, moveVector.Z))
                else
                    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                end
                
                -- Up and down control
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                    bodyVelocity.Velocity = bodyVelocity.Velocity + Vector3.new(0, flySpeed, 0)
                elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
                    bodyVelocity.Velocity = bodyVelocity.Velocity - Vector3.new(0, flySpeed, 0)
                end
                
                bodyGyro.CFrame = camera.CFrame
                wait()
            end
        end)
    else
        -- Remove fly objects
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
    end
    
    return flyEnabled
end

-- Other existing functions
local function toggleAutoWalk()
    autoWalking = not autoWalking
    
    if autoWalking then
        spawn(function()
            local startTime = tick()
            while autoWalking and tick() - startTime < 6 do
                if humanoid and humanoid.Parent then
                    humanoid:Move(Vector3.new(0, 0, -1))
                end
                wait()
            end
            if humanoid and humanoid.Parent then
                humanoid:Move(Vector3.new(0, 0, 0))
            end
            autoWalking = false
        end)
    else
        if humanoid and humanoid.Parent then
            humanoid:Move(Vector3.new(0, 0, 0))
        end
    end
    
    return autoWalking
end

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

local originalSpeed = humanoid.WalkSpeed
local function toggleSpeed()
    speedHackEnabled = not speedHackEnabled
    
    if speedHackEnabled then
        humanoid.WalkSpeed = originalSpeed * 2
    else
        humanoid.WalkSpeed = originalSpeed
    end
    
    return speedHackEnabled
end

-- Create all feature cards
createFeatureCard("👑", "حالت خدا | God Mode", "نامیرا و قدرتمند", toggleGodMode)
createFeatureCard("🎯", "بولت ترک | Bullet Track", "تیرها به دشمن میخورند", toggleBulletTrack)
createFeatureCard("🕊️", "پرواز | Fly Mode", "Space=بالا Shift=پایین", toggleFly)
createFeatureCard("👁", "دید از دیوار | ESP", "دیدن دشمنان از پشت دیوار", toggleESP)
createFeatureCard("⚡", "سرعت | Speed Boost", "سرعت 2 برابر", toggleSpeed)
createFeatureCard("🚶", "راه رفتن خودکار | Auto Walk", "6 ثانیه حرکت به جلو", toggleAutoWalk)

-- Theme Change Button
local themeCard = Instance.new("Frame")
themeCard.Size = UDim2.new(1, -10, 0, 60)
themeCard.Position = UDim2.new(0, 5, 0, cardY)
themeCard.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
themeCard.BorderSizePixel = 0
themeCard.Parent = content

local themeCorner = Instance.new("UICorner")
themeCorner.CornerRadius = UDim.new(0, 8)
themeCorner.Parent = themeCard

local themeButton = Instance.new("TextButton")
themeButton.Size = UDim2.new(1, -20, 0, 40)
themeButton.Position = UDim2.new(0, 10, 0.5, -20)
themeButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
themeButton.Text = "🎨 تغییر رنگ تم | Change Theme"
themeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
themeButton.TextSize = 16
themeButton.Font = Enum.Font.SourceSansBold
themeButton.AutoButtonColor = false
themeButton.Parent = themeCard

local themeButtonCorner = Instance.new("UICorner")
themeButtonCorner.CornerRadius = UDim.new(0, 6)
themeButtonCorner.Parent = themeButton

-- Theme Change Function
local themes = {
    {255, 215, 0},   -- Gold
    {255, 130, 130}, -- Red
    {130, 255, 130}, -- Green
    {130, 180, 255}, -- Blue
    {180, 130, 255}, -- Purple
    {255, 130, 180}, -- Pink
    {130, 255, 255}, -- Cyan
}
local currentTheme = 1

local function changeTheme()
    currentTheme = currentTheme % #themes + 1
    local newColor = Color3.fromRGB(themes[currentTheme][1], themes[currentTheme][2], themes[currentTheme][3])
    
    logoStroke.Color = newColor
    title.TextColor3 = newColor
    content.ScrollBarImageColor3 = newColor
    themeButton.BackgroundColor3 = newColor
    
    createTween(themeButton, {Size = UDim2.new(1, -10, 0, 40)}, 0.1):Play()
    wait(0.1)
    createTween(themeButton, {Size = UDim2.new(1, -20, 0, 40)}, 0.1):Play()
end

-- Event Connections
logoButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    mainFrame.Visible = menuOpen
    
    if menuOpen then
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        createTween(mainFrame, {Size = UDim2.new(0, 520, 0, 450)}, 0.4):Play()
    end
end)

minimizeBtn.MouseButton1Click:Connect(function()
    if not isMinimized then
        isMinimized = true
        content.Visible = false
        createTween(mainFrame, {Size = UDim2.new(0, 520, 0, 50)}, 0.3):Play()
    else
        isMinimized = false
        content.Visible = true
        createTween(mainFrame, {Size = UDim2.new(0, 520, 0, 450)}, 0.3):Play()
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    createTween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3):Play()
    wait(0.3)
    mainFrame.Visible = false
    menuOpen = false
end)

themeButton.MouseButton1Click:Connect(changeTheme)

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

-- Logo Animation
spawn(function()
    while true do
        createTween(logoIcon, {Rotation = 360}, 3):Play()
        wait(3)
        logoIcon.Rotation = 0
        wait(2)
    end
end)

print("👑 منوی گاد نسخه 5 - لود شد!")
print("✅ God Mode: نامیرایی کامل")
print("✅ Bullet Track: تیرها به دشمن میخورند")
print("✅ Fly Mode: پرواز با Space و Shift")
print("🔥 تمام فیچرها فعال و آماده!")
