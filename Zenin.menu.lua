-- =====================================================
--  Zenin Menu (с хедером, красный текст по центру)
--  Размер: 640x420
-- =====================================================

local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ZeninMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Основной фрейм
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

-- ============================================================
--  Хедер (верхняя плашка)
-- ============================================================
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 35)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
header.BackgroundTransparency = 0
header.BorderSizePixel = 0
header.Parent = mainFrame

-- Нижняя обводка (серая полоска)
local headerStroke = Instance.new("UIStroke")
headerStroke.Color = Color3.fromRGB(45, 45, 45)
headerStroke.Thickness = 1
headerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
headerStroke.Parent = header

-- Текст "Zenin.cs" (красный, по центру)
local headerText = Instance.new("TextLabel")
headerText.Size = UDim2.new(1, 0, 1, 0)           -- растянут на весь хедер
headerText.Position = UDim2.new(0, 0, 0, 0)
headerText.BackgroundTransparency = 1
headerText.Text = "Zenin.cs"
headerText.TextColor3 = Color3.fromRGB(200, 0, 0)  -- красный
headerText.TextSize = 16
headerText.Font = Enum.Font.GothamBold
headerText.TextXAlignment = Enum.TextXAlignment.Center
headerText.TextYAlignment = Enum.TextYAlignment.Center
headerText.Parent = header

print("✅ Zenin Menu с красным Zenin.cs по центру загружен!")
