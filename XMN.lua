-- 🎯 Pro Menu v3.0 - Ultra Clean & Modern
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local mouse = player:GetMouse()

-- Services
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Variables
local menuOpen = false
local autoWalking = false
local aimBotEnabled = false
local isDragging = false
local isResizing = false

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltraProMenu"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Logo Button (Menu Toggle)
local logoButton = Instance.new("TextButton")
logoButton.Name = "LogoButton"
logoButton.Size = UDim2.new(0, 50, 0, 50)
logoButton.Position = UDim2.new(0, 20, 0.5, -25)
logoButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
logoButton.BorderSizePixel = 0
logoButton.Text = ""
logoButton.AutoButtonColor = false
logoButton.Parent = screenGui

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 12)
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
logoIcon.Text = "◈"
logoIcon.TextColor3 = Color3.fromRGB(130, 180, 255)
logoIcon.TextScaled = true
logoIcon.Font = Enum.Font.SourceSansBold
logoIcon.Parent = logoButton

local logoStroke = Instance.new("UIStroke")
logoStroke.Color = Color3.fromRGB(130, 180, 255)
logoStroke.Thickness = 1.5
logoStroke.Transparency = 0.5
logoStroke.Parent = logoButton

-- Main Menu Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 450, 0, 350)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.ClipsDescendants = true
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
header.Size = UDim2.new(1, 0, 0, 45)
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
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ULTRA MENU"
title.TextColor3 = Color3.fromRGB(130, 180, 255)
title.TextSize = 18
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local titleGlow = Instance.new("TextLabel")
titleGlow.Size = UDim2.new(0.6, 0, 1, 0)
titleGlow.Position = UDim2.new(0, 15, 0, 1)
titleGlow.BackgroundTransparency = 1
titleGlow.Text = "ULTRA MENU"
titleGlow.TextColor3 = Color3.fromRGB(130, 180, 255)
titleGlow.TextSize = 18
titleGlow.Font = Enum.Font.SourceSansBold
titleGlow.TextXAlignment = Enum.TextXAlignment.Left
titleGlow.TextTransparency = 0.8
titleGlow.Parent = header

-- Window Controls
local controls = Instance.new("Frame")
controls.Size = UDim2.new(0, 70, 0, 30)
controls.Position = UDim2.new(1, -75, 0.5, -15)
controls.BackgroundTransparency = 1
controls.Parent = header

-- Minimize Button
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 28, 0, 28)
minimizeBtn.Position = UDim2.new(0, 0, 0, 0)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 50)
minimizeBtn.Text = ""
minimizeBtn.AutoButtonColor = false
minimizeBtn.Parent = controls

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeBtn

local minIcon = Instance.new("TextLabel")
minIcon.Size = UDim2.new(1, 0, 1, 0)
minIcon.BackgroundTransparency = 1
minIcon.Text = "−"
minIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
minIcon.TextSize = 20
minIcon.Font = Enum.Font.SourceSansBold
minIcon.Parent = minimizeBtn

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(0, 35, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
closeBtn.Text = ""
closeBtn.AutoButtonColor = false
closeBtn.Parent = controls

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

local closeIcon = Instance.new("TextLabel")
closeIcon.Size = UDim2.new(1, 0, 1, 0)
closeIcon.BackgroundTransparency = 1
closeIcon.Text = "×"
closeIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
closeIcon.TextSize = 22
closeIcon.Font = Enum.Font.SourceSansBold
closeIcon.Parent = closeBtn

-- Content Container
local content = Instance.new("ScrollingFrame")
content.Name = "Content"
content.Size = UDim2.new(1, -20, 1, -55)
content.Position = UDim2.new(0, 10, 0, 50)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 3
content.ScrollBarImageColor3 = Color3.fromRGB(130, 180, 255)
content.ScrollBarImageTransparency = 0.5
content.CanvasSize = UDim2.new(0, 0, 0, 500)
content.Parent = mainFrame

-- Feature Card 1: Auto Walk
local card1 = Instance.new("Frame")
card1.Size = UDim2.new(1, -10, 0, 90)
card1.Position = UDim2.new(0, 5, 0, 10)
card1.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
card1.BorderSizePixel = 0
card1.Parent = content

local card1Corner = Instance.new("UICorner")
card1Corner.CornerRadius = UDim.new(0, 8)
card1Corner.Parent = card1

local card1Stroke = Instance.new("UIStroke")
card1Stroke.Color = Color3.fromRGB(30, 30, 38)
card1Stroke.Thickness = 1
card1Stroke.Parent = card1

local walkIcon = Instance.new("TextLabel")
walkIcon.Size = UDim2.new(0, 50, 0, 50)
walkIcon.Position = UDim2.new(0, 15, 0.5, -25)
walkIcon.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
walkIcon.Text = "🚶"
walkIcon.TextSize = 24
walkIcon.Font = Enum.Font.SourceSansBold
walkIcon.Parent = card1

local walkIconCorner = Instance.new("UICorner")
walkIconCorner.CornerRadius = UDim.new(0, 8)
walkIconCorner.Parent = walkIcon

local walkTitle = Instance.new("TextLabel")
walkTitle.Size = UDim2.new(0.5, 0, 0, 25)
walkTitle.Position = UDim2.new(0, 80, 0, 15)
walkTitle.BackgroundTransparency = 1
walkTitle.Text = "Auto Walk"
walkTitle.TextColor3 = Color3.fromRGB(220, 220, 230)
walkTitle.TextSize = 16
walkTitle.Font = Enum.Font.SourceSansBold
walkTitle.TextXAlignment = Enum.TextXAlignment.Left
walkTitle.Parent = card1

local walkDesc = Instance.new("TextLabel")
walkDesc.Size = UDim2.new(0.5, 0, 0, 20)
walkDesc.Position = UDim2.new(0, 80, 0, 40)
walkDesc.BackgroundTransparency = 1
walkDesc.Text = "6 seconds auto movement"
walkDesc.TextColor3 = Color3.fromRGB(130, 130, 140)
walkDesc.TextSize = 13
walkDesc.Font = Enum.Font.SourceSans
walkDesc.TextXAlignment = Enum.TextXAlignment.Left
walkDesc.Parent = card1

-- Toggle Switch for Auto Walk
local toggle1 = Instance.new("Frame")
toggle1.Size = UDim2.new(0, 50, 0, 26)
toggle1.Position = UDim2.new(1, -65, 0.5, -13)
toggle1.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
toggle1.Parent = card1

local toggle1Corner = Instance.new("UICorner")
toggle1Corner.CornerRadius = UDim.new(1, 0)
toggle1Corner.Parent = toggle1

local toggle1Button = Instance.new("TextButton")
toggle1Button.Size = UDim2.new(1, 0, 1, 0)
toggle1Button.BackgroundTransparency = 1
toggle1Button.Text = ""
toggle1Button.Parent = toggle1

local toggle1Circle = Instance.new("Frame")
toggle1Circle.Size = UDim2.new(0, 20, 0, 20)
toggle1Circle.Position = UDim2.new(0, 3, 0.5, -10)
toggle1Circle.BackgroundColor3 = Color3.fromRGB(180, 180, 190)
toggle1Circle.Parent = toggle1

local toggle1CircleCorner = Instance.new("UICorner")
toggle1CircleCorner.CornerRadius = UDim.new(1, 0)
toggle1CircleCorner.Parent = toggle1Circle

-- Feature Card 2: Aim Bot
local card2 = Instance.new("Frame")
card2.Size = UDim2.new(1, -10, 0, 90)
card2.Position = UDim2.new(0, 5, 0, 110)
card2.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
card2.BorderSizePixel = 0
card2.Parent = content

local card2Corner = Instance.new("UICorner")
card2Corner.CornerRadius = UDim.new(0, 8)
card2Corner.Parent = card2

local card2Stroke = Instance.new("UIStroke")
card2Stroke.Color = Color3.fromRGB(30, 30, 38)
card2Stroke.Thickness = 1
card2Stroke.Parent = card2

local aimIcon = Instance.new("TextLabel")
aimIcon.Size = UDim2.new(0, 50, 0, 50)
aimIcon.Position = UDim2.new(0, 15, 0.5, -25)
aimIcon.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
aimIcon.Text = "🎯"
aimIcon.TextSize = 24
aimIcon.Font = Enum.Font.SourceSansBold
aimIcon.Parent = card2

local aimIconCorner = Instance.new("UICorner")
aimIconCorner.CornerRadius = UDim.new(0, 8)
aimIconCorner.Parent = aimIcon

local aimTitle = Instance.new("TextLabel")
aimTitle.Size = UDim2.new(0.5, 0, 0, 25)
aimTitle.Position = UDim2.new(0, 80, 0, 15)
aimTitle.BackgroundTransparency = 1
aimTitle.Text = "Simple Aim Bot"
aimTitle.TextColor3 = Color3.fromRGB(220, 220, 230)
aimTitle.TextSize = 16
aimTitle.Font = Enum.Font.SourceSansBold
aimTitle.TextXAlignment = Enum.TextXAlignment.Left
aimTitle.Parent = card2

local aimDesc = Instance.new("TextLabel")
aimDesc.Size = UDim2.new(0.5, 0, 0, 20)
aimDesc.Position = UDim2.new(0, 80, 0, 40)
aimDesc.BackgroundTransparency = 1
aimDesc.Text = "Basic targeting assistant"
aimDesc.TextColor3 = Color3.fromRGB(130, 130, 140)
aimDesc.TextSize = 13
aimDesc.Font = Enum.Font.SourceSans
aimDesc.TextXAlignment = Enum.TextXAlignment.Left
aimDesc.Parent = card2

-- Toggle Switch for Aim Bot
local toggle2 = Instance.new("Frame")
toggle2.Size = UDim2.new(0, 50, 0, 26)
toggle2.Position = UDim2.new(1, -65, 0.5, -13)
toggle2.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
toggle2.Parent = card2

local toggle2Corner = Instance.new("UICorner")
toggle2Corner.CornerRadius = UDim.new(1, 0)
toggle2Corner.Parent = toggle2

local toggle2Button = Instance.new("TextButton")
toggle2Button.Size = UDim2.new(1, 0, 1, 0)
toggle2Button.BackgroundTransparency = 1
toggle2Button.Text = ""
toggle2Button.Parent = toggle2

local toggle2Circle = Instance.new("Frame")
toggle2Circle.Size = UDim2.new(0, 20, 0, 20)
toggle2Circle.Position = UDim2.new(0, 3, 0.5, -10)
toggle2Circle.BackgroundColor3 = Color3.fromRGB(180, 180, 190)
toggle2Circle.Parent = toggle2

local toggle2CircleCorner = Instance.new("UICorner")
toggle2CircleCorner.CornerRadius = UDim.new(1, 0)
toggle2CircleCorner.Parent = toggle2Circle

-- Theme Change Button
local themeCard = Instance.new("Frame")
themeCard.Size = UDim2.new(1, -10, 0, 60)
themeCard.Position = UDim2.new(0, 5, 0, 210)
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
themeButton.Text = "Change Theme Color"
themeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
themeButton.TextSize = 14
themeButton.Font = Enum.Font.SourceSansBold
themeButton.AutoButtonColor = false
themeButton.Parent = themeCard

local themeButtonCorner = Instance.new("UICorner")
themeButtonCorner.CornerRadius = UDim.new(0, 6)
themeButtonCorner.Parent = themeButton

-- Resize Handle
local resizeHandle = Instance.new("Frame")
resizeHandle.Size = UDim2.new(0, 20, 0, 20)
resizeHandle.Position = UDim2.new(1, -20, 1, -20)
resizeHandle.BackgroundTransparency = 1
resizeHandle.Parent = mainFrame

local resizeIcon = Instance.new("TextLabel")
resizeIcon.Size = UDim2.new(1, 0, 1, 0)
resizeIcon.BackgroundTransparency = 1
resizeIcon.Text = "◢"
resizeIcon.TextColor3 = Color3.fromRGB(60, 60, 70)
resizeIcon.TextSize = 16
resizeIcon.Font = Enum.Font.SourceSans
resizeIcon.Parent = resizeHandle

-- Functions
local function createTween(obj, props, duration)
    local info = TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    return TweenService:Create(obj, info, props)
end

-- Make Frame Draggable
local function makeDraggable(frame, handle)
    local dragStart = nil
    local startPos = nil
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    isDragging = false
                end
            end)
        end
    end)
    
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and isDragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Make Frame Resizable
local function makeResizable(frame, handle)
    local resizeStart = nil
    local startSize = nil
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isResizing = true
            resizeStart = input.Position
            startSize = frame.Size
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    isResizing = false
                end
            end)
        end
    end)
    
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and isResizing then
            local delta = input.Position - resizeStart
            local newWidth = math.max(300, startSize.X.Offset + delta.X)
            local newHeight = math.max(200, startSize.Y.Offset + delta.Y)
            
            frame.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end)
end

makeDraggable(mainFrame, header)
makeResizable(mainFrame, resizeHandle)

-- Auto Walk Function
local function toggleAutoWalk()
    autoWalking = not autoWalking
    
    if autoWalking then
        toggle1.BackgroundColor3 = Color3.fromRGB(130, 180, 255)
        createTween(toggle1Circle, {Position = UDim2.new(1, -23, 0.5, -10)}, 0.2):Play()
        
        spawn(function()
            local startTime = tick()
            while autoWalking and tick() - startTime < 6 do
                humanoid:Move(Vector3.new(0, 0, -1))
                wait()
            end
            humanoid:Move(Vector3.new(0, 0, 0))
            autoWalking = false
            toggle1.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
            createTween(toggle1Circle, {Position = UDim2.new(0, 3, 0.5, -10)}, 0.2):Play()
        end)
    else
        toggle1.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
        createTween(toggle1Circle, {Position = UDim2.new(0, 3, 0.5, -10)}, 0.2):Play()
    end
end

-- Simple Aim Bot Function
local function toggleAimBot()
    aimBotEnabled = not aimBotEnabled
    
    if aimBotEnabled then
        toggle2.BackgroundColor3 = Color3.fromRGB(130, 180, 255)
        createTween(toggle2Circle, {Position = UDim2.new(1, -23, 0.5, -10)}, 0.2):Play()
        
        -- Simple aim bot logic (educational purpose only)
        spawn(function()
            while aimBotEnabled do
                -- This is just a placeholder - real implementation would be more complex
                print("Aim Bot Active (Simulation)")
                wait(0.1)
            end
        end)
    else
        toggle2.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
        createTween(toggle2Circle, {Position = UDim2.new(0, 3, 0.5, -10)}, 0.2):Play()
    end
end

-- Theme Change Function
local function changeTheme()
    local hue = math.random()
    local newColor = Color3.fromHSV(hue, 0.6, 1)
    
    logoIcon.TextColor3 = newColor
    logoStroke.Color = newColor
    title.TextColor3 = newColor
    titleGlow.TextColor3 = newColor
    content.ScrollBarImageColor3 = newColor
    themeButton.BackgroundColor3 = newColor
    
    -- Animate theme change
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
        createTween(mainFrame, {Size = UDim2.new(0, 450, 0, 350)}, 0.4):Play()
    end
end)

minimizeBtn.MouseButton1Click:Connect(function()
    createTween(mainFrame, {Size = UDim2.new(0, 450, 0, 45)}, 0.3):Play()
    content.Visible = false
end)

header.MouseButton1Click:Connect(function()
    if not content.Visible then
        content.Visible = true
        createTween(mainFrame, {Size = UDim2.new(0, 450, 0, 350)}, 0.3):Play()
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    createTween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3):Play()
    wait(0.3)
    mainFrame.Visible = false
    menuOpen = false
end)

toggle1Button.MouseButton1Click:Connect(toggleAutoWalk)
toggle2Button.MouseButton1Click:Connect(toggleAimBot)
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

print("✨ Ultra Menu v3.0 - Loaded Successfully!")
