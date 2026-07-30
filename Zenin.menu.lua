-- =====================================================
--  Zenin Menu (горизонтальные вкладки-капсулы внизу)
-- =====================================================

local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ZeninMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

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
--  ОСНОВНОЕ МЕНЮ
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
local pageColors = {
    Aim = Color3.fromRGB(25, 25, 30),
    ESP = Color3.fromRGB(25, 25, 30),
    Misc = Color3.fromRGB(25, 25, 30),
    Skins = Color3.fromRGB(25, 25, 30),
}

for i, name in ipairs(pageNames) do
    local page = Instance.new("Frame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, -80)   -- 35 (header) + 45 (tabs) = 80
    page.Position = UDim2.new(0, 0, 0, 35)
    page.BackgroundColor3 = pageColors[name]
    page.BackgroundTransparency = 0.2
    page.BorderSizePixel = 0
    page.Visible = (i == 1)   -- AimPage видима по умолчанию
    page.Parent = mainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = page

    -- Текст-заглушка
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
--  НИЖНЯЯ ПАНЕЛЬ ВКЛАДОК (TabsBar)
-- ============================================================
local tabsBar = Instance.new("Frame")
tabsBar.Name = "TabsBar"
tabsBar.Size = UDim2.new(1, 0, 0, 45)
tabsBar.Position = UDim2.new(0, 0, 1, -45)   -- прижат к низу
tabsBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)  -- чуть темнее фона
tabsBar.BackgroundTransparency = 0
tabsBar.BorderSizePixel = 0
tabsBar.ClipsDescendants = true
tabsBar.Parent = mainFrame

-- Горизонтальное расположение с центрированием
local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tabLayout.Padding = UDim.new(0, 10)
tabLayout.Parent = tabsBar

-- Кнопки-капсулы
local tabButtons = {}
local tabData = {
    { name = "Aim", emoji = "🎯" },
    { name = "ESP", emoji = "👁️" },
    { name = "Misc", emoji = "⚙️" },
    { name = "Skins", emoji = "🎨" },
}

for i, data in ipairs(tabData) do
    local btn = Instance.new("TextButton")
    btn.Name = data.name .. "Btn"
    btn.Size = UDim2.new(0, 90, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.Text = data.emoji .. " " .. data.name
    btn.TextColor3 = (i == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
    btn.TextSize = 15
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = tabsBar

    -- Скругление (капсула)
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = btn

    tabButtons[data.name] = btn

    btn.MouseButton1Click:Connect(function()
        -- Переключаем страницы
        for pageName, page in pairs(pages) do
            page.Visible = (pageName == data.name)
        end

        -- Обновляем вид кнопок
        for name, b in pairs(tabButtons) do
            if name == data.name then
                b.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                b.BackgroundTransparency = 0.1
                b.TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                b.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
                b.BackgroundTransparency = 0.2
                b.TextColor3 = Color3.fromRGB(180, 180, 180)
            end
        end
    end)
end

-- Устанавливаем начальное состояние (Aim активна)
tabButtons["Aim"].BackgroundColor3 = Color3.fromRGB(60, 60, 70)
tabButtons["Aim"].BackgroundTransparency = 0.1
tabButtons["Aim"].TextColor3 = Color3.fromRGB(255, 255, 255)

print("✅ Zenin Menu с горизонтальными вкладками-капсулами загружен!")
