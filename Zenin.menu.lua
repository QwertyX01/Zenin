-- Zertyx v2.4 - MAX COMPATIBILITY
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Настройки
local Settings = {ESP = true}
local espObjects = {}

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "Zertyx"
ScreenGui.ResetOnSpawn = false

-- Главное меню
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 640, 0, 420)
MainFrame.Position = UDim2.new(0.5, -320, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
MainFrame.BackgroundTransparency = 0
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false

-- Хедер
local Header = Instance.new("Frame")
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 45)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
Header.BackgroundTransparency = 0
Header.BorderSizePixel = 0

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.Size = UDim2.new(0, 150, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Zertyx"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextYAlignment = Enum.TextYAlignment.Center

-- Вкладки
local TabsContainer = Instance.new("Frame")
TabsContainer.Parent = MainFrame
TabsContainer.Size = UDim2.new(1, 0, 0, 40)
TabsContainer.Position = UDim2.new(0, 0, 0, 45)
TabsContainer.BackgroundTransparency = 1

local tabNames = {"Visuals", "Aim", "Misc"}
local TabButtons = {}
local TabContents = {}

for i = 1, 3 do
    local tabName = tabNames[i]
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = TabsContainer
    TabBtn.Size = UDim2.new(0, 80, 0, 28)
    TabBtn.Position = UDim2.new(0, 15 + (i-1) * 90, 0.5, -14)
    TabBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.BackgroundTransparency = 0
    TabBtn.BorderSizePixel = 0
    TabBtn.Text = string.upper(tabName)
    TabBtn.TextColor3 = Color3.fromRGB(80, 80, 80)
    TabBtn.TextSize = 12
    TabBtn.Font = Enum.Font.GothamMedium
    TabBtn.AutoButtonColor = false
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.Parent = TabBtn
    TabCorner.CornerRadius = UDim.new(0, 20)
    
    local Content = Instance.new("ScrollingFrame")
    Content.Parent = MainFrame
    Content.Size = UDim2.new(1, -20, 1, -100)
    Content.Position = UDim2.new(0, 10, 0, 90)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.Visible = (i == 1)
    Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    Content.ScrollBarThickness = 4
    Content.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200)
    Content.Name = tabName .. "Content"
    
    -- Только для Visuals добавляем ESP
    if tabName == "Visuals" then
        local row = Instance.new("Frame")
        row.Parent = Content
        row.Size = UDim2.new(1, -10, 0, 42)
        row.Position = UDim2.new(0, 5, 0, 10)
        row.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
        row.BackgroundTransparency = 0.3
        row.BorderSizePixel = 0
        
        local rowCorner = Instance.new("UICorner")
        rowCorner.Parent = row
        rowCorner.CornerRadius = UDim.new(0, 10)
        
        local label = Instance.new("TextLabel")
        label.Parent = row
        label.Size = UDim2.new(0, 140, 1, 0)
        label.Position = UDim2.new(0, 12, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = "ESP"
        label.TextColor3 = Color3.fromRGB(50, 50, 50)
        label.TextSize = 14
        label.Font = Enum.Font.GothamMedium
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextYAlignment = Enum.TextYAlignment.Center
        
        local toggle = Instance.new("TextButton")
        toggle.Parent = row
        toggle.Size = UDim2.new(0, 32, 0, 32)
        toggle.Position = UDim2.new(1, -42, 0.5, -16)
        toggle.BackgroundColor3 = Color3.fromRGB(79, 124, 176)
        toggle.BorderSizePixel = 0
        toggle.Text = "✓"
        toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggle.TextSize = 20
        toggle.Font = Enum.Font.GothamBold
        toggle.AutoButtonColor = false
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.Parent = toggle
        toggleCorner.CornerRadius = UDim.new(0, 4)
        
        local espState = true
        toggle.MouseButton1Click:Connect(function()
            espState = not espState
            Settings.ESP = espState
            toggle.Text = espState and "✓" or ""
            toggle.BackgroundColor3 = espState and Color3.fromRGB(79, 124, 176) or Color3.fromRGB(180, 180, 180)
            if espState then
                UpdateESP()
            else
                ClearESP()
            end
        end)
        
        Content.CanvasSize = UDim2.new(0, 0, 0, 60)
    else
        -- Пустые вкладки
        local emptyText = Instance.new("TextLabel")
        emptyText.Parent = Content
        emptyText.Size = UDim2.new(1, 0, 1, 0)
        emptyText.Position = UDim2.new(0, 0, 0, 0)
        emptyText.BackgroundTransparency = 1
        emptyText.Text = string.upper(tabName) .. " TAB"
        emptyText.TextColor3 = Color3.fromRGB(180, 180, 180)
        emptyText.TextSize = 24
        emptyText.Font = Enum.Font.GothamBold
        emptyText.TextXAlignment = Enum.TextXAlignment.Center
        emptyText.TextYAlignment = Enum.TextYAlignment.Center
    end
    
    TabButtons[tabName] = TabBtn
    TabContents[tabName] = Content
    
    TabBtn.MouseButton1Click:Connect(function()
        for name, btn in pairs(TabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            btn.TextColor3 = Color3.fromRGB(80, 80, 80)
            TabContents[name].Visible = false
        end
        TabBtn.BackgroundColor3 = Color3.fromRGB(160, 160, 160)
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        Content.Visible = true
    end)
end

-- Активируем первую вкладку
TabButtons["Visuals"].BackgroundColor3 = Color3.fromRGB(160, 160, 160)
TabButtons["Visuals"].TextColor3 = Color3.fromRGB(0, 0, 0)

-- Кнопка открытия
local OpenButton = Instance.new("TextButton")
OpenButton.Parent = ScreenGui
OpenButton.Size = UDim2.new(0, 50, 0, 30)
OpenButton.Position = UDim2.new(0, 10, 0, 10)
OpenButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
OpenButton.BackgroundTransparency = 0.3
OpenButton.BorderSizePixel = 0
OpenButton.Text = "≡"
OpenButton.TextColor3 = Color3.fromRGB(0, 0, 0)
OpenButton.TextSize = 22
OpenButton.Font = Enum.Font.GothamBold

local OpenCorner = Instance.new("UICorner")
OpenCorner.Parent = OpenButton
OpenCorner.CornerRadius = UDim.new(0, 30)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ESP функции
function CreateHighlight(player)
    if espObjects[player] then
        espObjects[player]:Destroy()
        espObjects[player] = nil
    end
    if not player.Character then return end
    local highlight = Instance.new("Highlight")
    highlight.Parent = player.Character
    highlight.FillColor = Color3.fromRGB(0, 255, 100)
    highlight.FillTransparency = 0.4
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    espObjects[player] = highlight
end

function UpdateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if Settings.ESP and char and char:FindFirstChild("Humanoid") then
                if not espObjects[player] then
                    CreateHighlight(player)
                end
            else
                if espObjects[player] then
                    espObjects[player]:Destroy()
                    espObjects[player] = nil
                end
            end
        end
    end
end

function ClearESP()
    for _, highlight in pairs(espObjects) do
        highlight:Destroy()
    end
    espObjects = {}
end

-- События
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(UpdateESP)
    UpdateESP()
end)

Players.PlayerRemoving:Connect(function(player)
    if espObjects[player] then
        espObjects[player]:Destroy()
        espObjects[player] = nil
    end
end)

-- Обновление ESP каждую секунду
local lastUpdate = tick()
RunService.Heartbeat:Connect(function()
    if tick() - lastUpdate >= 1 then
        UpdateESP()
        lastUpdate = tick()
    end
end)

-- Запуск
UpdateESP()

-- Watermark
local Watermark = Instance.new("TextLabel")
Watermark.Parent = ScreenGui
Watermark.Size = UDim2.new(0, 200, 0, 30)
Watermark.Position = UDim2.new(0, 10, 1, -40)
Watermark.BackgroundTransparency = 1
Watermark.Text = "Zertyx v2.4 | BloxStrike"
Watermark.TextColor3 = Color3.fromRGB(100, 100, 100)
Watermark.TextSize = 14
Watermark.Font = Enum.Font.GothamBold
Watermark.TextXAlignment = Enum.TextXAlignment.Left
Watermark.TextYAlignment = Enum.TextYAlignment.Bottom

-- FPS Counter
local FPSCounter = Instance.new("TextLabel")
FPSCounter.Parent = ScreenGui
FPSCounter.Size = UDim2.new(0, 60, 0, 30)
FPSCounter.Position = UDim2.new(1, -70, 1, -40)
FPSCounter.BackgroundTransparency = 1
FPSCounter.Text = "60 FPS"
FPSCounter.TextColor3 = Color3.fromRGB(100, 100, 100)
FPSCounter.TextSize = 13
FPSCounter.Font = Enum.Font.GothamMedium
FPSCounter.TextXAlignment = Enum.TextXAlignment.Right
FPSCounter.TextYAlignment = Enum.TextYAlignment.Bottom

local fcount = 0
local flast = tick()
RunService.RenderStepped:Connect(function()
    fcount = fcount + 1
    if tick() - flast >= 1 then
        FPSCounter.Text = fcount .. " FPS"
        fcount = 0
        flast = tick()
    end
end)

_G.Zertyx = {
    ToggleMenu = function() MainFrame.Visible = not MainFrame.Visible end,
    IsOpen = function() return MainFrame.Visible end,
    UpdateESP = UpdateESP
}

print("Zertyx v2.4 Loaded! Press ≡ to open menu")
