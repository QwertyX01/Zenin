-- =====================================================
--  Zenin Menu (с надёжной загрузкой логотипа)
-- =====================================================

local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ZeninMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- ============================================================
--  ЗАГРУЗКА ЛОГОТИПА (упрощённая, с диагностикой)
-- ============================================================
local imageUrl = "https://i.ibb.co/Ng94fYSP/Chat-GPT-Image-30-2026-02-48-28.png"
local fileName = "zenin_logo.png"
local filePath = fileName

local logoPath = nil

-- Сначала проверим, есть ли файл через isfile (если доступно)
local function fileExists(path)
    if isfile then
        return isfile(path)
    else
        -- fallback: пытаемся открыть через loadfile
        local success, result = pcall(function() return loadfile(path) end)
        return success and result ~= nil
    end
end

if fileExists(filePath) then
    print("✅ Логотип уже есть на диске: " .. filePath)
else
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
        warn("⚠️ Не удалось скачать картинку по ссылке: " .. imageUrl)
    end
end

-- Получаем путь через getcustomasset (для отображения)
if getcustomasset then
    logoPath = getcustomasset(filePath)
elseif getgenv().getcustomasset then
    logoPath = getgenv().getcustomasset(filePath)
else
    warn("⚠️ getcustomasset не найден, логотип не будет отображаться")
end

if logoPath then
    print("🖼️ Логотип готов к отображению: " .. tostring(logoPath))
else
    print("❌ Логотип не загружен (путь не получен)")
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

-- Хедер
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 35)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
header.BackgroundTransparency = 0
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerStroke = Instance.new("UIStroke")
headerStroke.Color = Color3.fromRGB(45, 45, 45)
headerStroke.Thickness = 1
headerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
headerStroke.Parent = header

-- Логотип (создаём только если путь получен)
if logoPath then
    local logo = Instance.new("ImageLabel")
    logo.Size = UDim2.new(0, 28, 0, 28)
    logo.Position = UDim2.new(0, 6, 0.5, -14)
    logo.BackgroundTransparency = 1
    logo.Image = logoPath
    logo.Parent = header
    print("🖼️ Логотип отображается в меню")
else
    print("❌ Логотип НЕ отображается (путь не получен)")
end

-- Текст "Zenin.cs"
local headerText = Instance.new("TextLabel")
headerText.Size = UDim2.new(1, -45, 1, 0)
headerText.Position = UDim2.new(0, 40, 0, 0)
headerText.BackgroundTransparency = 1
headerText.Text = "Zenin.cs"
headerText.TextColor3 = Color3.fromRGB(200, 0, 0)
headerText.TextSize = 16
headerText.Font = Enum.Font.GothamBold
headerText.TextXAlignment = Enum.TextXAlignment.Left
headerText.TextYAlignment = Enum.TextYAlignment.Center
headerText.Parent = header

print("✅ Zenin Menu загружен!")
