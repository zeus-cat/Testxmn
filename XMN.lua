-- 🌟 GOD MENU v11.0 - Mobile Friendly | Teleport + Free Cam + God Mode
-- Optimized for Android & PC. Simple UI, no bugs, full control.
-- Use in private games only.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- ⚙️ References
local function waitForCharacter()
    local char = player.Character or player.CharacterAdded:Wait()
    return char, char:WaitForChild("Humanoid"), char:WaitForChild("HumanoidRootPart")
end

local character, humanoid, rootPart = waitForCharacter()

-- 🔁 Refresh on respawn
player.CharacterAdded:Connect(function(newChar)
    character, humanoid, rootPart = newChar, newChar:WaitForChild("Humanoid"), newChar:WaitForChild("HumanoidRootPart")
end)

-- 🛠 State
local menuOpen = false
local teleportEnabled = false
local freeCamEnabled = false
local godModeEnabled = false
local teleportDistance = 10
local originalParent = nil
local cameraCFrame = nil

-- 🖼 GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- 🔘 Toggle Button (Fixed Position - Bottom Left)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.fromOffset(60, 30)
toggleBtn.Position = UDim2.fromOffset(10, 500) -- پایین صفحه (برای موبایل)
toggleBtn.Text = "MENU"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
toggleBtn.BorderSizePixel = 0
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.Parent = screenGui

-- 🎯 Teleport Panel (Always visible when active)
local tpPanel = Instance.new("Frame")
tpPanel.Size = UDim2.fromOffset(200, 120)
tpPanel.Position = UDim2.fromScale(0.5, 0.7)
tpPanel.AnchorPoint = Vector2.new(0.5, 0.5)
tpPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
tpPanel.BorderSizePixel = 0
tpPanel.Visible = false
tpPanel.Parent = screenGui

-- Corner & Stroke
for _, obj in ipairs({toggleBtn, tpPanel}) do
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = obj

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(130, 180, 255)
    stroke.Thickness = 1.5
    stroke.Transparency = 0.4
    stroke.Parent = obj
end

-- 📏 Distance Input
local distFrame = Instance.new("Frame")
distFrame.Size = UDim2.new(0.9, 0, 0, 30)
distFrame.Position = UDim2.fromOffset(10, 10)
distFrame.BackgroundTransparency = 1
distFrame.Parent = tpPanel

local input = Instance.new("TextBox")
input.Size = UDim2.new(1, 0, 1, 0)
input.Position = UDim2.fromScale(0, 0)
input.BackgroundTransparency = 1
input.TextColor3 = Color3.fromRGB(255, 255, 255)
input.PlaceholderText = "Distance (e.g. 10)"
input.Text = "10"
input.Font = Enum.Font.SourceSans
input.TextSize = 14
input.ClearTextOnFocus = false
input.Parent = distFrame

input.FocusLost:Connect(function(enterPressed)
    if not enterPressed then return end
    local num = tonumber(input.Text)
    if num and num > 0 and num <= 1000 then
        teleportDistance = num
    else
        input.Text = tostring(teleportDistance)
    end
end)

-- ⬆️⬇️ Teleport Buttons
local btnForward = Instance.new("TextButton")
btnForward.Size = UDim2.new(0.4, 0, 0.3, 0)
btnForward.Position = UDim2.new(0.05, 0, 0.5, 0)
btnForward.Text = "⬆ جلو"
btnForward.TextColor3 = Color3.fromRGB(130, 180, 255)
btnForward.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
btnForward.Font = Enum.Font.SourceSansBold
btnForward.Parent = tpPanel

local btnBackward = Instance.new("TextButton")
btnBackward.Size = UDim2.new(0.4, 0, 0.3, 0)
btnBackward.Position = UDim2.new(0.55, 0, 0.5, 0)
btnBackward.Text = "⬇ عقب"
btnBackward.TextColor3 = Color3.fromRGB(255, 100, 100)
btnBackward.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
btnBackward.Font = Enum.Font.SourceSansBold
btnBackward.Parent = tpPanel

-- 🌀 Hover Effects
for _, btn in ipairs({btnForward, btnBackward}) do
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    end)
end

-- 🚀 Teleport Function
local function teleport(direction)
    if not rootPart then return end

    local cf = rootPart.CFrame
    local look = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z).Unit
    if look.Magnitude < 0.1 then look = Vector3.new(0, 0, -1) end

    local offset = direction == "forward" and look * teleportDistance or -look * teleportDistance
    local target = cf + offset

    pcall(function()
        rootPart.CFrame = target
        rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    end)
end

-- 👁 Free Cam
local function toggleFreeCam()
    freeCamEnabled = not freeCamEnabled

    if freeCamEnabled then
        if not cameraCFrame then cameraCFrame = workspace.CurrentCamera.CFrame end
        originalParent = rootPart.Parent
        rootPart.Anchored = true
        character:MoveTo(Vector3.new(0, 9999, 0)) -- Move far away
        task.delay(0.1, function() character.Parent = nil end)

        RunService:BindToRenderStep("FreeCam", Enum.RenderPriority.Camera.Value, function()
            local move = Vector3.new(0, 0, 0)
            local speed = 10

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
        RunService:UnbindFromRenderStep("FreeCam")
        if character and originalParent then
            character.Parent = originalParent
            rootPart.Anchored = false
        end
        cameraCFrame = nil
    end
end

-- 🛡 God Mode
local function toggleGodMode()
    godModeEnabled = not godModeEnabled
    if godModeEnabled then
        humanoid.HealthChanged:Connect(function()
            if humanoid.Health < humanoid.MaxHealth then
                humanoid.Health = humanoid.MaxHealth
            end
        end)
    end
    return godModeEnabled
end

-- 🔘 Menu Toggle
toggleBtn.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    teleportEnabled = menuOpen
    tpPanel.Visible = menuOpen

    if menuOpen then
        toggleBtn.Text = "❌"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    else
        toggleBtn.Text = "MENU"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    end
end)

-- 🎯 Teleport Buttons
btnForward.MouseButton1Click:Connect(function()
    teleport("forward")
end)

btnBackward.MouseButton1Click:Connect(function()
    teleport("backward")
end)

-- 🔥 Quick Feature Toggles (Tap on Toggle Button multiple times)
local clickCount = 0
toggleBtn.MouseButton1Click:Connect(function()
    clickCount = clickCount + 1
    if not menuOpen then
        if clickCount % 3 == 1 then
            toggleGodMode()
            toggleBtn.Text = godModeEnabled and "🛡️" or "MENU"
            task.wait(1)
            if not menuOpen then toggleBtn.Text = "MENU" end
        elseif clickCount % 3 == 2 then
            toggleFreeCam()
            toggleBtn.Text = freeCamEnabled and "👁️" or "MENU"
            task.wait(1)
            if not menuOpen then toggleBtn.Text = "MENU" end
        end
    end
end)

-- ✅ Loaded
print("✅ GOD MENU v11.0 loaded (Mobile Ready)")
print("🔹 Tap 'MENU' to open teleport panel")
print("🔹 Double-tap: God Mode | Triple-tap: Free Cam")
print("🔹 Use distance box to set 4x, 8x, 16x, etc.")
