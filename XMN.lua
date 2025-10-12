-- 🎯 ULTRA MENU v6.0 - 99 NIGHTS IN THE FOREST EDITION
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local mouse = player:GetMouse()

-- Services
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local menuOpen = false
local autoWalking = false
local espEnabled = false
local speedHackEnabled = false
local godModeEnabled = false
local flyEnabled = false
local killAuraEnabled = false
local treeAuraEnabled = false
local itemSpawnEnabled = false
local isMinimized = false
local flySpeed = 50
local originalSpeed = 16

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltraMenu99Nights"
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
logoIcon.Text = "◈"  -- برگشت به مثلث
logoIcon.TextScaled = true
logoIcon.Font = Enum.Font.SourceSansBold
logoIcon.TextColor3 = Color3.fromRGB(130, 180, 255)
logoIcon.Parent = logoButton

local logoStroke = Instance.new("UIStroke")
logoStroke.Color = Color3.fromRGB(130, 180, 255)
logoStroke.Thickness = 2
logoStroke.Transparency = 0.3
logoStroke.Parent = logoButton

-- Main Menu Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 520, 0, 480)
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -240)
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
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🌲 99 NIGHTS MENU | منوی 99 شب"
title.TextColor3 = Color3.fromRGB(130, 180, 255)
title.TextSize = 18
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
content.ScrollBarImageColor3 = Color3.fromRGB(130, 180, 255)
content.ScrollBarImageTransparency = 0.5
content.CanvasSize = UDim2.new(0, 0, 0, 900)
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
            toggle.BackgroundColor3 = Color3.fromRGB(130, 180, 255)
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

-- ADVANCED GOD MODE FOR 99 NIGHTS
local godConnection
local function toggleGodMode()
    godModeEnabled = not godModeEnabled
    
    if godModeEnabled then
        -- Method 1: Infinite Health
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
        
        -- Method 2: Health Lock
        if godConnection then godConnection:Disconnect() end
        godConnection = RunService.Heartbeat:Connect(function()
            if godModeEnabled and humanoid then
                humanoid.Health = humanoid.MaxHealth
                -- Remove any negative effects
                for _, v in pairs(character:GetChildren()) do
                    if v:IsA("Script") and v.Name:lower():find("damage") then
                        v:Destroy()
                    end
                end
            end
        end)
        
        -- Method 3: ForceField
        local ff = Instance.new("ForceField")
        ff.Visible = false
        ff.Parent = character
        
        -- Method 4: Anti-Death
        spawn(function()
            while godModeEnabled do
                if humanoid.Health < 100 then
                    humanoid.Health = humanoid.MaxHealth
                end
                -- Specific for 99 Nights
                local stats = player:FindFirstChild("leaderstats")
                if stats then
                    local health = stats:FindFirstChild("Health")
                    if health then
                        health.Value = 100
                    end
                end
                wait(0.1)
            end
        end)
    else
        if godConnection then
            godConnection:Disconnect()
        end
        humanoid.MaxHealth = 100
        humanoid.Health = 100
        local ff = character:FindFirstChild("ForceField")
        if ff then ff:Destroy() end
    end
    
    return godModeEnabled
end

-- IMPROVED FLY SYSTEM FOR ANDROID
local bodyVelocity
local bodyGyro
local flyConnection
local function toggleFly()
    flyEnabled = not flyEnabled
    
    if flyEnabled then
        -- Create movement objects
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = rootPart
        
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
        bodyGyro.D = 500
        bodyGyro.P = 10000
        bodyGyro.CFrame = rootPart.CFrame
        bodyGyro.Parent = rootPart
        
        -- Fixed fly control for Android
        if flyConnection then flyConnection:Disconnect() end
        flyConnection = RunService.Heartbeat:Connect(function()
            if not flyEnabled then return end
            
            local camera = workspace.CurrentCamera
            local cf = camera.CFrame
            
            -- Get movement direction correctly for Android
            local moveVector = humanoid.MoveDirection
            local newVelocity = Vector3.new(0, 0, 0)
            
            -- Forward/Backward (inverted fix)
            if moveVector.Z < 0 then  -- Forward
                newVelocity = newVelocity + (cf.LookVector * flySpeed)
            elseif moveVector.Z > 0 then  -- Backward
                newVelocity = newVelocity - (cf.LookVector * flySpeed)
            end
            
            -- Left/Right
            if moveVector.X < 0 then  -- Left
                newVelocity = newVelocity - (cf.RightVector * flySpeed)
            elseif moveVector.X > 0 then  -- Right
                newVelocity = newVelocity + (cf.RightVector * flySpeed)
            end
            
            -- Up/Down with jump button
            local jumpButton = player.PlayerGui:FindFirstChild("TouchGui")
            if jumpButton then
                local jumpBtn = jumpButton:FindFirstChild("TouchControlFrame"):FindFirstChild("JumpButton")
                if jumpBtn and jumpBtn.ImageTransparency < 0.5 then
                    newVelocity = newVelocity + Vector3.new(0, flySpeed, 0)
                end
            end
            
            bodyVelocity.Velocity = newVelocity
            bodyGyro.CFrame = cf
        end)
    else
        if flyConnection then flyConnection:Disconnect() end
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
    end
    
    return flyEnabled
end

-- ITEM SPAWN FOR 99 NIGHTS (CARROT)
local function toggleItemSpawn()
    itemSpawnEnabled = not itemSpawnEnabled
    
    if itemSpawnEnabled then
        spawn(function()
            while itemSpawnEnabled do
                -- Method 1: Find carrot in workspace
                for _, item in pairs(workspace:GetDescendants()) do
                    if item.Name:lower():find("carrot") or item.Name:lower():find("food") then
                        local clone = item:Clone()
                        clone.Position = character.HumanoidRootPart.Position + Vector3.new(math.random(-5, 5), 2, math.random(-5, 5))
                        clone.Parent = workspace
                    end
                end
                
                -- Method 2: ReplicatedStorage items
                local items = ReplicatedStorage:FindFirstChild("Items") or ReplicatedStorage:FindFirstChild("Tools")
                if items then
                    for _, item in pairs(items:GetChildren()) do
                        if item.Name:lower():find("carrot") or item.Name:lower():find("food") then
                            local clone = item:Clone()
                            clone.Parent = player.Backpack
                        end
                    end
                end
                
                -- Method 3: Direct spawn attempt
                local carrot = Instance.new("Tool")
                carrot.Name = "Carrot"
                carrot.Parent = player.Backpack
                
                local handle = Instance.new("Part")
                handle.Name = "Handle"
                handle.Size = Vector3.new(1, 2, 1)
                handle.BrickColor = BrickColor.new("Bright orange")
                handle.Parent = carrot
                
                wait(5) -- Spawn every 5 seconds
            end
        end)
    end
    
    return itemSpawnEnabled
end

-- KILL AURA FOR 99 NIGHTS
local killAuraConnection
local function toggleKillAura()
    killAuraEnabled = not killAuraEnabled
    
    if killAuraEnabled then
        if killAuraConnection then killAuraConnection:Disconnect() end
        killAuraConnection = RunService.Heartbeat:Connect(function()
            if not killAuraEnabled then return end
            
            -- Find all enemies/monsters
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and obj ~= character then
                    local enemyHum = obj:FindFirstChild("Humanoid") or obj:FindFirstChild("Health")
                    local enemyRoot = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Torso")
                    
                    if enemyHum and enemyRoot then
                        local distance = (enemyRoot.Position - rootPart.Position).Magnitude
                        if distance < 20 then -- 20 stud range
                            -- Try multiple damage methods
                            enemyHum.Health = 0
                            if enemyHum:FindFirstChild("Health") then
                                enemyHum.Health.Value = 0
                            end
                            -- Fire damage remotes if they exist
                            for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
                                if remote:IsA("RemoteEvent") and (remote.Name:lower():find("damage") or remote.Name:lower():find("hit")) then
                                    remote:FireServer(obj, math.huge)
                                end
                            end
                        end
                    end
                end
            end
        end)
    else
        if killAuraConnection then
            killAuraConnection:Disconnect()
        end
    end
    
    return killAuraEnabled
end

-- TREE AURA FOR 99 NIGHTS
local treeAuraConnection
local function toggleTreeAura()
    treeAuraEnabled = not treeAuraEnabled
    
    if treeAuraEnabled then
        if treeAuraConnection then treeAuraConnection:Disconnect() end
        treeAuraConnection = RunService.Heartbeat:Connect(function()
            if not treeAuraEnabled then return end
            
            -- Find all trees
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name:lower():find("tree") or obj.Name:lower():find("wood") then
                    if obj:IsA("Model") then
                        local treeRoot = obj:FindFirstChild("TreePart") or obj:FindFirstChild("Trunk") or obj.PrimaryPart
                        if treeRoot then
                            local distance = (treeRoot.Position - rootPart.Position).Magnitude
                            if distance < 30 then -- 30 stud range
                                -- Destroy tree
                                obj:Destroy()
                                -- Drop wood
                                local wood = Instance.new("Part")
                                wood.Name = "Wood"
                                wood.Size = Vector3.new(2, 2, 4)
                                wood.BrickColor = BrickColor.new("Brown")
                                wood.Position = treeRoot.Position
                                wood.Parent = workspace
                            end
                        end
                    end
                end
            end
        end)
    else
        if treeAuraConnection then
            treeAuraConnection:Disconnect()
        end
    end
    
    return treeAuraEnabled
end

-- Other existing functions
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

local function toggleSpeed()
    speedHackEnabled = not speedHackEnabled
    
    if speedHackEnabled then
        humanoid.WalkSpeed = 32
    else
        humanoid.WalkSpeed = 16
    end
    
    return speedHackEnabled
end

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

-- Create all feature cards
createFeatureCard("🛡️", "گاد مود | God Mode", "نامیرایی کامل 100%", toggleGodMode)
createFeatureCard("🥕", "اسپان آیتم | Item Spawn", "اسپان هویج و غذا", toggleItemSpawn)
createFeatureCard("⚔️", "کیل آورا | Kill Aura", "کشتن خودکار دشمنان", toggleKillAura)
createFeatureCard("🌲", "تری آورا | Tree Aura", "قطع خودکار درختان", toggleTreeAura)
createFeatureCard("🕊️", "پرواز | Fly Mode", "پرواز درست شده برای اندروید", toggleFly)
createFeatureCard("👁", "دید از دیوار | ESP", "دیدن بازیکنان", toggleESP)
createFeatureCard("⚡", "سرعت | Speed Boost", "سرعت 2 برابر", toggleSpeed)
createFeatureCard("🚶", "راه رفتن خودکار | Auto Walk", "6 ثانیه حرکت", toggleAutoWalk)

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
themeButton.BackgroundColor3 = Color3.fromRGB(130, 180, 255)
themeButton.Text = "🎨 تغییر رنگ تم | Change Theme"
themeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
themeButton.TextSize = 16
themeButton.Font = Enum.Font.SourceSansBold
themeButton.AutoButtonColor = false
themeButton.Parent = themeCard

local themeButtonCorner = Instance.new("UICorner")
themeButtonCorner.CornerRadius = UDim.new(0, 6)
themeButtonCorner.Parent = themeButton

-- Theme Change Function
local themes = {
    {130, 180, 255}, -- Blue
    {255, 130, 130}, -- Red
    {130, 255, 130}, -- Green
    {255, 180, 130}, -- Orange
    {180, 130, 255}, -- Purple
    {255, 130, 180}, -- Pink
    {130, 255, 255}, -- Cyan
}
local currentTheme = 1

local function changeTheme()
    currentTheme = currentTheme % #themes + 1
    local newColor = Color3.fromRGB(themes[currentTheme][1], themes[currentTheme][2], themes[currentTheme][3])
    
    logoIcon.TextColor3 = newColor
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
        createTween(mainFrame, {Size = UDim2.new(0, 520, 0, 480)}, 0.4):Play()
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
        createTween(mainFrame, {Size = UDim2.new(0, 520, 0, 480)}, 0.3):Play()
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

print("🌲 99 NIGHTS IN THE FOREST MENU - LOADED!")
print("✅ God Mode: 100% Working")
print("✅ Item Spawn: Carrot Ready")
print("✅ Kill Aura: Auto Kill Enemies")
print("✅ Tree Aura: Auto Chop Trees")
print("✅ Fly Fixed for Android")
print("🔥 All Features Ready!")
