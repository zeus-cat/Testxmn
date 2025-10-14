-- 🌟 GOD MENU v9.0 - Clean Teleport (Fwd/Back) + Freeze + Numeric Input + ESP + Destroy
-- Note: No anti-cheat bypass. Designed for use in your own experiences or private tests.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function waitForCharacter()
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    local root = char:WaitForChild("HumanoidRootPart")
    return char, hum, root
end

local character, humanoid, rootPart = waitForCharacter()

-- State
local menuOpen = false
local isMinimized = false
local espEnabled = false
local teleportEnabled = false
local freezeEnabled = false
local teleportDistance = 10
local freezePosition = nil
local freezeConn = nil
local espLoop = nil

-- UI helpers
local function createTween(obj, props, duration)
    local info = TweenInfo.new(duration or 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    return TweenService:Create(obj, info, props)
end

-- MAIN GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GodMenuLite"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Toggle Logo
local logoButton = Instance.new("TextButton")
logoButton.Name = "LogoButton"
logoButton.Size = UDim2.new(0, 56, 0, 56)
logoButton.Position = UDim2.new(0, 18, 0.5, -28)
logoButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
logoButton.BorderSizePixel = 0
logoButton.Text = ""
logoButton.AutoButtonColor = false
logoButton.Active = true
logoButton.Draggable = true
logoButton.Parent = screenGui

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 14)
logoCorner.Parent = logoButton

local logoGrad = Instance.new("UIGradient")
logoGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45,45,60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25,25,35))
}
logoGrad.Rotation = 45
logoGrad.Parent = logoButton

local logoIcon = Instance.new("TextLabel")
logoIcon.Size = UDim2.new(1,0,1,0)
logoIcon.BackgroundTransparency = 1
logoIcon.Text = "◈"
logoIcon.TextColor3 = Color3.fromRGB(130,180,255)
logoIcon.TextScaled = true
logoIcon.Font = Enum.Font.SourceSansBold
logoIcon.Parent = logoButton

local logoStroke = Instance.new("UIStroke")
logoStroke.Color = Color3.fromRGB(130,180,255)
logoStroke.Thickness = 1.8
logoStroke.Transparency = 0.4
logoStroke.Parent = logoButton

-- Main Window
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 480, 0, 360)
mainFrame.Position = UDim2.new(0.5, -240, 0.5, -180)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(35,35,45)
mainStroke.Thickness = 1
mainStroke.Parent = mainFrame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1,0,0,50)
header.BackgroundColor3 = Color3.fromRGB(15,15,20)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerGrad = Instance.new("UIGradient")
headerGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(18,18,23)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(12,12,17))
}
headerGrad.Rotation = 90
headerGrad.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.6,0,1,0)
title.Position = UDim2.new(0,16,0,0)
title.BackgroundTransparency = 1
title.Text = "GOD MENU LITE"
title.TextColor3 = Color3.fromRGB(130,180,255)
title.TextSize = 20
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Header Controls
local controls = Instance.new("Frame")
controls.Size = UDim2.new(0, 120, 0, 30)
controls.Position = UDim2.new(1, -130, 0.5, -15)
controls.BackgroundTransparency = 1
controls.Parent = header

local function mkBtn(txt, posX, bg)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 30, 0, 30)
    b.Position = UDim2.new(0, posX, 0, 0)
    b.BackgroundColor3 = bg
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.TextSize = 20
    b.Font = Enum.Font.SourceSansBold
    b.AutoButtonColor = false
    b.Parent = controls
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,6)
    c.Parent = b
    return b
end

local minimizeBtn = mkBtn("−", 0, Color3.fromRGB(255,180,50))
local closeBtn    = mkBtn("×", 40, Color3.fromRGB(255,70,70))
local destroyBtn  = mkBtn("⚠", 80, Color3.fromRGB(100,100,100))

local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -20, 1, -60)
content.Position = UDim2.new(0,10,0,55)
content.BackgroundTransparency = 1
content.Parent = mainFrame

-- Feature card helper
local nextY = 0
local function featureCard(icon, titleText, descText, toggleCallback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 100)
    card.Position = UDim2.new(0, 0, 0, nextY)
    card.BackgroundColor3 = Color3.fromRGB(18,18,23)
    card.BorderSizePixel = 0
    card.Parent = content
    nextY = nextY + 110

    local c1 = Instance.new("UICorner")
    c1.CornerRadius = UDim.new(0,8)
    c1.Parent = card

    local st = Instance.new("UIStroke")
    st.Color = Color3.fromRGB(30,30,38)
    st.Thickness = 1
    st.Parent = card

    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0,60,0,60)
    iconLabel.Position = UDim2.new(0,15,0.5,-30)
    iconLabel.BackgroundColor3 = Color3.fromRGB(25,25,32)
    iconLabel.Text = icon
    iconLabel.TextSize = 28
    iconLabel.Font = Enum.Font.SourceSansBold
    iconLabel.Parent = card
    local icC = Instance.new("UICorner"); icC.CornerRadius = UDim.new(0,8); icC.Parent = iconLabel

    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(0.55,0,0,25)
    t.Position = UDim2.new(0, 90, 0, 20)
    t.BackgroundTransparency = 1
    t.Text = titleText
    t.TextColor3 = Color3.fromRGB(220,220,230)
    t.TextSize = 18
    t.Font = Enum.Font.SourceSansBold
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = card

    local d = Instance.new("TextLabel")
    d.Size = UDim2.new(0.55,0,0,20)
    d.Position = UDim2.new(0, 90, 0, 50)
    d.BackgroundTransparency = 1
    d.Text = descText
    d.TextColor3 = Color3.fromRGB(130,130,140)
    d.TextSize = 14
    d.Font = Enum.Font.SourceSans
    d.TextXAlignment = Enum.TextXAlignment.Left
    d.Parent = card

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0,60,0,30)
    toggle.Position = UDim2.new(1, -70, 0.5, -15)
    toggle.BackgroundColor3 = Color3.fromRGB(35,35,42)
    toggle.Text = ""
    toggle.AutoButtonColor = false
    toggle.Parent = card
    local tgC = Instance.new("UICorner"); tgC.CornerRadius = UDim.new(1,0); tgC.Parent = toggle

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0,24,0,24)
    knob.Position = UDim2.new(0,3,0.5,-12)
    knob.BackgroundColor3 = Color3.fromRGB(180,180,190)
    knob.Parent = toggle
    local kC = Instance.new("UICorner"); kC.CornerRadius = UDim.new(1,0); kC.Parent = knob

    toggle.MouseButton1Click:Connect(function()
        local on = toggleCallback()
        if on then
            toggle.BackgroundColor3 = Color3.fromRGB(130,180,255)
            createTween(knob, {Position = UDim2.new(1,-27,0.5,-12)}, 0.2):Play()
        else
            toggle.BackgroundColor3 = Color3.fromRGB(35,35,42)
            createTween(knob, {Position = UDim2.new(0,3,0.5,-12)}, 0.2):Play()
        end
    end)

    return card
end

-- ESP
local function cleanupESP()
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl.Character then
            local h = pl.Character:FindFirstChild("ESPHighlight")
            if h then h:Destroy() end
        end
    end
end

local function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        if espLoop then return true end
        espLoop = RunService.Heartbeat:Connect(function()
            for _, pl in ipairs(Players:GetPlayers()) do
                if pl ~= player and pl.Character then
                    local h = pl.Character:FindFirstChild("ESPHighlight")
                    if not h then
                        h = Instance.new("Highlight")
                        h.Name = "ESPHighlight"
                        h.FillColor = Color3.fromRGB(255,70,70)
                        h.FillTransparency = 0.6
                        h.OutlineColor = Color3.fromRGB(255,255,255)
                        h.Parent = pl.Character
                    end
                end
            end
        end)
    else
        if espLoop then espLoop:Disconnect(); espLoop = nil end
        cleanupESP()
    end
    return espEnabled
end

-- Teleport UI (only forward/back + numeric + freeze)
local teleportGui = Instance.new("Frame")
teleportGui.Name = "TeleportPanel"
teleportGui.Size = UDim2.new(0, 220, 0, 140)
teleportGui.Position = UDim2.new(0.5,-110, 0.75, -70)
teleportGui.BackgroundColor3 = Color3.fromRGB(15,15,20)
teleportGui.BorderSizePixel = 0
teleportGui.Visible = false
teleportGui.Active = true
teleportGui.Draggable = true
teleportGui.Parent = screenGui
local tpC = Instance.new("UICorner"); tpC.CornerRadius = UDim.new(0,12); tpC.Parent = teleportGui
local tpS = Instance.new("UIStroke"); tpS.Color = Color3.fromRGB(130,180,255); tpS.Transparency = 0.5; tpS.Thickness = 2; tpS.Parent = teleportGui

-- Distance Input
local distanceFrame = Instance.new("Frame")
distanceFrame.Size = UDim2.new(0, 110, 0, 30)
distanceFrame.Position = UDim2.new(0.5, -55, 0, 10)
distanceFrame.BackgroundColor3 = Color3.fromRGB(25,25,32)
distanceFrame.Parent = teleportGui
local dfC = Instance.new("UICorner"); dfC.CornerRadius = UDim.new(0,6); dfC.Parent = distanceFrame

local distanceInput = Instance.new("TextBox")
distanceInput.Size = UDim2.new(1,-10,1,0)
distanceInput.Position = UDim2.new(0,5,0,0)
distanceInput.BackgroundTransparency = 1
distanceInput.Text = tostring(teleportDistance)
distanceInput.PlaceholderText = "Distance"
distanceInput.TextColor3 = Color3.fromRGB(255,255,255)
distanceInput.TextSize = 14
distanceInput.Font = Enum.Font.SourceSans
distanceInput.ClearTextOnFocus = false
distanceInput.Parent = distanceFrame

distanceInput.FocusLost:Connect(function()
    local num = tonumber(distanceInput.Text)
    if num and num > 0 and num <= 10000 then
        teleportDistance = math.floor(num)
    else
        distanceInput.Text = tostring(teleportDistance)
    end
end)

-- Buttons Forward / Backward
local forwardBtn = Instance.new("TextButton")
forwardBtn.Size = UDim2.new(0, 90, 0, 36)
forwardBtn.Position = UDim2.new(0, 10, 0, 55)
forwardBtn.BackgroundColor3 = Color3.fromRGB(25,25,32)
forwardBtn.Text = "⬆ جلو"
forwardBtn.TextColor3 = Color3.fromRGB(130,180,255)
forwardBtn.TextSize = 16
forwardBtn.Font = Enum.Font.SourceSansBold
forwardBtn.Parent = teleportGui
local fC = Instance.new("UICorner"); fC.CornerRadius = UDim.new(0,8); fC.Parent = forwardBtn

local backwardBtn = Instance.new("TextButton")
backwardBtn.Size = UDim2.new(0, 90, 0, 36)
backwardBtn.Position = UDim2.new(1, -100, 0, 55)
backwardBtn.BackgroundColor3 = Color3.fromRGB(25,25,32)
backwardBtn.Text = "⬇ عقب"
backwardBtn.TextColor3 = Color3.fromRGB(130,180,255)
backwardBtn.TextSize = 16
backwardBtn.Font = Enum.Font.SourceSansBold
backwardBtn.Parent = teleportGui
local bC = Instance.new("UICorner"); bC.CornerRadius = UDim.new(0,8); bC.Parent = backwardBtn

-- Freeze Toggle
local freezeBtn = Instance.new("TextButton")
freezeBtn.Size = UDim2.new(1, -20, 0, 30)
freezeBtn.Position = UDim2.new(0,10, 1, -40)
freezeBtn.BackgroundColor3 = Color3.fromRGB(35,35,42)
freezeBtn.Text = "🔒 Freeze: OFF"
freezeBtn.TextColor3 = Color3.fromRGB(255,255,255)
freezeBtn.TextSize = 14
freezeBtn.Font = Enum.Font.SourceSansBold
freezeBtn.Parent = teleportGui
local frC = Instance.new("UICorner"); frC.CornerRadius = UDim.new(0,8); frC.Parent = freezeBtn

-- Teleport helpers
local function refreshRefsIfNeeded()
    if not character or not character.Parent then
        character, humanoid, rootPart = waitForCharacter()
    elseif not humanoid or not humanoid.Parent then
        humanoid = character:WaitForChild("Humanoid")
        rootPart = character:WaitForChild("HumanoidRootPart")
    elseif not rootPart or not rootPart.Parent then
        rootPart = character:WaitForChild("HumanoidRootPart")
    end
end

local function safeSetCFrame(cf)
    refreshRefsIfNeeded()
    if rootPart and rootPart.Parent then
        rootPart.CFrame = cf
        rootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
        rootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
    end
end

local function teleport(direction)
    refreshRefsIfNeeded()
    if not rootPart then return end

    -- project look on XZ to جلوگیری از تلپورت مورب به بالا/پایین
    local cf = rootPart.CFrame
    local look = cf.LookVector
    local flatLook = Vector3.new(look.X, 0, look.Z)
    if flatLook.Magnitude < 1e-3 then
        flatLook = Vector3.new(0, 0, -1)
    else
        flatLook = flatLook.Unit
    end

    local target
    if direction == "forward" then
        target = cf + flatLook * teleportDistance
    else
        target = cf - flatLook * teleportDistance
    end

    safeSetCFrame(target)

    if freezeEnabled then
        freezePosition = target
    end
end

-- Freeze toggle
local function toggleFreeze()
    freezeEnabled = not freezeEnabled

    if freezeEnabled then
        refreshRefsIfNeeded()
        freezePosition = rootPart and rootPart.CFrame or nil
        freezeBtn.Text = "🔒 Freeze: ON"
        freezeBtn.BackgroundColor3 = Color3.fromRGB(50,150,80)
        if freezeConn then freezeConn:Disconnect() end
        freezeConn = RunService.RenderStepped:Connect(function()
            if freezeEnabled and freezePosition then
                safeSetCFrame(freezePosition)
            end
        end)
    else
        freezeBtn.Text = "🔒 Freeze: OFF"
        freezeBtn.BackgroundColor3 = Color3.fromRGB(35,35,42)
        if freezeConn then freezeConn:Disconnect(); freezeConn = nil end
        freezePosition = nil
    end

    return freezeEnabled
end

-- Teleport Toggle (show panel)
local function toggleTeleport()
    teleportEnabled = not teleportEnabled
    teleportGui.Visible = teleportEnabled
    if not teleportEnabled and freezeEnabled then
        toggleFreeze()
    end
    return teleportEnabled
end

-- Card: ESP
featureCard("👁", "ESP | دید از دیوار", "نمایش بازیکنان نزدیک", toggleESP)

-- Card: Teleport (only forward/back + freeze + numeric input)
featureCard("🎯", "تلپورت ساده", "جلو/عقب + فریز + مقدار عددی", toggleTeleport)

-- Wire up buttons
forwardBtn.MouseButton1Click:Connect(function() teleport("forward") end)
backwardBtn.MouseButton1Click:Connect(function() teleport("backward") end)
freezeBtn.MouseButton1Click:Connect(toggleFreeze)

-- Character respawn: fix teleport-after-death
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    rootPart = newChar:WaitForChild("HumanoidRootPart")

    -- Reset freeze safely after death
    if freezeConn then freezeConn:Disconnect(); freezeConn = nil end
    freezeEnabled = false
    freezePosition = nil
    freezeBtn.Text = "🔒 Freeze: OFF"
    freezeBtn.BackgroundColor3 = Color3.fromRGB(35,35,42)

    -- Keep teleport panel usable
    if distanceInput and distanceInput.Text ~= tostring(teleportDistance) then
        distanceInput.Text = tostring(teleportDistance)
    end
end)

-- Window controls
logoButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    mainFrame.Visible = menuOpen
    if menuOpen then
        mainFrame.Size = UDim2.new(0,0,0,0)
        createTween(mainFrame, {Size = UDim2.new(0,480,0,360)}, 0.35):Play()
    end
end)

minimizeBtn.MouseButton1Click:Connect(function()
    if not isMinimized then
        isMinimized = true
        content.Visible = false
        createTween(mainFrame, {Size = UDim2.new(0,480,0,50)}, 0.25):Play()
    else
        isMinimized = false
        content.Visible = true
        createTween(mainFrame, {Size = UDim2.new(0,480,0,360)}, 0.25):Play()
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    createTween(mainFrame, {Size = UDim2.new(0,0,0,0)}, 0.25):Play()
    task.wait(0.25)
    mainFrame.Visible = false
    menuOpen = false
end)

-- Destroy All: closes everything cleanly
destroyBtn.MouseButton1Click:Connect(function()
    -- disable features
    if espLoop then espLoop:Disconnect(); espLoop = nil end
    if espEnabled then cleanupESP() end
    espEnabled = false

    if freezeConn then freezeConn:Disconnect(); freezeConn = nil end
    freezeEnabled = false
    freezePosition = nil

    teleportEnabled = false
    teleportGui.Visible = false

    -- remove GUI
    if screenGui then screenGui:Destroy() end
end)

-- Hover effects
local function hover(button, over, out)
    button.MouseEnter:Connect(function() createTween(button, {BackgroundColor3 = over}, 0.15):Play() end)
    button.MouseLeave:Connect(function() createTween(button, {BackgroundColor3 = out}, 0.15):Play() end)
end

hover(minimizeBtn, Color3.fromRGB(255,200,70), Color3.fromRGB(255,180,50))
hover(closeBtn, Color3.fromRGB(255,90,90), Color3.fromRGB(255,70,70))
hover(destroyBtn, Color3.fromRGB(130,130,130), Color3.fromRGB(100,100,100))
hover(forwardBtn, Color3.fromRGB(35,35,42), Color3.fromRGB(25,25,32))
hover(backwardBtn, Color3.fromRGB(35,35,42), Color3.fromRGB(25,25,32))
hover(freezeBtn, Color3.fromRGB(60,60,70), Color3.fromRGB(35,35,42))

-- Logo animation
task.spawn(function()
    while screenGui and screenGui.Parent do
        createTween(logoIcon, {Rotation = 360}, 3):Play()
        task.wait(3)
        logoIcon.Rotation = 0
        task.wait(2)
    end
end)

print("✅ GOD MENU LITE v9.0 loaded")
print("- ESP ready")
print("- Teleport (forward/back) with numeric input ready")
print("- Freeze fixed, auto-recovers after death")
print("- Destroy button removes everything cleanly")
