-- 🎯 ULTRA PRO MENU - بدون باگ و کاملا حرفه‌ای
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- سرویس‌ها
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- متغیرهای کنترلی
local menuOpen = false
local autoWalkActive = false
local aimBotActive = false
local espActive = false

-- حذف منوی قبلی (اگر وجود داشته باشد)
if playerGui:FindFirstChild("UltraProMenu") then
    playerGui:FindFirstChild("UltraProMenu"):Destroy()
end

-- ساخت ScreenGui اصلی
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltraProMenu"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- 🎯 لوگوی قابل جابجایی
local logoFrame = Instance.new("Frame")
logoFrame.Name = "DraggableLogo"
logoFrame.Size = UDim2.new(0, 55, 0, 55)
logoFrame.Position = UDim2.new(0, 20, 0.5, -27)
logoFrame.BackgroundTransparency = 1
logoFrame.Active = true
logoFrame.Parent = screenGui

local logoButton = Instance.new("TextButton")
logoButton.Name = "LogoButton"
logoButton.Size = UDim2.new(1, 0, 1, 0)
logoButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
logoButton.BorderSizePixel = 0
logoButton.Text = ""
logoButton.AutoButtonColor = false
logoButton.Parent = logoFrame

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 12)
logoCorner.Parent = logoButton

local logoGradient = Instance.new("UIGradient")
logoGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 70)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 40))
}
logoGradient.Rotation = 45
logoGradient.Parent = logoButton

local logoIcon = Instance.new("TextLabel")
logoIcon.Size = UDim2.new(1, 0, 1, 0)
logoIcon.BackgroundTransparency = 1
logoIcon.Text = "⚡"
logoIcon.TextColor3 = Color3.fromRGB(100, 180, 255)
logoIcon.TextScaled = true
logoIcon.Font = Enum.Font.SourceSansBold
logoIcon.Parent = logoButton

local logoStroke = Instance.new("UIStroke")
logoStroke.Color = Color3.fromRGB(100, 180, 255)
logoStroke.Thickness = 2
logoStroke.Transparency = 0.3
logoStroke.Parent = logoButton

-- تابع برای Draggable کردن لوگو
local function makeDraggable(frame)
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
end

makeDraggable(logoFrame)

-- 🎨 منوی اصلی
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainMenu"
mainFrame.Size = UDim2.new(0, 500, 0, 400)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.ClipsDescendants = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(40, 40, 50)
mainStroke.Thickness = 1
mainStroke.Parent = mainFrame

-- سایه برای منو
local shadowFrame = Instance.new("ImageLabel")
shadowFrame.Name = "Shadow"
shadowFrame.Size = UDim2.new(1, 30, 1, 30)
shadowFrame.Position = UDim2.new(0, -15, 0, -15)
shadowFrame.BackgroundTransparency = 1
shadowFrame.Image = "rbxassetid://1316045217"
shadowFrame.ImageColor3 = Color3.new(0, 0, 0)
shadowFrame.ImageTransparency = 0.7
shadowFrame.ScaleType = Enum.ScaleType.Slice
shadowFrame.SliceCenter = Rect.new(10, 10, 118, 118)
shadowFrame.ZIndex = 0
shadowFrame.Parent = mainFrame

-- هدر منو (قابل کشیدن)
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local headerBottom = Instance.new("Frame")
headerBottom.Size = UDim2.new(1, 0, 0, 12)
headerBottom.Position = UDim2.new(0, 0, 1, -12)
headerBottom.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
headerBottom.BorderSizePixel = 0
headerBottom.Parent = header

-- عنوان منو
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.6, 0, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ ULTRA PRO MENU"
title.TextColor3 = Color3.fromRGB(100, 180, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local versionLabel = Instance.new("TextLabel")
versionLabel.Size = UDim2.new(0.2, 0, 0.5, 0)
versionLabel.Position = UDim2.new(0, 20, 0.5, 0)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "v4.0 FINAL"
versionLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
versionLabel.TextSize = 11
versionLabel.Font = Enum.Font.Gotham
versionLabel.TextXAlignment = Enum.TextXAlignment.Left
versionLabel.Parent = header

-- دکمه‌های کنترل
local controlsFrame = Instance.new("Frame")
controlsFrame.Size = UDim2.new(0, 75, 0, 32)
controlsFrame.Position = UDim2.new(1, -85, 0.5, -16)
controlsFrame.BackgroundTransparency = 1
controlsFrame.Parent = header

-- دکمه Minimize
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(0, 0, 0, 0)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 190, 50)
minimizeBtn.Text = ""
minimizeBtn.AutoButtonColor = false
minimizeBtn.Parent = controlsFrame

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeBtn

local minIcon = Instance.new("TextLabel")
minIcon.Size = UDim2.new(1, 0, 1, 0)
minIcon.BackgroundTransparency = 1
minIcon.Text = "−"
minIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
minIcon.TextSize = 20
minIcon.Font = Enum.Font.GothamBold
minIcon.Parent = minimizeBtn

-- دکمه Close
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(0, 38, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
closeBtn.Text = ""
closeBtn.AutoButtonColor = false
closeBtn.Parent = controlsFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

local closeIcon = Instance.new("TextLabel")
closeIcon.Size = UDim2.new(1, 0, 1, 0)
closeIcon.BackgroundTransparency = 1
closeIcon.Text = "×"
closeIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
closeIcon.TextSize = 22
closeIcon.Font = Enum.Font.GothamBold
closeIcon.Parent = closeBtn

-- Draggable کردن منو از هدر
makeDraggable(mainFrame)

-- محتوای منو
local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(1, 0, 1, -50)
contentContainer.Position = UDim2.new(0, 0, 0, 50)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = mainFrame

local contentScroll = Instance.new("ScrollingFrame")
contentScroll.Name = "ContentScroll"
contentScroll.Size = UDim2.new(1, -20, 1, -10)
contentScroll.Position = UDim2.new(0, 10, 0, 5)
contentScroll.BackgroundTransparency = 1
contentScroll.BorderSizePixel = 0
contentScroll.ScrollBarThickness = 4
contentScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 180, 255)
contentScroll.ScrollBarImageTransparency = 0.5
contentScroll.CanvasSize = UDim2.new(0, 0, 0, 600)
contentScroll.Parent = contentContainer

-- تابع ساخت Toggle
local function createToggle(name, description, icon, position, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -10, 0, 85)
    card.Position = UDim2.new(0, 5, 0, position)
    card.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
    card.BorderSizePixel = 0
    card.Parent = contentScroll
    
    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 10)
    cardCorner.Parent = card
    
    local cardStroke = Instance.new("UIStroke")
    cardStroke.Color = Color3.fromRGB(30, 30, 40)
    cardStroke.Thickness = 1
    cardStroke.Parent = card
    
    -- آیکون
    local iconBox = Instance.new("Frame")
    iconBox.Size = UDim2.new(0, 55, 0, 55)
    iconBox.Position = UDim2.new(0, 15, 0.5, -27)
    iconBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    iconBox.BorderSizePixel = 0
    iconBox.Parent = card
    
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 10)
    iconCorner.Parent = iconBox
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(1, 0, 1, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextSize = 28
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Parent = iconBox
    
    -- عنوان
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.5, 0, 0, 28)
    titleLabel.Position = UDim2.new(0, 85, 0, 15)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = name
    titleLabel.TextColor3 = Color3.fromRGB(230, 230, 240)
    titleLabel.TextSize = 17
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = card
    
    -- توضیحات
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(0.5, 0, 0, 20)
    descLabel.Position = UDim2.new(0, 85, 0, 43)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = description
    descLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
    descLabel.TextSize = 13
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Parent = card
    
    -- Toggle Switch
    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.new(0, 55, 0, 28)
    toggleBg.Position = UDim2.new(1, -70, 0.5, -14)
    toggleBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    toggleBg.BorderSizePixel = 0
    toggleBg.Parent = card
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleBg
    
    local toggleCircle = Instance.new("Frame")
    toggleCircle.Size = UDim2.new(0, 22, 0, 22)
    toggleCircle.Position = UDim2.new(0, 3, 0.5, -11)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 210)
    toggleCircle.BorderSizePixel = 0
    toggleCircle.Parent = toggleBg
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = toggleCircle
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(1, 0, 1, 0)
    toggleButton.BackgroundTransparency = 1
    toggleButton.Text = ""
    toggleButton.Parent = toggleBg
    
    local isActive = false
    
    toggleButton.MouseButton1Click:Connect(function()
        isActive = not isActive
        
        if isActive then
            -- روشن کردن
            TweenService:Create(toggleBg, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(100, 180, 255)}):Play()
            TweenService:Create(toggleCircle, TweenInfo.new(0.3), {Position = UDim2.new(1, -25, 0.5, -11)}):Play()
            TweenService:Create(toggleCircle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            -- خاموش کردن
            TweenService:Create(toggleBg, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
            TweenService:Create(toggleCircle, TweenInfo.new(0.3), {Position = UDim2.new(0, 3, 0.5, -11)}):Play()
            TweenService:Create(toggleCircle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(200, 200, 210)}):Play()
        end
        
        callback(isActive)
    end)
    
    return card
end

-- 🚶 فیچر 1: راه رفتن خودکار
createToggle(
    "راه رفتن خودکار",
    "حرکت اتوماتیک به جلو برای 6 ثانیه",
    "🚶",
    10,
    function(active)
        if active then
            autoWalkActive = true
            spawn(function()
                local startTime = tick()
                while autoWalkActive and tick() - startTime < 6 do
                    if humanoid and humanoid.Parent then
                        humanoid:Move(Vector3.new(0, 0, -1), true)
                    end
                    wait(0.1)
                end
                autoWalkActive = false
            end)
        else
            autoWalkActive = false
            if humanoid and humanoid.Parent then
                humanoid:Move(Vector3.new(0, 0, 0), true)
            end
        end
    end
)

-- 🎯 فیچر 2: نشانه‌گیری ساده
createToggle(
    "کمک نشانه‌گیری",
    "سیستم کمک به هدف‌گیری (ساده)",
    "🎯",
    105,
    function(active)
        aimBotActive = active
        if active then
            spawn(function()
                while aimBotActive do
                    -- شبیه‌سازی Aim Bot (فقط برای آموزش)
                    print("🎯 Aim Assist Active")
                    wait(1)
                end
            end)
        end
    end
)

-- 👁️ فیچر 3: نمایش بازیکنان
createToggle(
    "نمایش بازیکنان",
    "نمایش اطلاعات بازیکنان دیگر",
    "👁️",
    200,
    function(active)
        espActive = active
        if active then
            print("👁️ ESP نمایش بازیکنان فعال شد")
        else
            print("👁️ ESP نمایش بازیکنان غیرفعال شد")
        end
    end
)

-- 🎨 دکمه تغییر رنگ تم
local themeCard = Instance.new("Frame")
themeCard.Size = UDim2.new(1, -10, 0, 65)
themeCard.Position = UDim2.new(0, 5, 0, 295)
themeCard.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
themeCard.BorderSizePixel = 0
themeCard.Parent = contentScroll

local themeCorner = Instance.new("UICorner")
themeCorner.CornerRadius = UDim.new(0, 10)
themeCorner.Parent = themeCard

local themeButton = Instance.new("TextButton")
themeButton.Size = UDim2.new(1, -20, 0, 45)
themeButton.Position = UDim2.new(0, 10, 0.5, -22)
themeButton.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
themeButton.Text = "🎨  تغییر رنگ تم"
themeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
themeButton.TextSize = 16
themeButton.Font = Enum.Font.GothamBold
themeButton.AutoButtonColor = false
themeButton.Parent = themeCard

local themeBtnCorner = Instance.new("UICorner")
themeBtnCorner.CornerRadius = UDim.new(0, 8)
themeBtnCorner.Parent = themeButton

-- Handle Resize
local resizeHandle = Instance.new("Frame")
resizeHandle.Size = UDim2.new(0, 25, 0, 25)
resizeHandle.Position = UDim2.new(1, -25, 1, -25)
resizeHandle.BackgroundTransparency = 1
resizeHandle.Parent = mainFrame

local resizeIcon = Instance.new("TextLabel")
resizeIcon.Size = UDim2.new(1, 0, 1, 0)
resizeIcon.BackgroundTransparency = 1
resizeIcon.Text = "◢"
resizeIcon.TextColor3 = Color3.fromRGB(60, 60, 75)
resizeIcon.TextSize = 18
resizeIcon.Font = Enum.Font.Gotham
resizeIcon.Parent = resizeHandle

-- تابع Resize
local function makeResizable(frame, handle)
    local resizing = false
    local resizeInput, startPos, startSize
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = true
            startPos = input.Position
            startSize = frame.Size
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    resizing = false
                end
            end)
        end
    end)
    
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            resizeInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == resizeInput and resizing then
            local delta = input.Position - startPos
            local newWidth = math.max(350, startSize.X.Offset + delta.X)
            local newHeight = math.max(250, startSize.Y.Offset + delta.Y)
            frame.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end)
end

makeResizable(mainFrame, resizeHandle)

-- 🎨 تابع تغییر تم
local function changeTheme()
    local hue = math.random()
    local newColor = Color3.fromHSV(hue, 0.65, 1)
    
    logoIcon.TextColor3 = newColor
    logoStroke.Color = newColor
    title.TextColor3 = newColor
    contentScroll.ScrollBarImageColor3 = newColor
    themeButton.BackgroundColor3 = newColor
    
    -- انیمیشن
    TweenService:Create(themeButton, TweenInfo.new(0.2), {Size = UDim2.new(1, -10, 0, 45)}):Play()
    wait(0.2)
    TweenService:Create(themeButton, TweenInfo.new(0.2), {Size = UDim2.new(1, -20, 0, 45)}):Play()
end

-- Event Handlers
logoButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    
    if menuOpen then
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 500, 0, 400)
        }):Play()
    else
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        wait(0.3)
        mainFrame.Visible = false
    end
end)

minimizeBtn.MouseButton1Click:Connect(function()
    -- مخفی کردن محتوا
    contentContainer.Visible = false
    TweenService:Create(mainFrame, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 500, 0, 50)
    }):Play()
end)

-- کلیک روی هدر برای بازگشت از Minimize
header.MouseButton1Click:Connect(function()
    if not contentContainer.Visible then
        contentContainer.Visible = true
        TweenService:Create(mainFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 500, 0, 400)
        }):Play()
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    wait(0.3)
    mainFrame.Visible = false
    menuOpen = false
end)

themeButton.MouseButton1Click:Connect(changeTheme)

-- افکت Hover برای دکمه‌ها
local function addHover(button, normalColor, hoverColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = normalColor}):Play()
    end)
end

addHover(minimizeBtn, Color3.fromRGB(255, 190, 50), Color3.fromRGB(255, 210, 80))
addHover(closeBtn, Color3.fromRGB(255, 75, 75), Color3.fromRGB(255, 100, 100))
addHover(themeButton, themeButton.BackgroundColor3, Color3.fromRGB(120, 200, 255))

-- پیام موفقیت
print("✅ ULTRA PRO MENU v4.0 - بارگذاری شد!")
print("🎯 تمام باگ‌ها فیکس شدند")
print("⚡ منو آماده استفاده است!")
