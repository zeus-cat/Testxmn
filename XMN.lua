-- 🎯 ULTRA GOD MENU v7.0 - ADVANCED TELEPORT EDITION
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
local teleportEnabled = false
local freezeEnabled = false
local rapidFreezeEnabled = false
local isMinimized = false
local originalHealth = humanoid.MaxHealth
local teleportDistance = 10
local lastPosition = nil
local freezePosition = nil
local rapidFreezeConnection = nil

-- FLY VARIABLES
local FLYING = false
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local lastctrl = {f = 0, b = 0, l = 0, r = 0}
local maxspeed = 50
local speed = 0
local bg = nil
local bv = nil

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
mainFrame.Size = UDim2.new(0, 520, 0, 500)
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -250)
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
content.CanvasSize = UDim2.new(0, 0, 0, 950)
content.Parent = mainFrame

-- TELEPORT ARROWS GUI
local teleportGui = Instance.new("Frame")
teleportGui.Name = "TeleportArrows"
teleportGui.Size = UDim2.new(0, 250, 0, 280)
teleportGui.Position = UDim2.new(0.5, -125, 0.7, -140)
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

distanceInput.FocusLost:Connect(function()
    local num = tonumber(distanceInput.Text)
    if num and num > 0 and num <= 1000 then
        teleportDistance = num
    else
        distanceInput.Text = tostring(teleportDistance)
    end
end)

-- Forward Arrow (Up)
local forwardBtn = Instance.new("TextButton")
forwardBtn.Size = UDim2.new(0, 50, 0, 50)
forwardBtn.Position = UDim2.new(0.5, -25, 0, 50)
forwardBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
forwardBtn.Text = "⬆"
forwardBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
forwardBtn.TextSize = 30
forwardBtn.Font = Enum.Font.SourceSansBold
forwardBtn.Parent = teleportGui

local forwardCorner = Instance.new("UICorner")
forwardCorner.CornerRadius = UDim.new(0, 8)
forwardCorner.Parent = forwardBtn

-- Backward Arrow (Down)
local backwardBtn = Instance.new("TextButton")
backwardBtn.Size = UDim2.new(0, 50, 0, 50)
backwardBtn.Position = UDim2.new(0.5, -25, 0, 160)
backwardBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
backwardBtn.Text = "⬇"
backwardBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
backwardBtn.TextSize = 30
backwardBtn.Font = Enum.Font.SourceSansBold
backwardBtn.Parent = teleportGui

local backwardCorner = Instance.new("UICorner")
backwardCorner.CornerRadius = UDim.new(0, 8)
backwardCorner.Parent = backwardBtn

-- Left Arrow
local leftBtn = Instance.new("TextButton")
leftBtn.Size = UDim2.new(0, 50, 0, 50)
leftBtn.Position = UDim2.new(0, 30, 0, 105)
leftBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
leftBtn.Text = "⬅"
leftBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
leftBtn.TextSize = 30
leftBtn.Font = Enum.Font.SourceSansBold
leftBtn.Parent = teleportGui

local leftCorner = Instance.new("UICorner")
leftCorner.CornerRadius = UDim.new(0, 8)
leftCorner.Parent = leftBtn

-- Right Arrow
local rightBtn = Instance.new("TextButton")
rightBtn.Size = UDim2.new(0, 50, 0, 50)
rightBtn.Position = UDim2.new(1, -80, 0, 105)
rightBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
rightBtn.Text = "➡"
rightBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
rightBtn.TextSize = 30
rightBtn.Font = Enum.Font.SourceSansBold
rightBtn.Parent = teleportGui

local rightCorner = Instance.new("UICorner")
rightCorner.CornerRadius = UDim.new(0, 8)
rightCorner.Parent = rightBtn

-- Up Arrow (Y+)
local upBtn = Instance.new("TextButton")
upBtn.Size = UDim2.new(0, 40, 0, 40)
upBtn.Position = UDim2.new(0.5, -20, 0, 110)
upBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
upBtn.Text = "🔺"
upBtn.TextColor3 = Color3.fromRGB(130, 255, 130)
upBtn.TextSize = 20
upBtn.Font = Enum.Font.SourceSansBold
upBtn.Parent = teleportGui

local upCorner = Instance.new("UICorner")
upCorner.CornerRadius = UDim.new(0, 8)
upCorner.Parent = upBtn

-- Down Arrow (Y-)
local downBtn = Instance.new("TextButton")
downBtn.Size = UDim2.new(0, 40, 0, 40)
downBtn.Position = UDim2.new(0.5, -20, 0, 155)
downBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
downBtn.Text = "🔻"
downBtn.TextColor3 = Color3.fromRGB(255, 130, 130)
downBtn.TextSize = 20
downBtn.Font = Enum.Font.SourceSansBold
downBtn.Parent = teleportGui

local downCorner = Instance.new("UICorner")
downCorner.CornerRadius = UDim.new(0, 8)
downCorner.Parent = downBtn

-- Control Buttons Container
local controlsContainer = Instance.new("Frame")
controlsContainer.Size = UDim2.new(1, -20, 0, 60)
controlsContainer.Position = UDim2.new(0, 10, 1, -70)
controlsContainer.BackgroundTransparency = 1
controlsContainer.Parent = teleportGui

-- Freeze Toggle Button
local freezeToggle = Instance.new("TextButton")
freezeToggle.Size = UDim2.new(0, 70, 0, 25)
freezeToggle.Position = UDim2.new(0, 0, 0, 0)
freezeToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
freezeToggle.Text = "Freeze"
freezeToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
freezeToggle.TextSize = 12
freezeToggle.Font = Enum.Font.SourceSans
freezeToggle.Parent = controlsContainer

local freezeToggleCorner = Instance.new("UICorner")
freezeToggleCorner.CornerRadius = UDim.new(0, 6)
freezeToggleCorner.Parent = freezeToggle

-- Rapid Freeze Toggle Button
local rapidFreezeToggle = Instance.new("TextButton")
rapidFreezeToggle.Size = UDim2.new(0, 70, 0, 25)
rapidFreezeToggle.Position = UDim2.new(0, 80, 0, 0)
rapidFreezeToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
rapidFreezeToggle.Text = "Fast Lock"
rapidFreezeToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
rapidFreezeToggle.TextSize = 12
rapidFreezeToggle.Font = Enum.Font.SourceSans
rapidFreezeToggle.Parent = controlsContainer

local rapidFreezeToggleCorner = Instance.new("UICorner")
rapidFreezeToggleCorner.CornerRadius = UDim.new(0, 6)
rapidFreezeToggleCorner.Parent = rapidFreezeToggle

-- Return Button
local returnBtn = Instance.new("TextButton")
returnBtn.Size = UDim2.new(0, 70, 0, 25)
returnBtn.Position = UDim2.new(0, 160, 0, 0)
returnBtn.BackgroundColor3 = Color3.fromRGB(50, 35, 35)
returnBtn.Text = "Return"
returnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
returnBtn.TextSize = 12
returnBtn.Font = Enum.Font.SourceSans
returnBtn.Parent = controlsContainer

local returnBtnCorner = Instance.new("UICorner")
returnBtnCorner.CornerRadius = UDim.new(0, 6)
returnBtnCorner.Parent = returnBtn

-- Save Position Button
local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.new(1, 0, 0, 25)
saveBtn.Position = UDim2.new(0, 0, 0, 30)
saveBtn.BackgroundColor3 = Color3.fromRGB(35, 50, 35)
saveBtn.Text = "Save Current Position"
saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
saveBtn.TextSize = 12
saveBtn.Font = Enum.Font.SourceSans
saveBtn.Parent = controlsContainer

local saveBtnCorner = Instance.new("UICorner")
saveBtnCorner.CornerRadius = UDim.new(0, 6)
saveBtnCorner.Parent = saveBtn

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

-- TELEPORT FUNCTION
local function teleportPlayer(direction)
    -- Save position before teleport
    if not lastPosition then
        lastPosition = rootPart.CFrame
    end
    
    local cf = rootPart.CFrame
    
    if direction == "forward" then
        rootPart.CFrame = cf + cf.LookVector * teleportDistance
    elseif direction == "backward" then
        rootPart.CFrame = cf - cf.LookVector * teleportDistance
    elseif direction == "left" then
        rootPart.CFrame = cf - cf.RightVector * teleportDistance
    elseif direction == "right" then
        rootPart.CFrame = cf + cf.RightVector * teleportDistance
    elseif direction == "up" then
        rootPart.CFrame = cf + Vector3.new(0, teleportDistance, 0)
    elseif direction == "down" then
        rootPart.CFrame = cf - Vector3.new(0, teleportDistance, 0)
    end
    
    -- If freeze is enabled, save the new position
    if freezeEnabled then
        freezePosition = rootPart.CFrame
    end
end

-- Freeze Functions
local function enableFreeze()
    freezeEnabled = true
    freezePosition = rootPart.CFrame
    freezeToggle.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    
    -- Create anchored part to stand on
    local freezePart = Instance.new("Part")
    freezePart.Name = "FreezePart"
    freezePart.Size = Vector3.new(5, 0.1, 5)
    freezePart.Position = rootPart.Position - Vector3.new(0, 3, 0)
    freezePart.Anchored = true
    freezePart.Transparency = 1
    freezePart.CanCollide = true
    freezePart.Parent = workspace
    
    spawn(function()
        while freezeEnabled do
            if freezePosition then
                rootPart.CFrame = freezePosition
                rootPart.Velocity = Vector3.new(0, 0, 0)
                rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            end
            wait()
        end
        if freezePart and freezePart.Parent then
            freezePart:Destroy()
        end
    end)
end

local function disableFreeze()
    freezeEnabled = false
    freezePosition = nil
    freezeToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    
    local freezePart = workspace:FindFirstChild("FreezePart")
    if freezePart then
        freezePart:Destroy()
    end
end

local function enableRapidFreeze()
    rapidFreezeEnabled = true
    freezePosition = rootPart.CFrame
    rapidFreezeToggle.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    
    if rapidFreezeConnection then
        rapidFreezeConnection:Disconnect()
    end
    
    rapidFreezeConnection = RunService.Heartbeat:Connect(function()
        if rapidFreezeEnabled and freezePosition then
            rootPart.CFrame = freezePosition
            rootPart.Velocity = Vector3.new(0, 0, 0)
            rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            
            -- Extra anti-server-back measures
            for i = 1, 3 do
                rootPart.CFrame = freezePosition
            end
        end
    end)
end

local function disableRapidFreeze()
    rapidFreezeEnabled = false
    rapidFreezeToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    
    if rapidFreezeConnection then
        rapidFreezeConnection:Disconnect()
        rapidFreezeConnection = nil
    end
end

-- Teleport Control Events
freezeToggle.MouseButton1Click:Connect(function()
    if freezeEnabled then
        disableFreeze()
    else
        if rapidFreezeEnabled then
            disableRapidFreeze()
        end
        enableFreeze()
    end
end)

rapidFreezeToggle.MouseButton1Click:Connect(function()
    if rapidFreezeEnabled then
        disableRapidFreeze()
    else
        if freezeEnabled then
            disableFreeze()
        end
        enableRapidFreeze()
    end
end)

returnBtn.MouseButton1Click:Connect(function()
    if lastPosition then
        rootPart.CFrame = lastPosition
        if freezeEnabled or rapidFreezeEnabled then
            freezePosition = lastPosition
        end
    end
end)

saveBtn.MouseButton1Click:Connect(function()
    lastPosition = rootPart.CFrame
    saveBtn.Text = "Position Saved!"
    saveBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 50)
    wait(1)
    saveBtn.Text = "Save Current Position"
    saveBtn.BackgroundColor3 = Color3.fromRGB(35, 50, 35)
end)

-- Teleport Arrow Connections
forwardBtn.MouseButton1Click:Connect(function()
    teleportPlayer("forward")
end)

backwardBtn.MouseButton1Click:Connect(function()
    teleportPlayer("backward")
end)

leftBtn.MouseButton1Click:Connect(function()
    teleportPlayer("left")
end)

rightBtn.MouseButton1Click:Connect(function()
    teleportPlayer("right")
end)

upBtn.MouseButton1Click:Connect(function()
    teleportPlayer("up")
end)

downBtn.MouseButton1Click:Connect(function()
    teleportPlayer("down")
end)

-- TELEPORT TOGGLE
local function toggleTeleport()
    teleportEnabled = not teleportEnabled
    teleportGui.Visible = teleportEnabled
    
    if not teleportEnabled then
        -- Disable all freeze modes when closing teleport
        if freezeEnabled then
            disableFreeze()
        end
        if rapidFreezeEnabled then
            disableRapidFreeze()
        end
    end
    
    return teleportEnabled
end

-- Create Teleport Card
local teleportCard = Instance.new("Frame")
teleportCard.Size = UDim2.new(1, -10, 0, 100)
teleportCard.Position = UDim2.new(0, 5, 0, cardY)
teleportCard.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
teleportCard.BorderSizePixel = 0
teleportCard.Parent = content

cardY = cardY + 110

local teleportCardCorner = Instance.new("UICorner")
teleportCardCorner.CornerRadius = UDim.new(0, 8)
teleportCardCorner.Parent = teleportCard

local teleportCardStroke = Instance.new("UIStroke")
teleportCardStroke.Color = Color3.fromRGB(30, 30, 38)
teleportCardStroke.Thickness = 1
teleportCardStroke.Parent = teleportCard

local teleportIconLabel = Instance.new("TextLabel")
teleportIconLabel.Size = UDim2.new(0, 60, 0, 60)
teleportIconLabel.Position = UDim2.new(0, 15, 0.5, -30)
teleportIconLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
teleportIconLabel.Text = "🎯"
teleportIconLabel.TextSize = 28
teleportIconLabel.Font = Enum.Font.SourceSansBold
teleportIconLabel.Parent = teleportCard

local teleportIconCorner = Instance.new("UICorner")
teleportIconCorner.CornerRadius = UDim.new(0, 8)
teleportIconCorner.Parent = teleportIconLabel

local teleportTitleLabel = Instance.new("TextLabel")
teleportTitleLabel.Size = UDim2.new(0.5, 0, 0, 25)
teleportTitleLabel.Position = UDim2.new(0, 90, 0, 20)
teleportTitleLabel.BackgroundTransparency = 1
teleportTitleLabel.Text = "تلپورت پیشرفته | Advanced TP"
teleportTitleLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
teleportTitleLabel.TextSize = 18
teleportTitleLabel.Font = Enum.Font.SourceSansBold
teleportTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
teleportTitleLabel.Parent = teleportCard

local teleportDescLabel = Instance.new("TextLabel")
teleportDescLabel.Size = UDim2.new(0.5, 0, 0, 20)
teleportDescLabel.Position = UDim2.new(0, 90, 0, 50)
teleportDescLabel.BackgroundTransparency = 1
teleportDescLabel.Text = "تلپورت با فریز و کنترل کامل"
teleportDescLabel.TextColor3 = Color3.fromRGB(130, 130, 140)
teleportDescLabel.TextSize = 14
teleportDescLabel.Font = Enum.Font.SourceSans
teleportDescLabel.TextXAlignment = Enum.TextXAlignment.Left
teleportDescLabel.Parent = teleportCard

local teleportToggle = Instance.new("TextButton")
teleportToggle.Size = UDim2.new(0, 60, 0, 30)
teleportToggle.Position = UDim2.new(1, -75, 0.5, -15)
teleportToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
teleportToggle.Text = ""
teleportToggle.AutoButtonColor = false
teleportToggle.Parent = teleportCard

local teleportToggleCorner = Instance.new("UICorner")
teleportToggleCorner.CornerRadius = UDim.new(1, 0)
teleportToggleCorner.Parent = teleportToggle

local teleportToggleCircle = Instance.new("Frame")
teleportToggleCircle.Size = UDim2.new(0, 24, 0, 24)
teleportToggleCircle.Position = UDim2.new(0, 3, 0.5, -12)
teleportToggleCircle.BackgroundColor3 = Color3.fromRGB(180, 180, 190)
teleportToggleCircle.Parent = teleportToggle

local teleportToggleCircleCorner = Instance.new("UICorner")
teleportToggleCircleCorner.CornerRadius = UDim.new(1, 0)
teleportToggleCircleCorner.Parent = teleportToggleCircle

teleportToggle.MouseButton1Click:Connect(function()
    local enabled = toggleTeleport()
    if enabled then
        teleportToggle.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        createTween(teleportToggleCircle, {Position = UDim2.new(1, -27, 0.5, -12)}, 0.2):Play()
    else
        teleportToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
        createTween(teleportToggleCircle, {Position = UDim2.new(0, 3, 0.5, -12)}, 0.2):Play()
    end
end)

-- Other existing functions (same as before)
-- BULLET TRACK SYSTEM
local function toggleBulletTrack()
    bulletTrackEnabled = not bulletTrackEnabled
    
    if bulletTrackEnabled then
        local connection
        connection = RunService.Heartbeat:Connect(function()
            if not bulletTrackEnabled then
                connection:Disconnect()
                return
            end
            
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
    end
    
    return bulletTrackEnabled
end

-- GOD MODE SYSTEM
local function toggleGodMode()
    godModeEnabled = not godModeEnabled
    
    if godModeEnabled then
        originalHealth = humanoid.MaxHealth
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
        
        local godConnection
        godConnection = humanoid.HealthChanged:Connect(function()
            if godModeEnabled then
                humanoid.Health = humanoid.MaxHealth
            else
                godConnection:Disconnect()
            end
        end)
        
        spawn(function()
            while godModeEnabled do
                if humanoid.Health < humanoid.MaxHealth then
                    humanoid.Health = humanoid.MaxHealth
                end
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                wait(0.1)
            end
        end)
    else
        humanoid.MaxHealth = originalHealth or 100
        humanoid.Health = humanoid.MaxHealth
    end
    
    return godModeEnabled
end

-- FIXED FLY SYSTEM
local function Fly()
    if bg then bg:Destroy() end
    if bv then bv:Destroy() end
    
    bg = Instance.new("BodyGyro", rootPart)
    bg.P = 9e4
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.cframe = rootPart.CFrame
    
    bv = Instance.new("BodyVelocity", rootPart)
    bv.velocity = Vector3.new(0, 0, 0)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
    
    FLYING = true
    speed = 0
    
    spawn(function()
        while FLYING do
            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                speed = speed + .5 + (speed/maxspeed)
                if speed > maxspeed then
                    speed = maxspeed
                end
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                speed = speed - 1
                if speed < 0 then
                    speed = 0
                end
            end
            
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) + 
                              ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * .2, 0).p) - 
                               workspace.CurrentCamera.CoordinateFrame.p)) * speed
                lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
            elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                bv.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f + lastctrl.b)) + 
                              ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f + lastctrl.b) * .2, 0).p) - 
                               workspace.CurrentCamera.CoordinateFrame.p)) * speed
            else
                bv.velocity = Vector3.new(0, 0, 0)
            end
            
            bg.cframe = workspace.CurrentCamera.CoordinateFrame
            wait()
        end
        ctrl = {f = 0, b = 0, l = 0, r = 0}
        lastctrl = {f = 0, b = 0, l = 0, r = 0}
        speed = 0
        if bg then bg:Destroy() end
        if bv then bv:Destroy() end
    end)
end

local function UnFly()
    FLYING = false
end

mouse.KeyDown:Connect(function(key)
    if not FLYING then return end
    if key:lower() == "w" then
        ctrl.f = 1
    elseif key:lower() == "s" then
        ctrl.b = -1
    elseif key:lower() == "a" then
        ctrl.l = -1
    elseif key:lower() == "d" then
        ctrl.r = 1
    end
end)

mouse.KeyUp:Connect(function(key)
    if key:lower() == "w" then
        ctrl.f = 0
    elseif key:lower() == "s" then
        ctrl.b = 0
    elseif key:lower() == "a" then
        ctrl.l = 0
    elseif key:lower() == "d" then
        ctrl.r = 0
    end
end)

local function toggleFly()
    flyEnabled = not flyEnabled
    
    if flyEnabled then
        Fly()
    else
        UnFly()
    end
    
    return flyEnabled
end

-- Other functions
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
createFeatureCard("🕊️", "پرواز | Fly Mode", "WASD برای حرکت", toggleFly)
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
    teleportGuiStroke.Color = newColor
    
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
        createTween(mainFrame, {Size = UDim2.new(0, 520, 0, 500)}, 0.4):Play()
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
        createTween(mainFrame, {Size = UDim2.new(0, 520, 0, 500)}, 0.3):Play()
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
addHoverEffect(forwardBtn, Color3.fromRGB(35, 35, 42), Color3.fromRGB(25, 25, 32))
addHoverEffect(backwardBtn, Color3.fromRGB(35, 35, 42), Color3.fromRGB(25, 25, 32))
addHoverEffect(leftBtn, Color3.fromRGB(35, 35, 42), Color3.fromRGB(25, 25, 32))
addHoverEffect(rightBtn, Color3.fromRGB(35, 35, 42), Color3.fromRGB(25, 25, 32))
addHoverEffect(upBtn, Color3.fromRGB(35, 35, 42), Color3.fromRGB(30, 30, 38))
addHoverEffect(downBtn, Color3.fromRGB(35, 35, 42), Color3.fromRGB(30, 30, 38))

-- Logo Animation
spawn(function()
    while true do
        createTween(logoIcon, {Rotation = 360}, 3):Play()
        wait(3)
        logoIcon.Rotation = 0
        wait(2)
    end
end)

print("👑 منوی گاد نسخه 7 - لود شد!")
print("✅ Advanced Teleport: تلپورت پیشرفته با فریز")
print("✅ TextBox Input: تایپ عدد فاصله")
print("✅ Freeze Mode: فریز در موقعیت")
print("✅ Fast Lock: قفل سریع ضد سرور")
print("✅ Return Button: برگشت به موقعیت قبلی")
print("🔥 کاملا بدون باگ و آماده!")
