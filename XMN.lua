-- منوی پیشرفته و حرفه‌ای برای روبلاکس
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- متغیرهای کنترلی
local menuOpen = false
local autoWalking = false

-- ساخت ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ProMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- لوگو (دکمه باز کردن منو)
local logoButton = Instance.new("ImageButton")
logoButton.Name = "LogoButton"
logoButton.Size = UDim2.new(0, 60, 0, 60)
logoButton.Position = UDim2.new(0, 10, 0.5, -30)
logoButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
logoButton.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png" -- می‌تونی آیکون دلخواه بذاری
logoButton.Parent = screenGui

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 15)
logoCorner.Parent = logoButton

local logoStroke = Instance.new("UIStroke")
logoStroke.Color = Color3.fromRGB(100, 200, 255)
logoStroke.Thickness = 2
logoStroke.Parent = logoButton

-- متن روی لوگو
local logoText = Instance.new("TextLabel")
logoText.Size = UDim2.new(1, 0, 1, 0)
logoText.BackgroundTransparency = 1
logoText.Text = "⚡"
logoText.TextColor3 = Color3.fromRGB(100, 200, 255)
logoText.TextScaled = true
logoText.Font = Enum.Font.SourceSansBold
logoText.Parent = logoButton

-- فریم اصلی منو
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

-- سایه برای منو
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 10, 10)
shadow.Parent = mainFrame

-- هدر منو
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 15)
headerCorner.Parent = header

-- عنوان منو
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ Pro Menu v2.0"
title.TextColor3 = Color3.fromRGB(100, 200, 255)
title.TextScaled = false
title.TextSize = 22
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- گرادیانت برای هدر
local headerGradient = Instance.new("UIGradient")
headerGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
}
headerGradient.Rotation = 90
headerGradient.Parent = header

-- دکمه مینیمایز
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 35, 0, 35)
minimizeButton.Position = UDim2.new(1, -80, 0, 7.5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
minimizeButton.Text = "—"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextSize = 20
minimizeButton.Font = Enum.Font.SourceSansBold
minimizeButton.Parent = header

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minimizeButton

-- دکمه بستن
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 35, 0, 35)
closeButton.Position = UDim2.new(1, -40, 0, 7.5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
closeButton.Text = "✖"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 18
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- کانتینر برای محتوا
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, -20, 1, -60)
contentFrame.Position = UDim2.new(0, 10, 0, 55)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.ScrollBarThickness = 4
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 200, 255)
contentFrame.Parent = mainFrame

-- بخش Auto Walk
local autoWalkFrame = Instance.new("Frame")
autoWalkFrame.Name = "AutoWalkSection"
autoWalkFrame.Size = UDim2.new(1, -10, 0, 80)
autoWalkFrame.Position = UDim2.new(0, 0, 0, 10)
autoWalkFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
autoWalkFrame.BorderSizePixel = 0
autoWalkFrame.Parent = contentFrame

local awCorner = Instance.new("UICorner")
awCorner.CornerRadius = UDim.new(0, 10)
awCorner.Parent = autoWalkFrame

-- لیبل Auto Walk
local awLabel = Instance.new("TextLabel")
awLabel.Size = UDim2.new(0.6, 0, 0.5, 0)
awLabel.Position = UDim2.new(0, 15, 0, 5)
awLabel.BackgroundTransparency = 1
awLabel.Text = "🚶 Auto Walk (6s)"
awLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
awLabel.TextSize = 18
awLabel.Font = Enum.Font.SourceSans
awLabel.TextXAlignment = Enum.TextXAlignment.Left
awLabel.Parent = autoWalkFrame

-- توضیحات
local awDesc = Instance.new("TextLabel")
awDesc.Size = UDim2.new(0.6, 0, 0.4, 0)
awDesc.Position = UDim2.new(0, 15, 0.5, 0)
awDesc.BackgroundTransparency = 1
awDesc.Text = "راه رفتن خودکار برای 6 ثانیه"
awDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
awDesc.TextSize = 14
awDesc.Font = Enum.Font.SourceSans
awDesc.TextXAlignment = Enum.TextXAlignment.Left
awDesc.Parent = autoWalkFrame

-- Toggle برای Auto Walk
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 60, 0, 30)
toggleButton.Position = UDim2.new(1, -75, 0.5, -15)
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
toggleButton.Text = ""
toggleButton.Parent = autoWalkFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 15)
toggleCorner.Parent = toggleButton

local toggleCircle = Instance.new("Frame")
toggleCircle.Name = "Circle"
toggleCircle.Size = UDim2.new(0, 24, 0, 24)
toggleCircle.Position = UDim2.new(0, 3, 0.5, -12)
toggleCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
toggleCircle.Parent = toggleButton

local circleCorner = Instance.new("UICorner")
circleCorner.CornerRadius = UDim.new(1, 0)
circleCorner.Parent = toggleCircle

-- بخش تغییر رنگ
local colorFrame = Instance.new("Frame")
colorFrame.Name = "ColorSection"
colorFrame.Size = UDim2.new(1, -10, 0, 80)
colorFrame.Position = UDim2.new(0, 0, 0, 100)
colorFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
colorFrame.BorderSizePixel = 0
colorFrame.Parent = contentFrame

local colorCorner = Instance.new("UICorner")
colorCorner.CornerRadius = UDim.new(0, 10)
colorCorner.Parent = colorFrame

-- دکمه تغییر رنگ
local colorButton = Instance.new("TextButton")
colorButton.Size = UDim2.new(0.9, 0, 0, 40)
colorButton.Position = UDim2.new(0.05, 0, 0.5, -20)
colorButton.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
colorButton.Text = "🎨 تغییر رنگ منو"
colorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
colorButton.TextSize = 16
colorButton.Font = Enum.Font.SourceSansBold
colorButton.Parent = colorFrame

local cbCorner = Instance.new("UICorner")
cbCorner.CornerRadius = UDim.new(0, 8)
cbCorner.Parent = colorButton

-- تابع تغییر رنگ
local function changeColor()
    local hue = math.random()
    local color = Color3.fromHSV(hue, 0.8, 0.9)
    
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    header.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    logoStroke.Color = color
    logoText.TextColor3 = color
    title.TextColor3 = color
    contentFrame.ScrollBarImageColor3 = color
    
    -- انیمیشن
    colorButton.BackgroundColor3 = color
end

-- تابع Auto Walk
local function startAutoWalk()
    if autoWalking then return end
    autoWalking = true
    
    -- انیمیشن Toggle
    toggleButton.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    toggleCircle:TweenPosition(UDim2.new(1, -27, 0.5, -12), "Out", "Quad", 0.3, true)
    
    -- شروع راه رفتن
    spawn(function()
        local startTime = tick()
        while tick() - startTime < 6 and autoWalking do
            humanoid:Move(Vector3.new(0, 0, -1))
            wait()
        end
        
        -- توقف راه رفتن
        humanoid:Move(Vector3.new(0, 0, 0))
        autoWalking = false
        
        -- برگشت Toggle
        toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        toggleCircle:TweenPosition(UDim2.new(0, 3, 0.5, -12), "Out", "Quad", 0.3, true)
    end)
end

-- Event Handlers
logoButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    mainFrame.Visible = menuOpen
    
    if menuOpen then
        -- انیمیشن باز شدن
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        mainFrame:TweenSize(UDim2.new(0, 400, 0, 300), "Out", "Back", 0.3, true)
    end
end)

minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    menuOpen = false
end)

closeButton.MouseButton1Click:Connect(function()
    -- انیمیشن بسته شدن
    mainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Back", 0.3, true, function()
        mainFrame.Visible = false
        menuOpen = false
    end)
end)

toggleButton.MouseButton1Click:Connect(function()
    if not autoWalking then
        startAutoWalk()
    end
end)

colorButton.MouseButton1Click:Connect(changeColor)

-- انیمیشن Hover برای دکمه‌ها
local function addHoverEffect(button)
    local originalColor = button.BackgroundColor3
    
    button.MouseEnter:Connect(function()
        button:TweenSize(UDim2.new(button.Size.X.Scale * 1.05, 0, button.Size.Y.Scale * 1.05, 0), "Out", "Quad", 0.2, true)
    end)
    
    button.MouseLeave:Connect(function()
        button:TweenSize(UDim2.new(button.Size.X.Scale / 1.05, 0, button.Size.Y.Scale / 1.05, 0), "Out", "Quad", 0.2, true)
    end)
end

addHoverEffect(logoButton)
addHoverEffect(colorButton)

print("⚡ Pro Menu v2.0 - Successfully Loaded!")
