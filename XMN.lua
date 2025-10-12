-- منوی رنگی رندوم برای روبلاکس
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ساخت ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RainbowMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- فریم اصلی منو
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- قابلیت جابجایی منو
mainFrame.Parent = screenGui

-- گوشه‌های گرد برای منو
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

-- عنوان منو
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleLabel.BorderSizePixel = 0
titleLabel.Text = "🌈 Rainbow Menu"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = mainFrame

-- گوشه گرد برای عنوان
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleLabel

-- دکمه تغییر رنگ
local colorButton = Instance.new("TextButton")
colorButton.Name = "ColorButton"
colorButton.Size = UDim2.new(0, 200, 0, 50)
colorButton.Position = UDim2.new(0.5, -100, 0.5, -10)
colorButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
colorButton.BorderSizePixel = 0
colorButton.Text = "🎨 تغییر رنگ"
colorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
colorButton.TextScaled = true
colorButton.Font = Enum.Font.SourceSansBold
colorButton.Parent = mainFrame

-- گوشه گرد برای دکمه
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = colorButton

-- افکت هاور برای دکمه
local buttonStroke = Instance.new("UIStroke")
buttonStroke.Color = Color3.fromRGB(255, 255, 255)
buttonStroke.Thickness = 0
buttonStroke.Transparency = 0.7
buttonStroke.Parent = colorButton

-- تابع تولید رنگ رندوم
local function getRandomColor()
    return Color3.fromRGB(
        math.random(50, 255),
        math.random(50, 255),
        math.random(50, 255)
    )
end

-- انیمیشن برای دکمه
colorButton.MouseEnter:Connect(function()
    buttonStroke.Thickness = 2
    colorButton.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
end)

colorButton.MouseLeave:Connect(function()
    buttonStroke.Thickness = 0
    colorButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
end)

-- عملکرد دکمه تغییر رنگ
colorButton.MouseButton1Click:Connect(function()
    -- تغییر رنگ فریم اصلی
    local newColor = getRandomColor()
    mainFrame.BackgroundColor3 = newColor
    
    -- انیمیشن کلیک
    colorButton.Size = UDim2.new(0, 190, 0, 45)
    wait(0.1)
    colorButton.Size = UDim2.new(0, 200, 0, 50)
    
    -- افکت رنگین کمان برای عنوان
    spawn(function()
        for i = 1, 10 do
            titleLabel.TextColor3 = getRandomColor()
            wait(0.05)
        end
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
end)

-- دکمه بستن منو (X)
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
closeButton.BorderSizePixel = 0
closeButton.Text = "✖"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

print("🌈 منو با موفقیت لود شد!")
