-- =====================================================
--  Zenin Menu (без красной обводки)
-- =====================================================

local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ZeninMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local TweenService = game:GetService("TweenService")

-- ============================================================
--  ЗАГРУЗКА ЛОГОТИПА
-- ============================================================
local imageUrl = "https://i.ibb.co/Ng94fYSP/Chat-GPT-Image-30-2026-02-48-28.png"
local fileName = "zenin_logo.png"
local filePath = fileName

local function fileExists(path)
    local success, result = pcall(function()
        return loadfile(path)
    end)
    return success and result ~= nil
end

if not fileExists(filePath) then
    print("📥 Скачиваем логотип...")
    local success, content = pcall(function()
        return game:HttpGet(imageUrl, true)
    end)
    if success and content then
        local writeSuccess, err = pcall(function()
            writefile(filePath, content)
        end)
        if writeSuccess then
            print("✅ Логотип сохранён: " .. filePath)
        else
            warn("⚠️ Не удалось сохранить файл: " .. tostring(err))
        end
    else
        warn("⚠️ Не удалось скачать картинку")
    end
else
    print("✅ Логотип уже есть на диске.")
end

local logoPath = nil
if getcustomasset then
    logoPath = getcustomasset(filePath)
elseif getgenv().getcustomasset then
    logoPath = getgenv().getcustomasset(filePath)
end

-- ============================================================
--  АНИМАЦИОННЫЙ КОНТЕЙНЕР
-- ============================================================
local animContainer = Instance.new("Frame")
animContainer.Name = "AnimContainer"
animContainer.Size = UDim2.new(1, 0, 1, 0)
animContainer.Position = UDim2.new(0, 0, 0, 0)
animContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
animContainer.BackgroundTransparency = 0
animContainer.ZIndex = 10
animContainer.Parent = gui

local animLogo = Instance.new("ImageLabel")
animLogo.Size = UDim2.new(0, 80, 0, 80)
animLogo.Position = UDim2.new(0.5, -40, 0.5, -40)
animLogo.BackgroundTransparency = 1
animLogo.Image = logoPath or ""
animLogo.ImageTransparency = 1
animLogo.ZIndex = 10
animLogo.Parent = animContainer

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 16)
logoCorner.Parent = animLogo

local animText = Instance.new("TextLabel")
animText.Size = UDim2.new(0, 200, 0, 60)
animText.Position = UDim2.new(0.5, 40, 0.5, -30)
animText.BackgroundTransparency = 1
animText.Text = "Zenin"
animText.TextColor3 = Color3.fromRGB(255, 255, 255)
animText.TextSize = 48
animText.Font = Enum.Font.GothamBold
animText.TextXAlignment = Enum.TextXAlignment.Left
animText.TextYAlignment = Enum.TextYAlignment.Center
animText.ZIndex = 10
animText.Visible = false
animText.TextTransparency = 1
animText.Parent = animContainer

-- ============================================================
--  ОСНОВНОЕ МЕНЮ (без обводки)
-- ============================================================
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 640, 0, 420)
mainFrame.Position = UDim2.new(0.5, -320, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BackgroundTransparency = 0
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ZIndex = 5
mainFrame.Visible = false
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 6)
mainCorner.Parent = mainFrame

-- ОБВОДКА УДАЛЕНА

-- ============================================================
--  ХЕДЕР
-- ============================================================
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 35)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
header.BackgroundTransparency = 0
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 6)
headerCorner.Parent = header

local headerStroke = Instance.new("UIStroke")
headerStroke.Color = Color3.fromRGB(45, 45, 45)
headerStroke.Thickness = 1
headerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
headerStroke.Parent = header

if logoPath then
    local logo = Instance.new("ImageLabel")
    logo.Size = UDim2.new(0, 28, 0, 28)
    logo.Position = UDim2.new(0, 6, 0.5, -14)
    logo.BackgroundTransparency = 1
    logo.Image = logoPath
    logo.Parent = header
end

local headerText = Instance.new("TextLabel")
headerText.Size = UDim2.new(1, 0, 1, 0)
headerText.Position = UDim2.new(0, 0, 0, 0)
headerText.BackgroundTransparency = 1
headerText.Text = "ZENIN.CS"
headerText.TextColor3 = Color3.fromRGB(240, 40, 40)
headerText.TextSize = 16
headerText.Font = Enum.Font.GothamBold
headerText.TextXAlignment = Enum.TextXAlignment.Center
headerText.TextYAlignment = Enum.TextYAlignment.Center
headerText.Parent = header

-- ============================================================
--  СТРАНИЦЫ
-- ============================================================
local pages = {}
local pageNames = {"Aim", "ESP", "Skins"}

for i, name in ipairs(pageNames) do
    local page = Instance.new("Frame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, -80)
    page.Position = UDim2.new(0, 0, 0, 35)
    page.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    page.BackgroundTransparency = 0.2
    page.BorderSizePixel = 0
    page.Visible = (i == 1)
    page.Parent = mainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = page

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name .. "\n(настройки)"
    label.TextColor3 = Color3.fromRGB(150, 150, 150)
    label.TextSize = 24
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Parent = page

    pages[name] = page
end

-- ============================================================
--  ВКЛАДКИ
-- ============================================================
local tabsBar = Instance.new("Frame")
tabsBar.Name = "TabsBar"
tabsBar.Size = UDim2.new(1, 0, 0, 45)
tabsBar.Position = UDim2.new(0, 0, 1, -45)
tabsBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
tabsBar.BackgroundTransparency = 0
tabsBar.BorderSizePixel = 0
tabsBar.ClipsDescendants = true
tabsBar.Parent = mainFrame

local activeLine = Instance.new("Frame")
activeLine.Name = "ActiveLine"
activeLine.Size = UDim2.new(0.33333, 0, 0, 2)
activeLine.Position = UDim2.new(0, 0, 0, 0)
activeLine.BackgroundColor3 = Color3.fromRGB(240, 40, 40)
activeLine.BackgroundTransparency = 0
activeLine.BorderSizePixel = 0
activeLine.Parent = tabsBar

local tabButtons = {}
local tabNames = {"Aim", "ESP", "Skins"}
local tabPositions = {0, 0.33333, 0.66666}

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Btn"
    btn.Size = UDim2.new(0.33333, 0, 1, 0)
    btn.Position = UDim2.new((i-1) * 0.33333, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = (i == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
    btn.TextSize = 18
    btn.Font = Enum.Font.SourceSans
    btn.Parent = tabsBar

    local scale = Instance.new("UIScale")
    scale.Scale = 1
    scale.Parent = btn

    tabButtons[name] = btn

    btn.MouseButton1Click:Connect(function()
        TweenService:Create(scale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 0.95}):Play()
        task.wait(0.1)
        TweenService:Create(scale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()

        for pageName, page in pairs(pages) do
            page.Visible = (pageName == name)
        end

        for n, b in pairs(tabButtons) do
            if n == name then
                b.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                b.BackgroundTransparency = 0.1
                b.TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                b.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
                b.BackgroundTransparency = 0.2
                b.TextColor3 = Color3.fromRGB(180, 180, 180)
            end
        end

        local targetX = tabPositions[i]
        TweenService:Create(activeLine, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(targetX, 0, 0, 0)
        }):Play()
    end)
end

tabButtons["Aim"].BackgroundColor3 = Color3.fromRGB(60, 60, 70)
tabButtons["Aim"].BackgroundTransparency = 0.1
tabButtons["Aim"].TextColor3 = Color3.fromRGB(255, 255, 255)

-- ============================================================
--  ЗАПУСК АНИМАЦИИ
-- ============================================================
animLogo.ImageTransparency = 1
animLogo.Size = UDim2.new(0, 80, 0, 80)
animLogo.Position = UDim2.new(0.5, -40, 0.5, -40)

TweenService:Create(animLogo, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    ImageTransparency = 0,
    Size = UDim2.new(0, 100, 0, 100),
    Position = UDim2.new(0.5, -50, 0.5, -50)
}):Play()
task.wait(0.7)

animText.Visible = true
animText.TextTransparency = 1

TweenService:Create(animLogo, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.4, -50, 0.5, -50)
}):Play()

TweenService:Create(animText, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    TextTransparency = 0
}):Play()
task.wait(0.6)

mainFrame.Visible = true
mainFrame.BackgroundTransparency = 0

TweenService:Create(animContainer, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    BackgroundTransparency = 1
}):Play()
task.wait(0.4)
animContainer.Visible = false
animContainer:Destroy()

print("✅ Zenin Menu (без обводки) загружен!")
