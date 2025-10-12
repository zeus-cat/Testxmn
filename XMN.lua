-- Nightfall UI - Clean, Dark, Draggable, Resizable, No-lag
-- Author: You + Assistant
-- Place as a LocalScript in StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Helpers
local function safeWaitForHumanoid()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid")
    return character, humanoid
end

local function clamp(n, min, max)
    if n < min then return min end
    if n > max then return max end
    return n
end

-- Theme
local primaryColor = Color3.fromRGB(120, 180, 255) -- تغییرپذیر
local bgColor = Color3.fromRGB(18, 18, 22)
local cardColor = Color3.fromRGB(24, 24, 29)
local headerColorA = Color3.fromRGB(28, 32, 40)
local headerColorB = Color3.fromRGB(20, 22, 28)
local strokeColor = Color3.fromRGB(35, 40, 50)
local accentSoft = Color3.fromRGB(160, 200, 255)

-- Root ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NightfallUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 10
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Dock Logo (opens/closes menu)
local dock = Instance.new("ImageButton")
dock.Name = "DockLogo"
dock.AnchorPoint = Vector2.new(0, 0.5)
dock.Size = UDim2.new(0, 56, 0, 56)
dock.Position = UDim2.new(0, 14, 0.5, 0)
dock.BackgroundTransparency = 0.1
dock.Image = "rbxasset://textures/ui/TopBar/iconBase.png" -- Placeholder؛ می‌تونی آیکون دلخواه بدی
dock.ScaleType = Enum.ScaleType.Fit
dock.AutoButtonColor = false
dock.Parent = screenGui

local dockCorner = Instance.new("UICorner", dock)
dockCorner.CornerRadius = UDim.new(0, 14)

local dockStroke = Instance.new("UIStroke", dock)
dockStroke.Color = primaryColor
dockStroke.Thickness = 2
dockStroke.Transparency = 0.2

local dockGradient = Instance.new("UIGradient", dock)
dockGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, headerColorA),
    ColorSequenceKeypoint.new(1, headerColorB)
}
dockGradient.Rotation = 90

-- Window
local window = Instance.new("Frame")
window.Name = "Window"
window.Size = UDim2.new(0, 460, 0, 300)
window.Position = UDim2.new(0.5, -230, 0.5, -150)
window.BackgroundColor3 = cardColor
window.BorderSizePixel = 0
window.Active = true
window.Parent = screenGui

local windowCorner = Instance.new("UICorner", window)
windowCorner.CornerRadius = UDim.new(0, 14)

local windowStroke = Instance.new("UIStroke", window)
windowStroke.Color = strokeColor
windowStroke.Thickness = 1
windowStroke.Transparency = 0

-- Subtle background pattern (optional visual)
local pattern = Instance.new("ImageLabel")
pattern.Name = "Pattern"
pattern.BackgroundTransparency = 1
pattern.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png" -- جایگزین کن با تکسچر دلخواه
pattern.ImageTransparency = 0.9
pattern.ScaleType = Enum.ScaleType.Tile
pattern.TileSize = UDim2.new(0, 128, 0, 128)
pattern.Size = UDim2.new(1, 0, 1, 0)
pattern.Parent = window

-- Header (drag handle)
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = headerColorA
header.BorderSizePixel = 0
header.Parent = window

local headerCorner = Instance.new("UICorner", header)
headerCorner.CornerRadius = UDim.new(0, 14)

local headerGradient = Instance.new("UIGradient", header)
headerGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, headerColorA),
    ColorSequenceKeypoint.new(1, headerColorB)
}
headerGradient.Rotation = 90

local headerStroke = Instance.new("UIStroke", header)
headerStroke.Color = strokeColor
headerStroke.Thickness = 1
headerStroke.Transparency = 0

-- Header icon
local headIcon = Instance.new("ImageLabel")
headIcon.BackgroundTransparency = 1
headIcon.Image = "rbxasset://textures/ui/TopBar/iconBase.png"
headIcon.ImageColor3 = accentSoft
headIcon.Size = UDim2.new(0, 22, 0, 22)
headIcon.Position = UDim2.new(0, 16, 0.5, -11)
headIcon.Parent = header

-- Title
local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Text = "Nightfall Menu"
title.Font = Enum.Font.GothamSemibold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(220, 230, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Size = UDim2.new(1, -160, 1, 0)
title.Position = UDim2.new(0, 46, 0, 0)
title.Parent = header

-- Header buttons (minimize, close)
local btnMin = Instance.new("TextButton")
btnMin.Name = "Minimize"
btnMin.Size = UDim2.new(0, 34, 0, 34)
btnMin.Position = UDim2.new(1, -86, 0.5, -17)
btnMin.BackgroundColor3 = Color3.fromRGB(255, 185, 55)
btnMin.Text = "—"
btnMin.Font = Enum.Font.GothamBold
btnMin.TextSize = 18
btnMin.TextColor3 = Color3.new(1,1,1)
btnMin.AutoButtonColor = false
btnMin.Parent = header
Instance.new("UICorner", btnMin).CornerRadius = UDim.new(0, 8)

local btnClose = Instance.new("TextButton")
btnClose.Name = "Close"
btnClose.Size = UDim2.new(0, 34, 0, 34)
btnClose.Position = UDim2.new(1, -44, 0.5, -17)
btnClose.BackgroundColor3 = Color3.fromRGB(240, 70, 70)
btnClose.Text = "✕"
btnClose.Font = Enum.Font.GothamBold
btnClose.TextSize = 18
btnClose.TextColor3 = Color3.new(1,1,1)
btnClose.AutoButtonColor = false
btnClose.Parent = header
Instance.new("UICorner", btnClose).CornerRadius = UDim.new(0, 8)

-- Content
local content = Instance.new("Frame")
content.Name = "Content"
content.BackgroundTransparency = 1
content.Position = UDim2.new(0, 14, 0, 64)
content.Size = UDim2.new(1, -28, 1, -78)
content.Parent = window

local list = Instance.new("UIListLayout", content)
list.Padding = UDim.new(0, 10)
list.FillDirection = Enum.FillDirection.Vertical
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.SortOrder = Enum.SortOrder.LayoutOrder

-- Reusable Card Creator
local function makeCard(titleText, descText, height)
    local card = Instance.new("Frame")
    card.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
    card.Size = UDim2.new(1, 0, 0, height or 92)
    card.BorderSizePixel = 0

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 10)
    cCorner.Parent = card

    local cStroke = Instance.new("UIStroke")
    cStroke.Color = strokeColor
    cStroke.Thickness = 1
    cStroke.Parent = card

    local titleLbl = Instance.new("TextLabel")
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = titleText
    titleLbl.Font = Enum.Font.GothamSemibold
    titleLbl.TextSize = 16
    titleLbl.TextColor3 = Color3.fromRGB(230, 235, 255)
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Position = UDim2.new(0, 14, 0, 10)
    titleLbl.Size = UDim2.new(1, -120, 0, 22)
    titleLbl.Parent = card

    local descLbl = Instance.new("TextLabel")
    descLbl.BackgroundTransparency = 1
    descLbl.Text = descText or ""
    descLbl.Font = Enum.Font.Gotham
    descLbl.TextSize = 13
    descLbl.TextColor3 = Color3.fromRGB(160, 170, 190)
    descLbl.TextXAlignment = Enum.TextXAlignment.Left
    descLbl.TextYAlignment = Enum.TextYAlignment.Top
    descLbl.Position = UDim2.new(0, 14, 0, 34)
    descLbl.Size = UDim2.new(1, -120, 0, 40)
    descLbl.Parent = card

    return card, titleLbl, descLbl
end

-- Toggle Pattern
local function makeToggle(parent)
    local holder = Instance.new("Frame")
    holder.BackgroundTransparency = 1
    holder.Size = UDim2.new(0, 80, 1, 0)
    holder.Position = UDim2.new(1, -90, 0, 0)
    holder.AnchorPoint = Vector2.new(1, 0)
    holder.Parent = parent

    local toggle = Instance.new("TextButton")
    toggle.BackgroundColor3 = Color3.fromRGB(50, 56, 66)
    toggle.AutoButtonColor = false
    toggle.Text = ""
    toggle.Size = UDim2.new(0, 64, 0, 28)
    toggle.Position = UDim2.new(1, -64, 0.5, -14)
    toggle.Parent = holder
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 14)

    local nub = Instance.new("Frame")
    nub.BackgroundColor3 = Color3.fromRGB(210, 215, 225)
    nub.Size = UDim2.new(0, 22, 0, 22)
    nub.Position = UDim2.new(0, 3, 0.5, -11)
    nub.Parent = toggle
    Instance.new("UICorner", nub).CornerRadius = UDim.new(1, 0)

    local on = false
    local function setState(v, animate)
        on = v
        local bg = on and primaryColor or Color3.fromRGB(50, 56, 66)
        local nubPos = on and UDim2.new(1, -25, 0.5, -11) or UDim2.new(0, 3, 0.5, -11)
        if animate then
            TweenService:Create(toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = bg}):Play()
            TweenService:Create(nub, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = nubPos}):Play()
        else
            toggle.BackgroundColor3 = bg
            nub.Position = nubPos
        end
    end

    toggle.MouseButton1Click:Connect(function()
        setState(not on, true)
        if toggle.Parent and toggle.Parent.Parent and toggle.Parent.Parent.Parent then
            toggle.Parent.Parent.Parent:SetAttribute("ToggleState", on)
        end
    end)

    setState(false, false)
    return holder, function() return on end, function(v) setState(v, true) end
end

-- Section: Auto Walk (6s)
local autoCard = makeCard("🚶 Auto Walk (6s)", "وقتی روشن باشه، کاراکتر به‌صورت خودکار ۶ ثانیه راه می‌ره.")
autoCard.Parent = content
local autoToggleHolder, autoGet, autoSet = makeToggle(autoCard)

local autoHint = Instance.new("TextLabel")
autoHint.BackgroundTransparency = 1
autoHint.Text = ""
autoHint.Font = Enum.Font.Gotham
autoHint.TextSize = 12
autoHint.TextColor3 = accentSoft
autoHint.TextXAlignment = Enum.TextXAlignment.Left
autoHint.Position = UDim2.new(0, 14, 1, -22)
autoHint.Size = UDim2.new(1, -28, 0, 18)
autoHint.Parent = autoCard

-- Section: Theme color
local themeCard = makeCard("🎨 Theme Color", "برای تنوع رنگ تم را عوض کن. (تصادفی، ملایم و تاریک)")
themeCard.Parent = content

local themeBtn = Instance.new("TextButton")
themeBtn.Text = "تغییر رنگ تم"
themeBtn.Font = Enum.Font.GothamBold
themeBtn.TextSize = 14
themeBtn.TextColor3 = Color3.fromRGB(240, 245, 255)
themeBtn.AutoButtonColor = false
themeBtn.BackgroundColor3 = primaryColor
themeBtn.Size = UDim2.new(0, 160, 0, 32)
themeBtn.Position = UDim2.new(1, -174, 0, 10)
themeBtn.Parent = themeCard
Instance.new("UICorner", themeBtn).CornerRadius = UDim.new(0, 8)

-- Section: Aim Assist Demo (ethical)
local aimCard = makeCard("🎯 Aim Assist Demo (نمایشی)", "این فقط یک دمو بصریه و هیچ دخالتی در گیم‌پلی یا نشونه‌گیری واقعی نداره.")
aimCard.Parent = content
local aimToggleHolder, aimGet, aimSet = makeToggle(aimCard)

-- Crosshair overlay (visual-only)
local crosshair = Instance.new("Frame")
crosshair.Visible = false
crosshair.Size = UDim2.new(0, 14, 0, 14)
crosshair.AnchorPoint = Vector2.new(0.5, 0.5)
crosshair.Position = UDim2.new(0.5, 0, 0.5, 0)
crosshair.BackgroundColor3 = Color3.fromRGB(255,255,255)
crosshair.BackgroundTransparency = 1
crosshair.Parent = screenGui

local chDot = Instance.new("Frame", crosshair)
chDot.Size = UDim2.new(0, 4, 0, 4)
chDot.AnchorPoint = Vector2.new(0.5, 0.5)
chDot.Position = UDim2.new(0.5, 0, 0.5, 0)
chDot.BackgroundColor3 = primaryColor
Instance.new("UICorner", chDot).CornerRadius = UDim.new(1, 0)

local chRing = Instance.new("Frame", crosshair)
chRing.Size = UDim2.new(0, 14, 0, 14)
chRing.AnchorPoint = Vector2.new(0.5, 0.5)
chRing.Position = UDim2.new(0.5, 0, 0.5, 0)
chRing.BackgroundColor3 = Color3.fromRGB(0,0,0)
chRing.BackgroundTransparency = 1
local chStroke = Instance.new("UIStroke", chRing)
chStroke.Color = primaryColor
chStroke.Thickness = 1

-- Resize handle
local resizer = Instance.new("Frame")
resizer.Name = "Resizer"
resizer.Size = UDim2.new(0, 14, 0, 14)
resizer.Position = UDim2.new(1, -10, 1, -10)
resizer.AnchorPoint = Vector2.new(1,1)
resizer.BackgroundColor3 = Color3.fromRGB(40, 44, 54)
resizer.Parent = window
Instance.new("UICorner", resizer).CornerRadius = UDim.new(0, 3)
local resizerStroke = Instance.new("UIStroke", resizer)
resizerStroke.Color = strokeColor

-- Dragging (custom, bug-free)
do
    local dragging = false
    local dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        local newPos = UDim2.fromOffset(startPos.X.Offset + delta.X, startPos.Y.Offset + delta.Y)

        local camera = workspace.CurrentCamera
        if camera then
            local vps = camera.ViewportSize
            local w = window.AbsoluteSize.X
            local h = window.AbsoluteSize.Y

            local minX = 0
            local minY = 0
            local maxX = vps.X - w
            local maxY = vps.Y - h

            newPos = UDim2.fromOffset(
                clamp(newPos.X.Offset, minX, maxX),
                clamp(newPos.Y.Offset, minY, maxY)
            )
        end

        window.Position = newPos
    end

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = window.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)
end

-- Resizing (bottom-right handle)
do
    local resizing = false
    local startSize, startPos, startInputPos
    local minW, minH = 360, 220
    local maxW, maxH = 800, 520

    local function applyResize(input)
        local delta = input.Position - startInputPos
        local newW = clamp(startSize.X.Offset + delta.X, minW, maxW)
        local newH = clamp(startSize.Y.Offset + delta.Y, minH, maxH)

        -- Keep inside screen if possible
        local camera = workspace.CurrentCamera
        if camera then
            local vps = camera.ViewportSize
            newW = clamp(newW, minW, math.max(minW, vps.X - window.Position.X.Offset))
            newH = clamp(newH, minH, math.max(minH, vps.Y - window.Position.Y.Offset))
        end

        window.Size = UDim2.fromOffset(newW, newH)
    end

    resizer.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            startSize = window.Size
            startPos = window.Position
            startInputPos = input.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    resizing = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            applyResize(input)
        end
    end)
end

-- Interactions
local menuOpen = true
local function setMenu(open)
    menuOpen = open
    window.Visible = open
    TweenService:Create(dock, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageColor3 = open and Color3.new(1,1,1) or primaryColor
    }):Play()
end

dock.MouseButton1Click:Connect(function()
    setMenu(not menuOpen)
end)

btnMin.MouseButton1Click:Connect(function()
    setMenu(false)
end)

btnClose.MouseButton1Click:Connect(function()
    setMenu(false)
end)

-- Theme change
local function setPrimaryColor(c)
    primaryColor = c
    dockStroke.Color = c
    headIcon.ImageColor3 = Color3.fromRGB(200, 220, 255)
    chDot.BackgroundColor3 = c
    chStroke.Color = c
    themeBtn.BackgroundColor3 = c
end

local function randomTheme()
    local hue = math.random()
    local sat = 0.65 + math.random() * 0.25
    local val = 0.85
    local c = Color3.fromHSV(hue, sat, val)
    setPrimaryColor(c)
end

themeBtn.MouseButton1Click:Connect(randomTheme)

-- Hover FX helper
local function hoverScale(btn)
    local base = btn.Size
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(base.X.Scale, base.X.Offset + 4, base.Y.Scale, base.Y.Offset + 2)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = base}):Play()
    end)
end
hoverScale(themeBtn)
hoverScale(btnMin)
hoverScale(btnClose)
hoverScale(dock)

-- Auto Walk (6s) logic
local autoWalking = false
local function startAutoWalk()
    if autoWalking then return end
    autoWalking = true
    autoHint.Text = "در حال راه رفتن خودکار..."
    local _, humanoid = safeWaitForHumanoid()

    local elapsed = 0
    local duration = 6
    local conn
    conn = RunService.RenderStepped:Connect(function(dt)
        elapsed += dt
        -- حرکت به سمت جلو نسبت به دوربین (ملايم و بدون لگ)
        if humanoid and humanoid.Parent then
            humanoid:Move(Vector3.new(0, 0, -1), true)
        end
        if elapsed >= duration or not autoWalking then
            if conn then conn:Disconnect() end
            if humanoid and humanoid.Parent then
                humanoid:Move(Vector3.new(0, 0, 0), true)
            end
            autoWalking = false
            autoSet(false)
            autoHint.Text = "پایان راه رفتن خودکار."
            task.delay(1.2, function()
                if autoHint then autoHint.Text = "" end
            end)
        end
    end)
end

autoCard:GetAttributeChangedSignal("ToggleState"):Connect(function()
    local state = autoCard:GetAttribute("ToggleState")
    if state and not autoWalking then
        startAutoWalk()
    end
end)

-- Aim Assist Demo (visual-only, non-cheat)
local aimPulseConn
local function setAimDemo(on)
    crosshair.Visible = on
    if aimPulseConn then aimPulseConn:Disconnect() aimPulseConn = nil end
    if on then
        local t = 0
        aimPulseConn = RunService.RenderStepped:Connect(function(dt)
            t += dt * 2
            local r = 7 + math.sin(t) * 2
            chRing.Size = UDim2.new(0, r*2, 0, r*2)
            chStroke.Thickness = 1 + 0.5 * math.max(0, math.cos(t))
        end)
    end
end

aimCard:GetAttributeChangedSignal("ToggleState"):Connect(function()
    local state = aimCard:GetAttribute("ToggleState")
    setAimDemo(state and true or false)
end)

-- Character refresh safety
player.CharacterAdded:Connect(function()
    -- اگر در حال راه رفتن بود، ایمن متوقف شود
    autoWalking = false
    autoSet(false)
end)

-- Initial state
setMenu(true)

-- Notes for you:
-- - برای لوگو/تم تصویر دلخواه، Image های dock و headIcon و pattern را با rbxassetid://ID خودت جایگزین کن.
-- - سیستم Drag/Resize کاملاً اختصاصی و بدون Draggable است تا باگ نده.
-- - Aim Assist Demo صرفاً نمایشی است و هیچ کنترلی روی هدف‌گیری یا دنیا اعمال نمی‌کند (غیرفریب‌کارانه).
