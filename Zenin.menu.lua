--[[
    Zertyx - Menu with ESP (FIXED v2)
    Version: 2.3
    Size: 640x420
    Open: Button ≡ in top-left corner
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- === SETTINGS ===
local Settings = {
    ESP = true
}

-- === ESP STORAGE ===
local espObjects = {}

-- === CREATE GUI ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "Zertyx"
ScreenGui.ResetOnSpawn = false

-- === MAIN FRAME ===
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 640, 0, 420)
MainFrame.Position = UDim2.new(0.5, -320, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
MainFrame.BackgroundTransparency = 0
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false

-- === HEADER ===
local Header = Instance.new("Frame")
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 45)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
Header.BackgroundTransparency = 0
Header.BorderSizePixel = 0

-- === TITLE ===
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

-- === TABS CONTAINER ===
local TabsContainer = Instance.new("Frame")
TabsContainer.Parent = MainFrame
TabsContainer.Size = UDim2.new(1, 0, 0, 40)
TabsContainer.Position = UDim2.new(0, 0, 0, 45)
TabsContainer.BackgroundTransparency = 1
TabsContainer.BorderSizePixel = 0

-- === TAB BUTTONS ===
local tabs = {"Visuals", "Aim", "Misc"}
local TabButtons = {}
local TabContents = {}

for i, tabName in ipairs(tabs) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = TabsContainer
    TabBtn.Size = UDim2.new(0, 80, 0, 28)
    TabBtn.Position = UDim2.new(0, 15 + (i-1) * 90, 0.5, -14)
    TabBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.BackgroundTransparency = 0
    TabBtn.BorderSizePixel = 0
    TabBtn.Text = tabName:upper()
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
    
    if tabName == "Visuals" then
        CreateVisualsTab(Content)
    elseif tabName == "Aim" then
        CreateAimTab(Content)
    elseif tabName == "Misc" then
        CreateMiscTab(Content)
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

-- Activate first tab
local firstTab = TabButtons["Visuals"]
if firstTab then
    firstTab.BackgroundColor3 = Color3.fromRGB(160, 160, 160)
    firstTab.TextColor3 = Color3.fromRGB(0, 0, 0)
end

-- === CREATE ROW ===
local function CreateRow(parent, label, yPos)
    local Row = Instance.new("Frame")
    Row.Parent = parent
    Row.Size = UDim2.new(1, -10, 0, 42)
    Row.Position = UDim2.new(0, 5, 0, yPos)
    Row.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    Row.BackgroundTransparency = 0.3
    Row.BorderSizePixel = 0
    
    local RowCorner = Instance.new("UICorner")
    RowCorner.Parent = Row
    RowCorner.CornerRadius = UDim.new(0, 10)
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Row
    Label.Size = UDim2.new(0, 140, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = label
    Label.TextColor3 = Color3.fromRGB(50, 50, 50)
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextYAlignment = Enum.TextYAlignment.Center
    
    return Row
end

-- === SQUARE TOGGLE ===
local function CreateToggle(row, defaultState, callback)
    local Toggle = Instance.new("TextButton")
    Toggle.Parent = row
    Toggle.Size = UDim2.new(0, 32, 0, 32)
    Toggle.Position = UDim2.new(1, -42, 0.5, -16)
    Toggle.BackgroundColor3 = defaultState and Color3.fromRGB(79, 124, 176) or Color3.fromRGB(180, 180, 180)
    Toggle.BorderSizePixel = 0
    Toggle.Text = defaultState and "✓" or ""
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.TextSize = 20
    Toggle.Font = Enum.Font.GothamBold
    Toggle.AutoButtonColor = false
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.Parent = Toggle
    ToggleCorner.CornerRadius = UDim.new(0, 4)
    
    local state = defaultState
    Toggle.MouseButton1Click:Connect(function()
        state = not state
        Toggle.Text = state and "✓" or ""
        Toggle.BackgroundColor3 = state and Color3.fromRGB(79, 124, 176) or Color3.fromRGB(180, 180, 180)
        if callback then callback(state) end
    end)
    
    return Toggle
end

-- === ESP FUNCTIONS ===
local function createHighlight(playerObj)
    if espObjects[playerObj] then
        espObjects[playerObj]:Destroy()
        espObjects[playerObj] = nil
    end
    
    if not playerObj.Character then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Parent = playerObj.Character
    highlight.FillColor = Color3.fromRGB(0, 255, 100)
    highlight.FillTransparency = 0.4
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    
    espObjects[playerObj] = highlight
end

local function updateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            local humanoid = character and character:FindFirstChild("Humanoid")
            
            if Settings.ESP and character and humanoid then
                if not espObjects[player] then
                    createHighlight(player)
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

local function clearESP()
    for player, highlight in pairs(espObjects) do
        highlight:Destroy()
    end
    espObjects = {}
end

local function toggleESP(state)
    Settings.ESP = state
    if state then
        updateESP()
    else
        clearESP()
    end
end

-- === VISUALS TAB ===
function CreateVisualsTab(parent)
    local yPos = 10
    
    local row1 = CreateRow(parent, "ESP", yPos)
    CreateToggle(row1, Settings.ESP, function(state)
        toggleESP(state)
    end)
    yPos = yPos + 48
    
    parent.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- === AIM TAB ===
function CreateAimTab(parent)
    local yPos = 10
    
    local row1 = CreateRow(parent, "Aimbot", yPos)
    CreateToggle(row1, false, function(state)
        print("Aimbot: " .. tostring(state))
    end)
    yPos = yPos + 48
    
    parent.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- === MISC TAB ===
function CreateMiscTab(parent)
    local yPos = 10
    
    local row1 = CreateRow(parent, "Watermark", yPos)
    CreateToggle(row1, true, function(state)
        Watermark.Visible = state
    end)
    yPos = yPos + 48
    
    local row2 = CreateRow(parent, "FPS Counter", yPos)
    CreateToggle(row2, true, function(state)
        FPSCounter.Visible = state
    end)
    yPos = yPos + 48
    
    parent.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- === OPEN BUTTON ===
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

-- === WATERMARK ===
local Watermark = Instance.new("TextLabel")
Watermark.Parent = ScreenGui
Watermark.Size = UDim2.new(0, 200, 0, 30)
Watermark.Position = UDim2.new(0, 10, 1, -40)
Watermark.BackgroundTransparency = 1
Watermark.Text = "Zertyx v2.3 | BloxStrike"
Watermark.TextColor3 = Color3.fromRGB(100, 100, 100)
Watermark.TextSize = 14
Watermark.Font = Enum.Font.GothamBold
Watermark.TextXAlignment = Enum.TextXAlignment.Left
Watermark.TextYAlignment = Enum.TextYAlignment.Bottom
Watermark.Visible = true

-- === FPS COUNTER ===
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
FPSCounter.Visible = true

local frameCount = 0
local lastTime = tick()

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local currentTime = tick()
    if currentTime - lastTime >= 1 then
        FPSCounter.Text = tostring(frameCount) .. " FPS"
        frameCount = 0
        lastTime = currentTime
    end
end)

-- === ESP EVENTS (БЕЗ wait и spawn) ===
-- Обновляем ESP при появлении игрока
Players.PlayerAdded:Connect(function(player)
    -- Используем CharacterAdded без задержки
    player.CharacterAdded:Connect(function()
        updateESP()
    end)
    -- Небольшая задержка через RunService
    RunService.Heartbeat:Wait()
    updateESP()
end)

Players.PlayerRemoving:Connect(function(player)
    if espObjects[player] then
        espObjects[player]:Destroy()
        espObjects[player] = nil
    end
end)

-- Обновляем ESP каждую секунду через RunService
local lastUpdate = tick()
RunService.Heartbeat:Connect(function()
    local currentTime = tick()
    if currentTime - lastUpdate >= 1 then
        updateESP()
        lastUpdate = currentTime
    end
end)

-- Запускаем ESP сразу
updateESP()

-- === GLOBAL ACCESS ===
_G.Zertyx = {
    ToggleMenu = function()
        MainFrame.Visible = not MainFrame.Visible
    end,
    IsOpen = function()
        return MainFrame.Visible
    end,
    Settings = Settings,
    ToggleESP = toggleESP,
    UpdateESP = updateESP
}

print("Zertyx v2.3 Loaded Successfully!")
print("Press ≡ button in top-left corner to open menu")
print("ESP: ON")
