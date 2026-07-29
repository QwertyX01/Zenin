-- =====================================================
--  Zenin Menu (без добро пожаловать, без кнопки закрытия, без скругления)
--  Размер: 640x360
-- =====================================================

local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ZeninMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Основной фрейм
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 640, 0, 360)
mainFrame.Position = UDim2.new(0.5, -320, 0.5, -180)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BackgroundTransparency = 0
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

-- Надпись Zenin (красная)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 80)
title.Position = UDim2.new(0, 0, 0.1, 0)
title.BackgroundTransparency = 1
title.Text = "Zenin"
title.TextColor3 = Color3.fromRGB(200, 0, 0)
title.TextSize = 52
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Center
title.Parent = mainFrame

-- Декоративная линия под заголовком
local line = Instance.new("Frame")
line.Size = UDim2.new(0.5, 0, 0, 2)
line.Position = UDim2.new(0.25, 0, 0.32, 0)
line.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
line.BackgroundTransparency = 0.3
line.BorderSizePixel = 0
line.Parent = mainFrame

print("✅ Zenin Menu (640x360) загружен!")
