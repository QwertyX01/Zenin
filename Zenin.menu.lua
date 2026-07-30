-- =====================================================
--  Zenin Menu (с красной обводкой)
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
--  ОСНОВНОЕ МЕНЮ (с красной обводкой)
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
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 6)
mainCorner.Parent = mainFrame

-- ОЧЕНЬ ТОНКАЯ КРАСНАЯ ОБВОДКА
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(240, 40, 40)
mainStroke.Transparency = 0.4
mainStroke.Thickness = 1
mainStroke.Parent = mainFrame

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

-- Логотип
if logoPath then
    local logo = Instance.new("ImageLabel")
    logo.Size = UDim2.new(0, 28, 0, 28)
    logo.Position = UDim2.new(0, 6, 0.5, -14)
    logo.BackgroundTransparency = 1
    logo.Image = logoPath
    logo.Parent = header
    print("🖼️ Логотип загружен")
else
    print("❌ Логотип не загружен")
end

-- Текст "ZENIN.CS"
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
--  СТРАНИЦЫ (контент)
-- ============================================================
local pages = {}
local pageNames = {"Aim", "ESP", "Misc", "Skins"}

for i, name in ipairs(pageNames) do
    local page = Instance.new("Frame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, -80)   -- 35 (header) + 45 (tabs) = 80
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
--  НИЖНЯЯ ПАНЕЛЬ ВКЛАДОК
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

local topLine = Instance.new("Frame")
topLine.Size = UDim2.new(1, 0, 0, 1)
topLine.Position = UDim2.new(0, 0, 0, 0)
topLine.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
topLine.BackgroundTransparency = 0.4
topLine.BorderSizePixel = 0
topLine.Parent = tabsBar

-- Кнопки и линии
local tabButtons = {}
local tabLines = {}
local tabScales = {}
local tabNames = {"Aim", "ESP", "Misc", "Skins"}

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Btn"
    btn.Size = UDim2.new(0.25, 0, 1, 0)
    btn.Position = UDim2.new((i-1) * 0.25, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = (i == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
    btn.TextSize = 18
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = tabsBar

    local scale = Instance.new("UIScale")
    scale.Scale = 1
    scale.Parent = btn
    tabScales[name] = scale

    local line = Instance.new("Frame")
    line.Name = "Line"
    line.Size = UDim2.new(1, 0, 0, 2)
    line.Position = UDim2.new(0, 0, 1, 0)
    line.BackgroundColor3 = Color3.fromRGB(240, 40, 40)
    line.BackgroundTransparency = (i == 1) and 0 or 1
    line.BorderSizePixel = 0
    line.Parent = btn
    tabLines[name] = line

    tabButtons[name] = btn

    btn.MouseButton1Click:Connect(function()
        local scaleObj = tabScales[name]
        TweenService:Create(scaleObj, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 0.95}):Play()
        task.wait(0.1)
        TweenService:Create(scaleObj, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()

        for pageName, page in pairs(pages) do
            page.Visible = (pageName == name)
        end

        for n, b in pairs(tabButtons) do
            if n == name then
                b.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                b.BackgroundTransparency = 0.1
                b.TextColor3 = Color3.fromRGB(255, 255, 255)
                tabLines[n].BackgroundTransparency = 0
            else
                b.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
                b.BackgroundTransparency = 0.2
                b.TextColor3 = Color3.fromRGB(180, 180, 180)
                tabLines[n].BackgroundTransparency = 1
            end
        end
    end)
end

tabButtons["Aim"].BackgroundColor3 = Color3.fromRGB(60, 60, 70)
tabButtons["Aim"].BackgroundTransparency = 0.1
tabButtons["Aim"].TextColor3 = Color3.fromRGB(255, 255, 255)
tabLines["Aim"].BackgroundTransparency = 0

print("✅ Zenin Menu с красной обводкой загружен!")
