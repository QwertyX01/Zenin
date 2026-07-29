-- =====================================================
--  Zenin Menu (белое, мягкие углы)
--  Размер: 470x330
-- =====================================================

local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ZeninMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Основной фрейм
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 470, 0, 330)
mainFrame.Position = UDim2.new(0.5, -235, 0.5, -165)  -- центрирование
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- белый
mainFrame.BackgroundTransparency = 0
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

-- ОЧЕНЬ МЯГКИЕ УГЛЫ (радиус 24)
local corners = Instance.new("UICorner")
corners.CornerRadius = UDim.new(0, 24)
corners.Parent = mainFrame

-- Тонкая тень для красоты (опционально)
local shadow = Instance.new("UIStroke")
shadow.Color = Color3.fromRGB(200, 200, 200)
shadow.Transparency = 0.3
shadow.Thickness = 1
shadow.Parent = mainFrame

-- Надпись Zenin (красная, крупная)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 80)
title.Position = UDim2.new(0, 0, 0.05, 0)
title.BackgroundTransparency = 1
title.Text = "Zenin"
title.TextColor3 = Color3.fromRGB(200, 0, 0)  -- красный
title.TextSize = 48
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Center
title.Parent = mainFrame

-- Декоративная линия под заголовком (красная, тонкая)
local line = Instance.new("Frame")
line.Size = UDim2.new(0.6, 0, 0, 2)
line.Position = UDim2.new(0.2, 0, 0.3, 0)
line.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
line.BackgroundTransparency = 0.4
line.BorderSizePixel = 0
line.Parent = mainFrame

-- Пустое пространство (можно добавить кнопки позже)
-- Например, просто информационный текст
local info = Instance.new("TextLabel")
info.Size = UDim2.new(0.8, 0, 0, 40)
info.Position = UDim2.new(0.1, 0, 0.4, 0)
info.BackgroundTransparency = 1
info.Text = "добро пожаловать"
info.TextColor3 = Color3.fromRGB(100, 100, 100)
info.TextSize = 18
info.Font = Enum.Font.GothamMedium
info.TextXAlignment = Enum.TextXAlignment.Center
info.TextYAlignment = Enum.TextYAlignment.Center
info.Parent = mainFrame

-- Кнопка закрытия (маленькая, серая)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
closeBtn.BackgroundTransparency = 0.5
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame
local closeCorners = Instance.new("UICorner")
closeCorners.CornerRadius = UDim.new(0, 12)
closeCorners.Parent = closeBtn
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("✅ Zenin Menu загружен!")
