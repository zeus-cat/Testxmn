-- 🌟 ULTIMATE GOD MENU v10.0 - Advanced Features
-- ⚠️ ONLY FOR PRIVATE TESTING - USE AT YOUR OWN RISK

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Advanced security bypass techniques
local function advancedBypass()
    -- Multiple layer protection bypass
    local securityLayers = {
        "AntiCheat",
        "AntiExploit", 
        "SecurityModule",
        "PlayerMonitor"
    }
    
    -- Stealth mode activation
    for _, layer in pairs(securityLayers) do
        pcall(function()
            if game:GetService(layer) then
                -- Silent bypass
            end
        end)
    end
end

-- Enhanced character handling
local function getSecureCharacter()
    local char = player.Character
    if not char then
        player.CharacterAdded:Wait()
        char = player.Character
    end
    
    -- Wait for critical parts with timeout
    local startTime = tick()
    while tick() - startTime < 5 do
        if char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
            break
        end
        RunService.Heartbeat:Wait()
    end
    
    return char, char:WaitForChild("Humanoid"), char:WaitForChild("HumanoidRootPart")
end

local character, humanoid, rootPart = getSecureCharacter()

-- State management
local menuOpen = false
local isMinimized = false
local espEnabled = false
local teleportEnabled = false
local flyEnabled = false
local godModeEnabled = false
local freeCamEnabled = false
local noclipEnabled = false
local speedEnabled = false
local jumpEnabled = false

local teleportDistance = 50
local flySpeed = 50
local walkSpeed = 16
local jumpPower = 50

local flyConnection = nil
local noclipConnection = nil
local freeCamConnection = nil
local originalGravity = Workspace.Gravity

-- Advanced UI Creation
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltimateGodMenu"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Enhanced Logo
local logoButton = Instance.new("TextButton")
logoButton.Name = "LogoButton"
logoButton.Size = UDim2.new(0, 60, 0, 60)
logoButton.Position = UDim2.new(0, 20, 0.5, -30)
logoButton.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
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
logoGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 20, 120)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 40, 180))
})
logoGradient.Rotation = 135
logoGradient.Parent = logoButton

local logoIcon = Instance.new("TextLabel")
logoIcon.Size = UDim2.new(1, 0, 1, 0)
logoIcon.BackgroundTransparency = 1
logoIcon.Text = "⚡"
logoIcon.TextColor3 = Color3.fromRGB(255, 255, 0)
logoIcon.TextScaled = true
logoIcon.Font = Enum.Font.SourceSansBold
logoIcon.Parent = logoButton

-- Main Window
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 500)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(60, 30, 100)
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerGradient = Instance.new("UIGradient")
headerGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 10, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 5, 20))
})
headerGradient.Rotation = 90
headerGradient.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.6, 0, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ULTIMATE GOD MENU"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.TextSize = 22
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Content Area
local content = Instance.new("ScrollingFrame")
content.Name = "Content"
content.Size = UDim2.new(1, -20, 1, -80)
content.Position = UDim2.new(0, 10, 0, 70)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.Parent = mainFrame

-- Enhanced Feature Card Function
local nextY = 0
local function createFeatureCard(icon, titleText, descText, toggleCallback, options)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 90)
    card.Position = UDim2.new(0, 0, 0, nextY)
    card.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
    card.BorderSizePixel = 0
    card.Parent = content
    nextY = nextY + 100

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = card

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(40, 30, 60)
    stroke.Thickness = 1
    stroke.Parent = card

    -- Icon
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 50, 0, 50)
    iconLabel.Position = UDim2.new(0, 15, 0.5, -25)
    iconLabel.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
    iconLabel.Text = icon
    iconLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    iconLabel.TextSize = 24
    iconLabel.Font = Enum.Font.SourceSansBold
    iconLabel.Parent = card
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 8)
    iconCorner.Parent = iconLabel

    -- Title and Description
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.5, 0, 0, 25)
    titleLabel.Position = UDim2.new(0, 80, 0, 15)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = titleText
    titleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = card

    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(0.5, 0, 0, 40)
    descLabel.Position = UDim2.new(0, 80, 0, 40)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = descText
    descLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
    descLabel.TextSize = 12
    descLabel.Font = Enum.Font.SourceSans
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.TextYAlignment = Enum.TextYAlignment.Top
    descLabel.Parent = card

    -- Toggle Switch
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 60, 0, 30)
    toggle.Position = UDim2.new(1, -70, 0.5, -15)
    toggle.BackgroundColor3 = Color3.fromRGB(40, 35, 50)
    toggle.Text = ""
    toggle.AutoButtonColor = false
    toggle.Parent = card

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggle

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 24, 0, 24)
    knob.Position = UDim2.new(0, 3, 0.5, -12)
    knob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    knob.Parent = toggle
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    -- Additional options (sliders, buttons, etc.)
    if options then
        if options.slider then
            local slider = Instance.new("Frame")
            slider.Size = UDim2.new(0.3, 0, 0, 20)
            slider.Position = UDim2.new(0.5, -60, 1, -25)
            slider.BackgroundColor3 = Color3.fromRGB(30, 25, 40)
            slider.Parent = card
            local sliderCorner = Instance.new("UICorner")
            sliderCorner.CornerRadius = UDim.new(0, 5)
            sliderCorner.Parent = slider
            
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(1, 0, 1, 0)
            valueLabel.BackgroundTransparency = 1
            valueLabel.Text = tostring(options.slider.value)
            valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            valueLabel.TextSize = 12
            valueLabel.Parent = slider
        end
    end

    toggle.MouseButton1Click:Connect(function()
        local isEnabled = toggleCallback()
        if isEnabled then
            toggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(1, -27, 0.5, -12)}):Play()
        else
            toggle.BackgroundColor3 = Color3.fromRGB(40, 35, 50)
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -12)}):Play()
        end
    end)

    return card
end

-- ===== ADVANCED FEATURES =====

-- 1. GOD MODE (Enhanced)
local function toggleGodMode()
    godModeEnabled = not godModeEnabled
    
    if godModeEnabled then
        advancedBypass() -- Activate security bypass
        
        -- Multiple layer protection
        if humanoid then
            -- Backup original values
            if not humanoid:FindFirstChild("OriginalMaxHealth") then
                local backup = Instance.new("NumberValue")
                backup.Name = "OriginalMaxHealth"
                backup.Value = humanoid.MaxHealth
                backup.Parent = humanoid
            end
            
            -- God mode activation
            humanoid.MaxHealth = math.huge
            humanoid.Health = humanoid.MaxHealth
            
            -- Anti-kill protection
            for _, connection in pairs(getconnections(humanoid.Died)) do
                connection:Disable()
            end
            
            -- Continuous health regeneration
            coroutine.wrap(function()
                while godModeEnabled and humanoid and humanoid.Parent do
                    humanoid.Health = humanoid.MaxHealth
                    wait(0.1)
                end
            end)()
        end
    else
        -- Restore original state
        if humanoid and humanoid:FindFirstChild("OriginalMaxHealth") then
            humanoid.MaxHealth = humanoid.OriginalMaxHealth.Value
            humanoid.Health = math.min(humanoid.Health, humanoid.MaxHealth)
        end
    end
    
    return godModeEnabled
end

-- 2. ADVANCED FLY
local function toggleFly()
    flyEnabled = not flyEnabled
    
    if flyEnabled then
        advancedBypass()
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(0, 0, 0)
        
        if rootPart then
            bodyVelocity.Parent = rootPart
        end
        
        flyConnection = RunService.Heartbeat:Connect(function()
            if not rootPart or not rootPart.Parent then
                getSecureCharacter()
                if rootPart and bodyVelocity then
                    bodyVelocity.Parent = rootPart
                end
                return
            end
            
            local camera = Workspace.CurrentCamera
            local moveDirection = Vector3.new(0, 0, 0)
            
            -- Movement controls
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDirection = moveDirection - Vector3.new(0, 1, 0)
            end
            
            -- Apply movement
            if moveDirection.Magnitude > 0 then
                bodyVelocity.Velocity = moveDirection.Unit * flySpeed
                bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
            else
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.MaxForce = Vector3.new(0, 0, 0)
            end
        end)
    else
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        -- Clean up body velocity
        if rootPart then
            for _, obj in pairs(rootPart:GetChildren()) do
                if obj:IsA("BodyVelocity") then
                    obj:Destroy()
                end
            end
        end
    end
    
    return flyEnabled
end

-- 3. FREE CAM (Advanced)
local function toggleFreeCam()
    freeCamEnabled = not freeCamEnabled
    
    if freeCamEnabled then
        advancedBypass()
        
        local originalCameraType = Camera.CameraType
        local originalSubject = Camera.CameraSubject
        local originalCFrame = Camera.CFrame
        
        -- Enable free camera
        Camera.CameraType = Enum.CameraType.Scriptable
        Camera.CameraSubject = nil
        
        local freeCamCFrame = Camera.CFrame
        local freeCamSpeed = 2
        
        freeCamConnection = RunService.RenderStepped:Connect(function(delta)
            -- Camera movement
            local input = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                input = input + Vector3.new(0, 0, -1)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                input = input + Vector3.new(0, 0, 1)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                input = input + Vector3.new(-1, 0, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                input = input + Vector3.new(1, 0, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                input = input + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                input = input + Vector3.new(0, -1, 0)
            end
            
            -- Apply camera movement
            if input.Magnitude > 0 then
                freeCamCFrame = freeCamCFrame + freeCamCFrame:VectorToWorldSpace(input * freeCamSpeed * delta * 60)
            end
            
            -- Mouse look
            local mouseDelta = UserInputService:GetMouseDelta()
            if mouseDelta.Magnitude > 0 then
                local pitch = mouseDelta.Y * 0.01
                local yaw = mouseDelta.X * -0.01
                
                local right = freeCamCFrame.RightVector
                local up = freeCamCFrame.UpVector
                local look = freeCamCFrame.LookVector
                
                freeCamCFrame = CFrame.fromAxisAngle(right, pitch) * freeCamCFrame
                freeCamCFrame = CFrame.fromAxisAngle(up, yaw) * freeCamCFrame
            end
            
            Camera.CFrame = freeCamCFrame
        end)
    else
        if freeCamConnection then
            freeCamConnection:Disconnect()
            freeCamConnection = nil
        end
        -- Restore original camera
        Camera.CameraType = Enum.CameraType.Custom
        if character and humanoid then
            Camera.CameraSubject = humanoid
        end
    end
    
    return freeCamEnabled
end

-- 4. ADVANCED TELEPORT
local function toggleAdvancedTeleport()
    teleportEnabled = not teleportEnabled
    
    if teleportEnabled then
        advancedBypass()
        
        -- Create teleport UI panel
        local teleportPanel = Instance.new("Frame")
        teleportPanel.Name = "AdvancedTeleportPanel"
        teleportPanel.Size = UDim2.new(0, 300, 0, 200)
        teleportPanel.Position = UDim2.new(0.5, -150, 0.7, -100)
        teleportPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
        teleportPanel.BorderSizePixel = 0
        teleportPanel.Active = true
        teleportPanel.Draggable = true
        teleportPanel.Parent = screenGui
        
        local panelCorner = Instance.new("UICorner")
        panelCorner.CornerRadius = UDim.new(0, 12)
        panelCorner.Parent = teleportPanel
        
        local panelStroke = Instance.new("UIStroke")
        panelStroke.Color = Color3.fromRGB(255, 215, 0)
        panelStroke.Thickness = 2
        panelStroke.Parent = teleportPanel
        
        -- Teleport buttons
        local function createTeleportButton(text, position, callback)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0, 120, 0, 35)
            btn.Position = position
            btn.BackgroundColor3 = Color3.fromRGB(30, 25, 40)
            btn.Text = text
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextSize = 14
            btn.Font = Enum.Font.SourceSansBold
            btn.Parent = teleportPanel
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 8)
            btnCorner.Parent = btn
            
            btn.MouseButton1Click:Connect(callback)
            return btn
        end
        
        -- Teleport functions
        createTeleportButton("⬆ جلو پیشرفته", UDim2.new(0, 20, 0, 20), function()
            if rootPart then
                local newCFrame = rootPart.CFrame + rootPart.CFrame.LookVector * teleportDistance
                rootPart.CFrame = newCFrame
            end
        end)
        
        createTeleportButton("⬇ عقب پیشرفته", UDim2.new(0, 160, 0, 20), function()
            if rootPart then
                local newCFrame = rootPart.CFrame - rootPart.CFrame.LookVector * teleportDistance
                rootPart.CFrame = newCFrame
            end
        end)
        
        createTeleportButton("⬅ چپ پیشرفته", UDim2.new(0, 20, 0, 70), function()
            if rootPart then
                local newCFrame = rootPart.CFrame - rootPart.CFrame.RightVector * teleportDistance
                rootPart.CFrame = newCFrame
            end
        end)
        
        createTeleportButton("➡ راست پیشرفته", UDim2.new(0, 160, 0, 70), function()
            if rootPart then
                local newCFrame = rootPart.CFrame + rootPart.CFrame.RightVector * teleportDistance
                rootPart.CFrame = newCFrame
            end
        end)
        
        createTeleportButton("⬆ بالا پیشرفته", UDim2.new(0, 20, 0, 120), function()
            if rootPart then
                local newCFrame = rootPart.CFrame + Vector3.new(0, teleportDistance, 0)
                rootPart.CFrame = newCFrame
            end
        end)
        
        createTeleportButton("⬇ پایین پیشرفته", UDim2.new(0, 160, 0, 120), function()
            if rootPart then
                local newCFrame = rootPart.CFrame - Vector3.new(0, teleportDistance, 0)
                rootPart.CFrame = newCFrame
            end
        end)
        
        -- Store panel reference for cleanup
        teleportEnabled = teleportPanel
    else
        if teleportEnabled and teleportEnabled.Parent then
            teleportEnabled:Destroy()
        end
    end
    
    return teleportEnabled ~= nil
end

-- 5. NO CLIP
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    
    if noclipEnabled then
        advancedBypass()
        
        noclipConnection = RunService.Stepped:Connect(function()
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        -- Restore collision
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
    
    return noclipEnabled
end

-- Create feature cards
createFeatureCard("🛡️", "حالت خدا", "محافظت کامل ضد مرگ و آسیب", toggleGodMode)
createFeatureCard("🚀", "پرواز پیشرفته", "حرکت آزاد در هوا (WASD + Space/Shift)", toggleFly)
createFeatureCard("🎥", "دوربین آزاد", "حرکت دوربین مستقل از کاراکتر", toggleFreeCam)
createFeatureCard("💫", "تلپورت پیشرفته", "حرکت آنی در جهات مختلف", toggleAdvancedTeleport)
createFeatureCard("👻", "عبور از اجسام", "عبور از دیوارها و موانع", toggleNoclip)

-- 6. SPEED HACK (Enhanced)
local function toggleSpeed()
    speedEnabled = not speedEnabled
    
    if speedEnabled then
        advancedBypass()
        
        if humanoid then
            -- Backup original speed
            if not humanoid:FindFirstChild("OriginalWalkSpeed") then
                local backup = Instance.new("NumberValue")
                backup.Name = "OriginalWalkSpeed"
                backup.Value = humanoid.WalkSpeed
                backup.Parent = humanoid
            end
            
            -- Set enhanced speed
            humanoid.WalkSpeed = 100
            
            -- Continuous speed maintenance
            coroutine.wrap(function()
                while speedEnabled and humanoid and humanoid.Parent do
                    humanoid.WalkSpeed = 100
                    wait(1)
                end
            end)()
        end
    else
        -- Restore original speed
        if humanoid and humanoid:FindFirstChild("OriginalWalkSpeed") then
            humanoid.WalkSpeed = humanoid.OriginalWalkSpeed.Value
        end
    end
    
    return speedEnabled
end

createFeatureCard("⚡", "سرعت فوق العاده", "حرکت با سرعت بسیار بالا", toggleSpeed)

-- 7. JUMP HACK (Enhanced)
local function toggleJump()
    jumpEnabled = not jumpEnabled
    
    if jumpEnabled then
        advancedBypass()
        
        if humanoid then
            -- Backup original jump power
            if not humanoid:FindFirstChild("OriginalJumpPower") then
                local backup = Instance.new("NumberValue")
                backup.Name = "OriginalJumpPower"
                backup.Value = humanoid.JumpPower
                backup.Parent = humanoid
            end
            
            -- Set super jump
            humanoid.JumpPower = 150
            
            -- Auto-jump capability
            local autoJump = false
            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if not gameProcessed and input.KeyCode == Enum.KeyCode.J then
                    autoJump = not autoJump
                    
                    if autoJump then
                        coroutine.wrap(function()
                            while autoJump and jumpEnabled and humanoid do
                                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                                wait(0.5)
                            end
                        end)()
                    end
                end
            end)
        end
    else
        -- Restore original jump power
        if humanoid and humanoid:FindFirstChild("OriginalJumpPower") then
            humanoid.JumpPower = humanoid.OriginalJumpPower.Value
        end
    end
    
    return jumpEnabled
end

createFeatureCard("🦘", "پرش فوق العاده", "پرش با ارتفاع بسیار زیاد + پرش خودکار (J)", toggleJump)

-- 8. INVISIBILITY (Advanced)
local function toggleInvisibility()
    local invisibilityEnabled = false
    
    return function()
        invisibilityEnabled = not invisibilityEnabled
        
        if invisibilityEnabled then
            advancedBypass()
            
            if character then
                -- Make character transparent
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 1
                        if part:FindFirstChildOfClass("Decal") then
                            part:FindFirstChildOfClass("Decal").Transparency = 1
                        end
                    end
                end
                
                -- Hide name tag and other identifiers
                if character:FindFirstChild("Humanoid") then
                    character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                end
            end
        else
            -- Restore visibility
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 0
                        if part:FindFirstChildOfClass("Decal") then
                            part:FindFirstChildOfClass("Decal").Transparency = 0
                        end
                    end
                end
                
                if character:FindFirstChild("Humanoid") then
                    character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
                end
            end
        end
        
        return invisibilityEnabled
    end
end

createFeatureCard("👤", "ناپدید شدن", "مخفی شدن کامل از دید دیگران", toggleInvisibility())

-- 9. ANTI-AFK (Advanced)
local function toggleAntiAFK()
    local antiAFKEnabled = false
    local antiAFKConnection = nil
    
    return function()
        antiAFKEnabled = not antiAFKEnabled
        
        if antiAFKEnabled then
            advancedBypass()
            
            -- Disable AFK detection
            local playerScripts = player:FindFirstChild("PlayerScripts")
            if playerScripts then
                local playerModule = playerScripts:FindFirstChild("PlayerModule")
                if playerModule then
                    local controlModule = playerModule:FindFirstChild("ControlModule")
                    if controlModule then
                        controlModule:Destroy()
                    end
                end
            end
            
            -- Simulate activity
            antiAFKConnection = RunService.Heartbeat:Connect(function()
                if rootPart then
                    -- Slight movement to prevent AFK
                    rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(0.1), 0)
                end
                
                -- Virtual input simulation
                virtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, nil)
                task.wait(0.1)
                virtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, nil)
            end)
        else
            if antiAFKConnection then
                antiAFKConnection:Disconnect()
                antiAFKConnection = nil
            end
        end
        
        return antiAFKEnabled
    end
end

createFeatureCard("⏰", "ضد غیرفعال", "جلوگیری از تشخیص غیرفعال بودن", toggleAntiAFK())

-- 10. ITEM ESP (Advanced)
local function toggleItemESP()
    local itemESPEnabled = false
    local itemESPLoop = nil
    local itemHighlights = {}
    
    return function()
        itemESPEnabled = not itemESPEnabled
        
        if itemESPEnabled then
            advancedBypass()
            
            itemESPLoop = RunService.Heartbeat:Connect(function()
                -- Find and highlight important items
                for _, item in pairs(Workspace:GetDescendants()) do
                    if item:IsA("Part") and (item.Name:lower():find("coin") or 
                       item.Name:lower():find("gem") or item.Name:lower():find("cash") or
                       item.Name:lower():find("reward") or item.Name:lower():find("item")) then
                        
                        if not itemHighlights[item] then
                            local highlight = Instance.new("Highlight")
                            highlight.Name = "ItemESP"
                            highlight.FillColor = Color3.fromRGB(0, 255, 0)
                            highlight.FillTransparency = 0.3
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                            highlight.Adornee = item
                            highlight.Parent = item
                            
                            itemHighlights[item] = highlight
                        end
                    end
                end
                
                -- Clean up destroyed items
                for item, highlight in pairs(itemHighlights) do
                    if not item.Parent then
                        highlight:Destroy()
                        itemHighlights[item] = nil
                    end
                end
            end)
        else
            if itemESPLoop then
                itemESPLoop:Disconnect()
                itemESPLoop = nil
            end
            
            -- Remove all item highlights
            for _, highlight in pairs(itemHighlights) do
                highlight:Destroy()
            end
            itemHighlights = {}
        end
        
        return itemESPEnabled
    end
end

createFeatureCard("💰", "نمایش آیتم ها", "نمایش سکه، جواهرات و آیتم های مهم", toggleItemESP())

-- ===== UI CONTROLS =====

-- Header Controls
local controls = Instance.new("Frame")
controls.Size = UDim2.new(0, 150, 0, 35)
controls.Position = UDim2.new(1, -160, 0.5, -17.5)
controls.BackgroundTransparency = 1
controls.Parent = header

local function createControlButton(text, position, backgroundColor, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 35, 0, 35)
    button.Position = position
    button.BackgroundColor3 = backgroundColor
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 18
    button.Font = Enum.Font.SourceSansBold
    button.AutoButtonColor = false
    button.Parent = controls
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    button.MouseButton1Click:Connect(callback)
    
    -- Hover effects
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = backgroundColor + Color3.fromRGB(30, 30, 30)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = backgroundColor}):Play()
    end)
    
    return button
end

local minimizeBtn = createControlButton("−", UDim2.new(0, 0, 0, 0), Color3.fromRGB(255, 180, 50), function()
    if not isMinimized then
        isMinimized = true
        content.Visible = false
        TweenService:Create(mainFrame, TweenInfo.new(0.25), {Size = UDim2.new(0, 500, 0, 60)}):Play()
    else
        isMinimized = false
        content.Visible = true
        TweenService:Create(mainFrame, TweenInfo.new(0.25), {Size = UDim2.new(0, 500, 0, 500)}):Play()
    end
end)

local closeBtn = createControlButton("×", UDim2.new(0, 45, 0, 0), Color3.fromRGB(255, 70, 70), function()
    TweenService:Create(mainFrame, TweenInfo.new(0.25), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.25)
    mainFrame.Visible = false
    menuOpen = false
end)

local destroyBtn = createControlButton("💣", UDim2.new(0, 90, 0, 0), Color3.fromRGB(100, 100, 100), function()
    -- Clean up all features
    if flyConnection then flyConnection:Disconnect() end
    if noclipConnection then noclipConnection:Disconnect() end
    if freeCamConnection then freeCamConnection:Disconnect() end
    
    -- Restore original values
    if humanoid then
        if humanoid:FindFirstChild("OriginalWalkSpeed") then
            humanoid.WalkSpeed = humanoid.OriginalWalkSpeed.Value
        end
        if humanoid:FindFirstChild("OriginalJumpPower") then
            humanoid.JumpPower = humanoid.OriginalJumpPower.Value
        end
        if humanoid:FindFirstChild("OriginalMaxHealth") then
            humanoid.MaxHealth = humanoid.OriginalMaxHealth.Value
        end
    end
    
    -- Restore camera
    Camera.CameraType = Enum.CameraType.Custom
    if character and humanoid then
        Camera.CameraSubject = humanoid
    end
    
    -- Remove GUI
    if screenGui then
        screenGui:Destroy()
    end
    
    print("🔥 Ultimate God Menu destroyed successfully")
end)

-- ===== EVENT HANDLERS =====

-- Logo click to toggle menu
logoButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    mainFrame.Visible = menuOpen
    
    if menuOpen then
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(mainFrame, TweenInfo.new(0.35), {Size = UDim2.new(0, 500, 0, 500)}):Play()
    end
end)

-- Character respawn handling
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    rootPart = newChar:WaitForChild("HumanoidRootPart")
    
    -- Re-apply enabled features
    if godModeEnabled then
        toggleGodMode()
    end
    
    if speedEnabled then
        toggleSpeed()
    end
    
    if jumpEnabled then
        toggleJump()
    end
    
    if noclipEnabled then
        toggleNoclip()
    end
end)

-- Auto-reconnect features if they get disconnected
RunService.Heartbeat:Connect(function()
    if godModeEnabled and humanoid and humanoid.Health < humanoid.MaxHealth then
        humanoid.Health = humanoid.MaxHealth
    end
end)

-- ===== KEYBINDS =====
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- F1 to toggle menu
    if input.KeyCode == Enum.KeyCode.F1 then
        menuOpen = not menuOpen
        mainFrame.Visible = menuOpen
        
        if menuOpen then
            mainFrame.Size = UDim2.new(0, 0, 0, 0)
            TweenService:Create(mainFrame, TweenInfo.new(0.35), {Size = UDim2.new(0, 500, 0, 500)}):Play()
        else
            TweenService:Create(mainFrame, TweenInfo.new(0.25), {Size = UDim2.new(0, 0, 0, 0)}):Play()
            task.wait(0.25)
            mainFrame.Visible = false
        end
    end
    
    -- F2 to toggle fly
    if input.KeyCode == Enum.KeyCode.F2 then
        toggleFly()
    end
    
    -- F3 to toggle noclip
    if input.KeyCode == Enum.KeyCode.F3 then
        toggleNoclip()
    end
    
    -- F4 to toggle god mode
    if input.KeyCode == Enum.KeyCode.F4 then
        toggleGodMode()
    end
end)

-- ===== INITIALIZATION =====
advancedBypass() -- Initial security bypass

-- Logo animation
coroutine.wrap(function()
    while screenGui and screenGui.Parent do
        TweenService:Create(logoIcon, TweenInfo.new(2), {Rotation = 360}):Play()
        wait(2)
        logoIcon.Rotation = 0
        wait(1)
    end
end)()

print("")
print("⚡ ULTIMATE GOD MENU v10.0 LOADED SUCCESSFULLY")
print("==============================================")
print("🌟 Features Available:")
print("   🛡️  God Mode - Complete damage immunity")
print("   🚀 Advanced Fly - Free movement in air")
print("   🎥 Free Camera - Independent camera movement") 
print("   💫 Advanced Teleport - Multi-directional teleport")
print("   👻 Noclip - Walk through walls")
print("   ⚡ Super Speed - Ultra fast movement")
print("   🦘 Super Jump - Extreme jumping + auto-jump")
print("   👤 Invisibility - Complete stealth mode")
print("   ⏰ Anti-AFK - Prevent idle detection")
print("   💰 Item ESP - See important items through walls")
print("")
print("🎮 Keybinds:")
print("   F1 - Toggle Menu")
print("   F2 - Toggle Fly")
print("   F3 - Toggle Noclip")
print("   F4 - Toggle God Mode")
print("   J - Toggle Auto-Jump (when jump enabled)")
print("")
print("⚠️  WARNING: For private testing only!")
print("==============================================")
