-- =====================================================
--  Zenin Menu (с вкладками ESP, AIM, MISC, SKINS)
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
--  КОНТЕНТ ДЛЯ ВКЛАДОК (область под хедером)
-- ============================================================
local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(1, 0, 1, -65)   -- 35 хедер + 30 вкладки
contentContainer.Position = UDim2.new(0, 0, 0, 35)
contentContainer.BackgroundTransparency = 0
contentContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
contentContainer.BorderSizePixel = 0
contentContainer.ClipsDescendants = true
contentContainer.Parent = mainFrame

-- Создаём 4 фрейма для контента (пока пустые, только для демонстрации)
local contentFrames = {}
local tabNames = {"ESP", "AIM", "MISC", "SKINS"}
for i, name in ipairs(tabNames) do
    local frame = Instance.new("Frame")
    frame.Name = name .. "Content"
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundTransparency = 0.2
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    frame.BorderSizePixel = 0
    frame.Visible = (i == 1)
    frame.Parent = contentContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = frame

    -- Текст-заглушка (чтобы видеть, какая вкладка активна)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name .. "\n(настройки)"
    label.TextColor3 = Color3.fromRGB(150, 150, 150)
    label.TextSize = 24
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Parent = frame

    contentFrames[name] = frame
end

-- ============================================================
--  ПАНЕЛЬ ВКЛАДОК (снизу)
-- ============================================================
local tabsPanel = Instance.new("Frame")
tabsPanel.Name = "TabsPanel"
tabsPanel.Size = UDim2.new(1, 0, 0, 30)
tabsPanel.Position = UDim2.new(0, 0, 1, -30)
tabsPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
tabsPanel.BackgroundTransparency = 0
tabsPanel.BorderSizePixel = 0
tabsPanel.ClipsDescendants = true
tabsPanel.Parent = mainFrame

-- Тонкая верхняя линия (для отделения)
local topLine = Instance.new("Frame")
topLine.Size = UDim2.new(1, 0, 0, 1)
topLine.Position = UDim2.new(0, 0, 0, 0)
topLine.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
topLine.BackgroundTransparency = 0.4
topLine.BorderSizePixel = 0
topLine.Parent = tabsPanel

-- Кнопки вкладок (по ¼ ширины)
local tabButtons = {}
local function createTabButton(parent, name, i)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Btn"
    btn.Size = UDim2.new(0.25, -1, 1, 0)        -- ¼ ширины с зазором 1 пиксель
    btn.Position = UDim2.new((i-1) * 0.25, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = (i == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamMedium
    btn.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = btn

    return btn
end

for i, name in ipairs(tabNames) do
    local btn = createTabButton(tabsPanel, name, i)
    tabButtons[name] = btn

    btn.MouseButton1Click:Connect(function()
        -- Скрываем все контенты
        for n, frame in pairs(contentFrames) do
            frame.Visible = (n == name)
        end
        -- Обновляем цвет кнопок
        for n, b in pairs(tabButtons) do
            if n == name then
                b.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
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

-- Устанавливаем начальное состояние (активна первая вкладка)
tabButtons["ESP"].BackgroundColor3 = Color3.fromRGB(45, 45, 50)
tabButtons["ESP"].BackgroundTransparency = 0.1
tabButtons["ESP"].TextColor3 = Color3.fromRGB(255, 255, 255)

print("✅ Zenin Menu с вкладками загружен!")
