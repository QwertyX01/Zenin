-- =====================================================
--  Zenin Menu (разделитель в Aim)
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
local function downloadFile(url, fileName)
    local filePath = fileName
    local function fileExists(path)
        local success, result = pcall(function()
            return loadfile(path)
        end)
        return success and result ~= nil
    end

    if not fileExists(filePath) then
        print("📥 Скачиваем " .. fileName .. "...")
        local success, content = pcall(function()
            return game:HttpGet(url, true)
        end)
        if success and content then
            local writeSuccess, err = pcall(function()
                writefile(filePath, content)
            end)
            if writeSuccess then
                print("✅ " .. fileName .. " сохранён: " .. filePath)
            else
                warn("⚠️ Не удалось сохранить " .. fileName .. ": " .. tostring(err))
            end
        else
            warn("⚠️ Не удалось скачать " .. fileName)
        end
    else
        print("✅ " .. fileName .. " уже есть на диске.")
    end

    local assetPath = nil
    if getcustomasset then
        assetPath = getcustomasset(filePath)
    elseif getgenv().getcustomasset then
        assetPath = getgenv().getcustomasset(filePath)
    end
    return assetPath
end

local logoUrl = "https://i.ibb.co/Ng94fYSP/Chat-GPT-Image-30-2026-02-48-28.png"
local logoPath = downloadFile(logoUrl, "zenin_logo.png")

-- ============================================================
--  АНИМАЦИЯ (без изменений)
-- ============================================================
local animContainer = Instance.new("Frame")
animContainer.Name = "AnimContainer"
animContainer.Size = UDim2.new(1, 0, 1, 0)
animContainer.Position = UDim2.new(0, 0, 0, 0)
animContainer.BackgroundTransparency = 1
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

local logoStroke = Instance.new("UIStroke")
logoStroke.Color = Color3.fromRGB(255, 255, 255)
logoStroke.Thickness = 2
logoStroke.Transparency = 0.5
logoStroke.Parent = animLogo

local animText = Instance.new("TextLabel")
animText.Size = UDim2.new(0, 0, 0, 60)
animText.Position = UDim2.new(0.5, 40, 0.5, -30)
animText.BackgroundTransparency = 1
animText.Text = "Zenin CS"
animText.TextColor3 = Color3.fromRGB(255, 255, 255)
animText.TextSize = 48
animText.Font = Enum.Font.GothamBold
animText.TextXAlignment = Enum.TextXAlignment.Left
animText.TextYAlignment = Enum.TextYAlignment.Center
animText.ZIndex = 10
animText.Visible = false
animText.TextTransparency = 1
animText.Parent = animContainer

animText.Size = UDim2.new(0, animText.TextBounds.X + 20, 0, 60)

-- Запуск анимации
animLogo.ImageTransparency = 1
animLogo.Size = UDim2.new(0, 80, 0, 80)
animLogo.Position = UDim2.new(0.5, -40, 0.5, -40)
logoStroke.Transparency = 1

local tween1 = TweenService:Create(animLogo, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    ImageTransparency = 0,
    Size = UDim2.new(0, 100, 0, 100),
    Position = UDim2.new(0.5, -50, 0.5, -50)
})
local tweenStroke = TweenService:Create(logoStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Transparency = 0.3
})
tween1:Play()
tweenStroke:Play()
tween1.Completed:Wait()

animText.Visible = true
animText.TextTransparency = 1

local targetLogoPos = UDim2.new(0.35, -50, 0.5, -50)
local logoWidth = 100
local textOffset = 10
local targetTextPos = UDim2.new(0.35, -50 + logoWidth + textOffset, 0.5, -30)

local tweenLogo = TweenService:Create(animLogo, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Position = targetLogoPos
})
local tweenText = TweenService:Create(animText, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    TextTransparency = 0,
    Position = targetTextPos
})
tweenLogo:Play()
tweenText:Play()
tweenLogo.Completed:Wait()

task.wait(0.2)
animContainer.Visible = false
animContainer:Destroy()

-- ============================================================
--  МЕНЮ
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

-- Хедер
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
headerStroke.Color = Color3.fromRGB(60, 60, 60)
headerStroke.Thickness = 1
headerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
headerStroke.Parent = header

if logoPath then
    local logoLeft = Instance.new("ImageLabel")
    logoLeft.Size = UDim2.new(0, 28, 0, 28)
    logoLeft.Position = UDim2.new(0, 6, 0.5, -14)
    logoLeft.BackgroundTransparency = 1
    logoLeft.Image = logoPath
    logoLeft.ZIndex = 2
    logoLeft.Parent = header
    local cornerLeft = Instance.new("UICorner")
    cornerLeft.CornerRadius = UDim.new(0, 12)
    cornerLeft.Parent = logoLeft

    local logoRight = Instance.new("ImageLabel")
    logoRight.Size = UDim2.new(0, 28, 0, 28)
    logoRight.Position = UDim2.new(1, -34, 0.5, -14)
    logoRight.BackgroundTransparency = 1
    logoRight.Image = logoPath
    logoRight.ZIndex = 2
    logoRight.Parent = header
    local cornerRight = Instance.new("UICorner")
    cornerRight.CornerRadius = UDim.new(0, 12)
    cornerRight.Parent = logoRight
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
headerText.ZIndex = 1
headerText.Parent = header

-- ============================================================
--  СТРАНИЦЫ (с разделителем в Aim)
-- ============================================================
local pages = {}
local pageNames = {"Aim", "ESP", "Skins"}

for i, name in ipairs(pageNames) do
    local page = Instance.new("Frame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, -70)
    page.Position = UDim2.new(0, 0, 0, 35)
    page.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    page.BackgroundTransparency = 0.2
    page.BorderSizePixel = 0
    page.Visible = (i == 1)
    page.Parent = mainFrame
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = page

    -- ДОБАВЛЯЕМ ВЕРТИКАЛЬНУЮ СЕРУЮ ЛИНИЮ ДЛЯ Aim
    if name == "Aim" then
        local divider = Instance.new("Frame")
        divider.Size = UDim2.new(0, 2, 1, 0)   -- толщина 2px, на всю высоту
        divider.Position = UDim2.new(0.5, -1, 0, 0) -- по центру
        divider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        divider.BackgroundTransparency = 0.4
        divider.BorderSizePixel = 0
        divider.Parent = page
    end

    pages[name] = page
end

-- ============================================================
--  ВКЛАДКИ (без иконок)
-- ============================================================
local tabsBar = Instance.new("Frame")
tabsBar.Name = "TabsBar"
tabsBar.Size = UDim2.new(1, 0, 0, 35)
tabsBar.Position = UDim2.new(0, 0, 1, -35)
tabsBar.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
tabsBar.BackgroundTransparency = 0
tabsBar.BorderSizePixel = 0
tabsBar.ClipsDescendants = true
tabsBar.Parent = mainFrame

local topLine = Instance.new("Frame")
topLine.Size = UDim2.new(1, 0, 0, 1)
topLine.Position = UDim2.new(0, 0, 0, 0)
topLine.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
topLine.BackgroundTransparency = 0.4
topLine.BorderSizePixel = 0
topLine.Parent = tabsBar

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
    btn.TextSize = 16
    btn.Font = Enum.Font.SourceSans
    btn.Parent = tabsBar

    -- Иконки удалены

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

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

print("✅ Zenin Menu с разделителем в Aim загружен!")
