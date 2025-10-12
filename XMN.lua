-- LocalScript برای ایجاد یک منوی ساده

local player = game.Players.LocalPlayer
local gui = script.Parent  -- فرض کنیم این اسکریپت داخل ScreenGui هست

-- ایجاد قاب اصلی منو
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.3, 0, 0.4, 0)  -- اندازه قاب (30% عرض، 40% ارتفاع صفحه)
frame.Position = UDim2.new(0.35, 0, 0.3, 0)  -- موقعیت وسط صفحه
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)  -- رنگ پس‌زمینه تیره
frame.BorderSizePixel = 0
frame.Parent = gui

-- عنوان منو
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.2, 0)
title.Text = "منوی ساده"
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Parent = frame

-- دکمه سلام
local button1 = Instance.new("TextButton")
button1.Size = UDim2.new(0.8, 0, 0.2, 0)
button1.Position = UDim2.new(0.1, 0, 0.3, 0)
button1.Text = "سلام!"
button1.TextSize = 20
button1.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
button1.Parent = frame

button1.MouseButton1Click:Connect(function()
    print("سلام! " .. player.Name)  -- در کنسول چاپ می‌کنه
end)

-- دکمه خروج
local button2 = Instance.new("TextButton")
button2.Size = UDim2.new(0.8, 0, 0.2, 0)
button2.Position = UDim2.new(0.1, 0, 0.6, 0)
button2.Text = "خروج"
button2.TextSize = 20
button2.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
button2.Parent = frame

button2.MouseButton1Click:Connect(function()
    frame.Visible = false  -- منو رو مخفی می‌کنه
end)

-- نمایش منو
frame.Visible = true