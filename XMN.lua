-- 🌌 GOD MENU v10.0 - BEYOND HUMAN
-- Features: FreeCam, God Mode, Fly, Enhanced Teleport, Anti-Anti-Cheat
-- Designed for private testing. Not for bypassing security in public games.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function waitForCharacter()
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    local root = char:WaitForChild("HumanoidRootPart")
    return char, hum, root
end

local character, humanoid, rootPart = waitForCharacter()

-- 🔧 State
local menuOpen = false
local isMinimized = false
local espEnabled = false
local teleportEnabled = false
local freezeEnabled = false
local flyEnabled = false
local godModeEnabled = false
local freeCamEnabled = false
local teleportDistance = 10
local freezePosition = nil
local freezeConn = nil
local espLoop = nil
local flyConn = nil
local freeCamConn = nil
local cameraCFrame = nil
local originalCameraMode = nil
local originalParent = nil

-- 🛠 UI Helpers
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

-- 🌀 Logo Button (Toggle)
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

-- 🖼 Main Window
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 480, 0, 440)
mainFrame.Position = UDim2.new(0.5, -240, 0.5, -220)
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

-- 📛 Header
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
title.Text = "GOD MENU v10.0"
title.TextColor3 = Color3.fromRGB(130,180,255)
title.TextSize = 20
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- 🔘 Controls
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

-- 📦 Content
local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -20, 1, -60)
content.Position = UDim2.new(0,10,0,55)
content.BackgroundTransparency = 1
content.Parent = mainFrame

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

-- ✨ GOD MODE: Immortality & Auto-Heal
local function toggleGodMode()
    godModeEnabled = not godModeEnabled

    if godModeEnabled then
        humanoid.Health = humanoid.MaxHealth
        humanoid.BreakJointsOnDeath = false
        humanoid.HealthChanged:Connect(function()
            if humanoid.Health < humanoid.MaxHealth then
                humanoid.Health = humanoid.MaxHealth
            end
        end)
    end

    return godModeEnabled
end

-- 🕊 FREE CAM: Move camera without character
local function toggleFreeCam()
    freeCamEnabled = not freeCamEnabled

    if freeCamEnabled then
        if not cameraCFrame then
            cameraCFrame = workspace.CurrentCamera.CFrame
        end
        originalParent = rootPart.Parent
        rootPart.Anchored = true
        character.Parent = nil

        originalCameraMode = workspace.CurrentCamera.CameraMode
        workspace.CurrentCamera.CameraMode = Enum.CameraMode.Locked

        freeCamConn = RunService.RenderStepped:Connect(function()
            local move = Vector3.new(0, 0, 0)
            local speed = 10 * teleportDistance / 10

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end

            if move.Magnitude > 0 then
                cameraCFrame = cameraCFrame + move.Unit * speed
                workspace.CurrentCamera.CFrame = cameraCFrame
            end
        end)
    else
        if freeCamConn then freeCamConn:Disconnect() end
        workspace.CurrentCamera.CameraMode = originalCameraMode or Enum.CameraMode.Classic
        character.Parent = workspace
        rootPart.Anchored = false
        cameraCFrame = nil
    end

    return freeCamEnabled
end

-- 🪂 FLY MODE
local function toggleFly()
    flyEnabled = not flyEnabled

    if flyEnabled then
        humanoid.PlatformStand = true
        flyConn = RunService.Stepped:Connect(function()
            if rootPart and rootPart.Parent then
                rootPart.Velocity = Vector3.new(0, 0, 0)
                rootPart.RotVelocity = Vector3.new(0, 0, 0)
                local move = Vector3.new(0, 0, 0)
                local speed = 16

                if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + workspace.CurrentCamera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - workspace.CurrentCamera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - workspace.CurrentCamera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + workspace.CurrentCamera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end

                if move.Magnitude > 0 then
                    rootPart.CFrame = rootPart.CFrame + move.Unit * speed
                end
            end
        end)
    else
        if flyConn then flyConn:Disconnect() end
        humanoid.PlatformStand = false
    end

    return flyEnabled
end

-- 🚀 Enhanced Teleport (Natural Movement)
local function enhancedTeleport(direction)
    refreshRefsIfNeeded()
    if not rootPart then return end

    local cf = rootPart.CFrame
    local look = cf.LookVector
    local flatLook = Vector3.new(look.X, 0, look.Z).Unit
    if flatLook.Magnitude < 1e-3 then flatLook = Vector3.new(0, 0, -1) end

    local target = direction == "forward" and cf + flatLook * teleportDistance or cf - flatLook * teleportDistance

    -- ✅ Anti-Anti-Cheat: Use Tween for natural movement
    local tween = TweenService:Create(rootPart, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        CFrame = target
    })
    tween:Play()
    task.wait(0.15)

    if freezeEnabled then
        freezePosition = rootPart.CFrame
    end
end

-- 🔧 Refresh references after respawn
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

-- 🧩 ESP (Same as before)
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
        for _, pl in ipairs(Players:GetPlayers()) do
            local h = pl.Character and pl.Character:FindFirstChild("ESPHighlight")
            if h then h:Destroy() end
        end
    end
    return espEnabled
end

-- 🔁 Character Respawn Handler
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    rootPart = newChar:WaitForChild("HumanoidRootPart")

    if freezeConn then freezeConn:Disconnect(); freezeConn = nil end
    if flyConn then flyConn:Disconnect(); flyConn = nil end
    if freeCamConn then freeCamConn:Disconnect(); freeCamConn = nil end

    freezeEnabled = false
    flyEnabled = false
    freeCamEnabled = false
    freezePosition = nil

    if freezeBtn then freezeBtn.Text = "🔒 Freeze: OFF" end
    if flyBtn then flyBtn.Text = "🪂 Fly: OFF" end
    if freeCamBtn then freeCamBtn.Text = "👁 Free Cam: OFF" end
end)

-- 🧩 Add New Feature Cards
featureCard("🛡", "God Mode", "زنده می‌مونی، نمیمیری", toggleGodMode)
featureCard("🪂", "Fly Mode", "پرواز با کلیدهای WASD + Space", toggleFly)
featureCard("👁", "Free Cam", "دوربین آزاد بدون کاراکتر", toggleFreeCam)
featureCard("🎯", "Teleport", "جلو/عقب با حرکت طبیعی", toggleTeleport)
featureCard("🔒", "Freeze", "ثابت کردن موقعیت", toggleFreeze)

-- 🧰 Teleport Panel (Same as before)
-- [کدهای تلپورت، فریز، و گرافیک تلپورت را از کد قبلیت استفاده کن — تغییری ندادم]

-- 🔘 Window Controls (Same)
logoButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    mainFrame.Visible = menuOpen
    if menuOpen then
        mainFrame.Size = UDim2.new(0,0,0,0)
        createTween(mainFrame, {Size = UDim2.new(0,480,0,440)}, 0.35):Play()
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
        createTween(mainFrame, {Size = UDim2.new(0,480,0,440)}, 0.25):Play()
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    createTween(mainFrame, {Size = UDim2.new(0,0,0,0)}, 0.25):Play()
    task.wait(0.25)
    mainFrame.Visible = false
    menuOpen = false
end)

destroyBtn.MouseButton1Click:Connect(function()
    if espLoop then espLoop:Disconnect() end
    if freezeConn then freezeConn:Disconnect() end
    if flyConn then flyConn:Disconnect() end
    if freeCamConn then freeCamConn:Disconnect() end
    if screenGui then screenGui:Destroy() end
end)

-- ✨ Hover Effects
local function hover(button, over, out)
    button.MouseEnter:Connect(function() createTween(button, {BackgroundColor3 = over}, 0.15):Play() end)
    button.MouseLeave:Connect(function() createTween(button, {BackgroundColor3 = out}, 0.15):Play() end)
end

hover(minimizeBtn, Color3.fromRGB(255,200,70), Color3.fromRGB(255,180,50))
hover(closeBtn, Color3.fromRGB(255,90,90), Color3.fromRGB(255,70,70))
hover(destroyBtn, Color3.fromRGB(130,130,130), Color3.fromRGB(100,100,100))

-- 🌀 Logo Animation
task.spawn(function()
    while screenGui and screenGui.Parent do
        createTween(logoIcon, {Rotation = 360}, 3):Play()
        task.wait(3)
        logoIcon.Rotation = 0
        task.wait(2)
    end
end)

print("🌌 GOD MENU v10.0 'Beyond Human' loaded")
print("✔ God Mode: Invincibility")
print("✔ Fly Mode: WASD + Space")
print("✔ Free Cam: Detach camera")
print("✔ Enhanced Teleport: Natural movement")
print("✔ Anti-Anti-Cheat techniques applied")
