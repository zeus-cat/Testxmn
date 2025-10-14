-- 🌟 GOD MENU v11.1 FINAL - Mobile & PC Friendly
-- Features: Teleport (Forward/Back), Numeric Input, Free Cam, God Mode
-- Safe, no character break, no crash. Designed for Android & Krnl/Synapse.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
if not player then return warn("Player not found!") end

-- 🔁 Wait for Character with safety
local function waitForCharacter()
    local char = player.Character
    if char and char.Parent then
        local hum = char:FindFirstChild("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if hum and root then
            return char, hum, root
        end
    end
    char = player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    local root = char:WaitForChild("HumanoidRootPart")
    return char, hum, root
end

-- 🧩 Initial References
local character, humanoid, rootPart = pcall(waitForCharacter) and waitForCharacter() or nil, nil, nil

-- 🔁 On respawn, refresh references
player.CharacterAdded:Connect(function(newChar)
    task.wait(0.5) -- اطمینان از تکمیل ایجاد کاراکتر
    character = newChar
    humanoid = newChar:FindFirstChild("Humanoid") or newChar:WaitForChild("Humanoid")
    rootPart = newChar:FindFirstChild("HumanoidRootPart") or newChar:WaitForChild("HumanoidRootPart")
end)

-- 🛠 State Variables
local menuOpen = false
local teleportEnabled = false
local freeCamEnabled = false
local godModeEnabled = false
local teleportDistance = 10
local originalParent = workspace -- پیش‌فرض
local cameraCFrame = nil

-- 🖼 GUI: ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GodMenuFinal"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- 🔘 دکمه اصلی: MENU (پایین سمت چپ - مناسب موبایل)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleMenu"
toggleBtn.Size = UDim2.fromOffset(70, 40)
toggleBtn.Position = UDim2.fromOffset(10, 500) -- مناسب اندروید
toggleBtn.Text = "MENU"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 14
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
toggleBtn.BorderSizePixel = 0
toggleBtn.ZIndex = 2
toggleBtn.Parent = screenGui

-- گرد کردن دکمه
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = toggleBtn

-- حاشیه آبی روشن
local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(130, 180, 255)
btnStroke.Thickness = 2
btnStroke.Parent = toggleBtn

-- 🎯 پنل تلپورت (پایین صفحه)
local tpPanel = Instance.new("Frame")
tpPanel.Name = "TeleportPanel"
tpPanel.Size = UDim2.fromOffset(240, 140)
tpPanel.Position = UDim2.fromScale(0.5, 0.75)
tpPanel.AnchorPoint = Vector2.new(0.5, 0.5)
tpPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
tpPanel.BorderSizePixel = 0
tpPanel.Visible = false
tpPanel.ZIndex = 2
tpPanel.Parent = screenGui

-- گوشه‌های گرد پنل
local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 10)
panelCorner.Parent = tpPanel

-- حاشیه پنل
local panelStroke = Instance.new("UIStroke")
panelStroke.Color = Color3.fromRGB(130, 180, 255)
panelStroke.Thickness = 2
panelStroke.Parent = tpPanel

-- 📏 کادر ورودی فاصله
local inputFrame = Instance.new("Frame")
inputFrame.Size = UDim2.new(0.85, 0, 0, 35)
inputFrame.Position = UDim2.fromOffset(18, 15)
inputFrame.BackgroundTransparency = 1
inputFrame.Parent = tpPanel

local distanceInput = Instance.new("TextBox")
distanceInput.Size = UDim2.new(1, 0, 1, 0)
distanceInput.BackgroundTransparency = 0.7
distanceInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
distanceInput.TextColor3 = Color3.fromRGB(255, 255, 255)
distanceInput.TextSize = 16
distanceInput.Font = Enum.Font.SourceSans
distanceInput.PlaceholderText = "مثلاً 10، 16، 100"
distanceInput.Text = "10"
distanceInput.ClearTextOnFocus = true
distanceInput.Parent = inputFrame

-- دکمه‌های تلپورت
local btnForward = Instance.new("TextButton")
btnForward.Size = UDim2.new(0.4, 0, 0.3, 0)
btnForward.Position = UDim2.new(0.08, 0, 0.52, 0)
btnForward.Text = "⬆ جلو"
btnForward.TextColor3 = Color3.fromRGB(130, 180, 255)
btnForward.TextSize = 16
btnForward.Font = Enum.Font.SourceSansBold
btnForward.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
btnForward.Parent = tpPanel

local btnBackward = Instance.new("TextButton")
btnBackward.Size = UDim2.new(0.4, 0, 0.3, 0)
btnBackward.Position = UDim2.new(0.52, 0, 0.52, 0)
btnBackward.Text = "⬇ عقب"
btnBackward.TextColor3 = Color3.fromRGB(255, 100, 100)
btnBackward.TextSize = 16
btnBackward.Font = Enum.Font.SourceSansBold
btnBackward.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
btnBackward.Parent = tpPanel

-- گرد کردن دکمه‌ها
for _, btn in ipairs({btnForward, btnBackward}) do
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    -- افکت هاور
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    end)
end

-- 🚀 تابع تلپورت (جلو/عقب)
local function teleport(direction)
    if not character or not rootPart or not rootPart.Parent then return end
    if not character.Parent then return end

    local cf = rootPart.CFrame
    local look = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z)
    if look.Magnitude < 0.01 then look = Vector3.new(0, 0, -1) else look = look.Unit end

    local offset = direction == "forward" and look * teleportDistance or -look * teleportDistance
    local target = cf + offset

    pcall(function()
        rootPart.CFrame = target
        rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    end)
end

-- 👁️ Free Cam (بدون خراب کردن کاراکتر)
local function toggleFreeCam()
    freeCamEnabled = not freeCamEnabled

    if freeCamEnabled then
        -- ذخیره موقعیت دوربین
        cameraCFrame = Workspace.CurrentCamera.CFrame
        originalParent = character.Parent

        -- مخفی کردن کاراکتر
        character:MoveTo(Vector3.new(0, 9999, 0))
        task.delay(0.1, function()
            if character and not freeCamEnabled then return end
            pcall(function() character.Parent = nil end)
        end)

        -- فعال کردن دوربین آزاد
        RunService:BindToRenderStep("FreeCam", Enum.RenderPriority.Camera.Value + 1, function()
            local move = Vector3.new(0, 0, 0)
            local speed = 16

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + Workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - Workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - Workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end

            if move.Magnitude > 0 then
                cameraCFrame = cameraCFrame + move.Unit * speed
                Workspace.CurrentCamera.CFrame = cameraCFrame
            end
        end)

        toggleBtn.Text = "👁️"
    else
        RunService:UnbindFromRenderStep("FreeCam")
        if character and originalParent then
            pcall(function() character.Parent = originalParent end)
        end
        cameraCFrame = nil
        toggleBtn.Text = menuOpen and "❌" or "MENU"
    end
end

-- 🛡️ God Mode (نامیرایی)
local function toggleGodMode()
    godModeEnabled = not godModeEnabled
    if godModeEnabled and humanoid then
        humanoid.HealthChanged:Connect(function()
            task.spawn(function()
                task.wait(0.05)
                if humanoid and humanoid.Health < humanoid.MaxHealth then
                    humanoid.Health = humanoid.MaxHealth
                end
            end)
        end)
    end
    toggleBtn.Text = godModeEnabled and "🛡️" or (menuOpen and "❌" or "MENU")
    task.wait(1)
    if not menuOpen and not godModeEnabled and not freeCamEnabled then
        toggleBtn.Text = "MENU"
    end
end

-- 🔘 مدیریت کلیک روی دکمه MENU
local clickTime = tick()
toggleBtn.MouseButton1Click:Connect(function()
    local now = tick()
    if now - clickTime < 0.3 then
        -- دو کلیک سریع: God Mode
        toggleGodMode()
    else
        -- کلیک معمولی: باز/بسته کردن منو
        menuOpen = not menuOpen
        teleportEnabled = menuOpen
        tpPanel.Visible = menuOpen
        if menuOpen then
            toggleBtn.Text = "❌"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
        else
            toggleBtn.Text = freeCamEnabled and "👁️" or godModeEnabled and "🛡️" or "MENU"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        end
    end
    clickTime = now
end)

-- 🎯 دکمه‌های تلپورت
btnForward.MouseButton1Click:Connect(function()
    teleport("forward")
end)

btnBackward.MouseButton1Click:Connect(function()
    teleport("backward")
end)

-- 📥 ورودی فاصله
distanceInput.FocusLost:Connect(function(enterPressed)
    if not enterPressed then return end
    local num = tonumber(distanceInput.Text)
    if num and num > 0 and num <= 10000 then
        teleportDistance = math.floor(num)
    else
        distanceInput.Text = tostring(teleportDistance)
    end
end)

-- ✅ پیام پایانی
print("✅ GOD MENU v11.1 FINAL بارگذاری شد")
print("🔹 دکمه 'MENU' رو بزن تا تلپورت فعال بشه")
print("🔹 دوبار زدن: God Mode | سه بار: Free Cam")
print("🔹 فاصله رو در کادر تنظیم کن (مثلاً 16)")
