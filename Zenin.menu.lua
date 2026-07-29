-- =====================================================
--  Zenin Menu (с логотипом, обновлённая ссылка)
-- =====================================================

local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ZeninMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

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

-- Логотип (НОВАЯ ССЫЛКА)
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 28, 0, 28)              -- размер 28x28 (помещается в хедер 35)
logo.Position = UDim2.new(0, 6, 0.5, -14)        -- слева, по центру вертикали
logo.BackgroundTransparency = 1
logo.Image = "https://i.ibb.co/Ng94fYSP/Chat-GPT-Image-30-2026-02-48-28.png"  -- новая ссылка
logo.Parent = header

-- Текст "Zenin.cs" (со сдвигом вправо, чтобы не наезжать на логотип)
local headerText = Instance.new("TextLabel")
headerText.Size = UDim2.new(1, -45, 1, 0)        -- отступ справа
headerText.Position = UDim2.new(0, 40, 0, 0)     -- сдвиг вправо на 40 пикселей
headerText.BackgroundTransparency = 1
headerText.Text = "Zenin.cs"
headerText.TextColor3 = Color3.fromRGB(200, 0, 0)
headerText.TextSize = 16
headerText.Font = Enum.Font.GothamBold
headerText.TextXAlignment = Enum.TextXAlignment.Left
headerText.TextYAlignment = Enum.TextYAlignment.Center
headerText.Parent = header

print("✅ Zenin Menu с логотипом загружен!")
