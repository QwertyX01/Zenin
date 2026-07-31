-- Zertyx CHEAT v3.7 - RAINBOW AURA
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Lighting = game:GetService("Lighting")

-- НАСТРОЙКИ
local ESPEnabled = true
local BigHeadEnabled = false
local AtmosphereEnabled = false
local RainbowAuraEnabled = false
local SelectedAtmoColor = Color3.fromRGB(150, 50, 200)
local espObjects = {}
local bigHeadObjects = {}
local auraObjects = {}
local originalGuiColor = nil

-- === СОЗДАНИЕ ГЛАВНОГО GUI ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "Zertyx"
ScreenGui.ResetOnSpawn = false

-- === ГЛАВНОЕ МЕНЮ (ФИОЛЕТОВАЯ ТЕМА) ===
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 640, 0, 420)
MainFrame.Position = UDim2.new(0.5, -320, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
MainFrame.BackgroundTransparency = 0
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false

local MainCorner = Instance.new("UICorner")
MainCorner.Parent = MainFrame
MainCorner.CornerRadius = UDim.new(0, 12)

-- ХЕДЕР
local Header = Instance.new("Frame")
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 40)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(60, 30, 80)
Header.BackgroundTransparency = 0
Header.BorderSizePixel = 0

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ZERTYX CHEAT"
Title.TextColor3 = Color3.fromRGB(220, 150, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.TextYAlignment = Enum.TextYAlignment.Center

-- ВКЛАДКИ
local TabContainer = Instance.new("Frame")
TabContainer.Parent = MainFrame
TabContainer.Size = UDim2.new(1, 0, 0, 35)
TabContainer.Position = UDim2.new(0, 0, 0, 40)
TabContainer.BackgroundColor3 = Color3.fromRGB(40, 20, 55)
TabContainer.BackgroundTransparency = 0
TabContainer.BorderSizePixel = 0

local tabs = {"Visuals", "Aim", "Misc"}
local tabBtns = {}
local tabContents = {}

for i = 1, 3 do
    local btn = Instance.new("TextButton")
    btn.Parent = TabContainer
    btn.Size = UDim2.new(0, 80, 0, 28)
    btn.Position = UDim2.new(0, 15 + (i-1) * 90, 0.5, -14)
    btn.BackgroundColor3 = Color3.fromRGB(50, 30, 65)
    btn.BackgroundTransparency = 0
    btn.BorderSizePixel = 0
    btn.Text = string.upper(tabs[i])
    btn.TextColor3 = Color3.fromRGB(200, 180, 220)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamMedium
    btn.AutoButtonColor = false
    
    local corner = Instance.new("UICorner")
    corner.Parent = btn
    corner.CornerRadius = UDim.new(0, 15)
    
    local content = Instance.new("Frame")
    content.Parent = MainFrame
    content.Size = UDim2.new(1, 0, 1, -90)
    content.Position = UDim2.new(0, 0, 0, 75)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.Visible = (i == 1)
    content.Name = tabs[i] .. "Content"
    
    tabBtns[tabs[i]] = btn
    tabContents[tabs[i]] = content
    
    btn.MouseButton1Click:Connect(function()
        for _, b in pairs(tabBtns) do
            b.BackgroundColor3 = Color3.fromRGB(50, 30, 65)
            b.TextColor3 = Color3.fromRGB(200, 180, 220)
        end
        for _, c in pairs(tabContents) do
            c.Visible = false
        end
        btn.BackgroundColor3 = Color3.fromRGB(80, 50, 100)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        content.Visible = true
    end)
end

-- VISUALS TAB
local visualsContent = tabContents["Visuals"]
local yPos = 10

-- ФУНКЦИЯ СОЗДАНИЯ РЯДА С ТОГГЛЕМ
local function CreateToggleRow(parent, label, defaultState, callback, yPos)
    local row = Instance.new("Frame")
    row.Parent = parent
    row.Size = UDim2.new(1, -20, 0, 40)
    row.Position = UDim2.new(0, 10, 0, yPos)
    row.BackgroundColor3 = Color3.fromRGB(50, 30, 65)
    row.BackgroundTransparency = 0.5
    row.BorderSizePixel = 0
    
    local rowCorner = Instance.new("UICorner")
    rowCorner.Parent = row
    rowCorner.CornerRadius = UDim.new(0, 8)
    
    local labelText = Instance.new("TextLabel")
    labelText.Parent = row
    labelText.Size = UDim2.new(0, 140, 1, 0)
    labelText.Position = UDim2.new(0, 12, 0, 0)
    labelText.BackgroundTransparency = 1
    labelText.Text = label
    labelText.TextColor3 = Color3.fromRGB(220, 200, 240)
    labelText.TextSize = 14
    labelText.Font = Enum.Font.GothamMedium
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.TextYAlignment = Enum.TextYAlignment.Center
    
    local toggle = Instance.new("TextButton")
    toggle.Parent = row
    toggle.Size = UDim2.new(0, 30, 0, 30)
    toggle.Position = UDim2.new(1, -40, 0.5, -15)
    toggle.BackgroundColor3 = defaultState and Color3.fromRGB(150, 50, 200) or Color3.fromRGB(60, 40, 75)
    toggle.BackgroundTransparency = 0
    toggle.BorderSizePixel = 0
    toggle.Text = defaultState and "✓" or ""
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.TextSize = 18
    toggle.Font = Enum.Font.GothamBold
    toggle.AutoButtonColor = false
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.Parent = toggle
    toggleCorner.CornerRadius = UDim.new(0, 4)
    
    local state = defaultState
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = state and "✓" or ""
        toggle.BackgroundColor3 = state and Color3.fromRGB(150, 50, 200) or Color3.fromRGB(60, 40, 75)
        if callback then callback(state) end
    end)
    
    return row
end

-- ESP TOGGLE
CreateToggleRow(visualsContent, "ESP", ESPEnabled, function(state)
    ESPEnabled = state
    if state then UpdateESP() else ClearESP() end
end, yPos)
yPos = yPos + 50

-- BIG HEAD TOGGLE
CreateToggleRow(visualsContent, "Big Head", BigHeadEnabled, function(state)
    BigHeadEnabled = state
    if state then UpdateBigHead() else ClearBigHead() end
end, yPos)
yPos = yPos + 50

-- RAINBOW AURA TOGGLE
CreateToggleRow(visualsContent, "Rainbow Aura", RainbowAuraEnabled, function(state)
    RainbowAuraEnabled = state
    if state then 
        UpdateRainbowAura()
    else 
        ClearRainbowAura()
    end
end, yPos)
yPos = yPos + 50

-- ATMOSPHERE TOGGLE
CreateToggleRow(visualsContent, "Atmosphere", AtmosphereEnabled, function(state)
    AtmosphereEnabled = state
    if state then 
        ApplyCloudColor(SelectedAtmoColor)
        ApplyGUIStyle(true)
        colorPicker.Visible = true
        colorPickerFrame.Visible = true
    else 
        ResetAtmosphere()
        colorPicker.Visible = false
        colorPickerFrame.Visible = false
    end
end, yPos)
yPos = yPos + 50

-- === ЦВЕТОВАЯ ПАЛИТРА ===
local colorPickerFrame = Instance.new("Frame")
colorPickerFrame.Parent = visualsContent
colorPickerFrame.Size = UDim2.new(1, -20, 0, 40)
colorPickerFrame.Position = UDim2.new(0, 10, 0, yPos)
colorPickerFrame.BackgroundColor3 = Color3.fromRGB(50, 30, 65)
colorPickerFrame.BackgroundTransparency = 0.5
colorPickerFrame.BorderSizePixel = 0
colorPickerFrame.Visible = false

local colorPickerCorner = Instance.new("UICorner")
colorPickerCorner.Parent = colorPickerFrame
colorPickerCorner.CornerRadius = UDim.new(0, 8)

local colors = {
    {Color3.fromRGB(150, 50, 200), "Purple"},
    {Color3.fromRGB(200, 100, 255), "Lavender"},
    {Color3.fromRGB(100, 50, 200), "Deep Purple"},
    {Color3.fromRGB(255, 100, 200), "Pink"},
    {Color3.fromRGB(50, 150, 255), "Blue"},
    {Color3.fromRGB(200, 50, 100), "Red"},
    {Color3.fromRGB(0, 200, 255), "Cyan"},
    {Color3.fromRGB(255, 150, 50), "Orange"}
}

local colorButtons = {}
local colorPicker = Instance.new("Frame")
colorPicker.Parent = colorPickerFrame
colorPicker.Size = UDim2.new(1, 0, 1, 0)
colorPicker.BackgroundTransparency = 1

for i = 1, #colors do
    local colorBtn = Instance.new("TextButton")
    colorBtn.Parent = colorPicker
    colorBtn.Size = UDim2.new(0, 30, 0, 30)
    colorBtn.Position = UDim2.new(0, 10 + (i-1) * 40, 0.5, -15)
    colorBtn.BackgroundColor3 = colors[i][1]
    colorBtn.BackgroundTransparency = 0
    colorBtn.BorderSizePixel = 0
    colorBtn.Text = ""
    colorBtn.AutoButtonColor = false
    
    local colorCorner = Instance.new("UICorner")
    colorCorner.Parent = colorBtn
    colorCorner.CornerRadius = UDim.new(0, 6)
    
    if colors[i][1] == SelectedAtmoColor then
        colorBtn.BorderSizePixel = 2
        colorBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    end
    
    colorBtn.MouseButton1Click:Connect(function()
        SelectedAtmoColor = colors[i][1]
        if AtmosphereEnabled then
            ApplyCloudColor(SelectedAtmoColor)
            ApplyGUIStyle(true)
        end
        for _, btn in pairs(colorButtons) do
            btn.BorderSizePixel = 0
        end
        colorBtn.BorderSizePixel = 2
        colorBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    colorButtons[i] = colorBtn
end

-- AIM TAB
local aimContent = tabContents["Aim"]
local aimLabel = Instance.new("TextLabel")
aimLabel.Parent = aimContent
aimLabel.Size = UDim2.new(1, 0, 1, 0)
aimLabel.Position = UDim2.new(0, 0, 0, 0)
aimLabel.BackgroundTransparency = 1
aimLabel.Text = "AIM TAB"
aimLabel.TextColor3 = Color3.fromRGB(180, 150, 200)
aimLabel.TextSize = 24
aimLabel.Font = Enum.Font.GothamBold
aimLabel.TextXAlignment = Enum.TextXAlignment.Center
aimLabel.TextYAlignment = Enum.TextYAlignment.Center

-- MISC TAB
local miscContent = tabContents["Misc"]
local miscLabel = Instance.new("TextLabel")
miscLabel.Parent = miscContent
miscLabel.Size = UDim2.new(1, 0, 1, 0)
miscLabel.Position = UDim2.new(0, 0, 0, 0)
miscLabel.BackgroundTransparency = 1
miscLabel.Text = "MISC TAB"
miscLabel.TextColor3 = Color3.fromRGB(180, 150, 200)
miscLabel.TextSize = 24
miscLabel.Font = Enum.Font.GothamBold
miscLabel.TextXAlignment = Enum.TextXAlignment.Center
miscLabel.TextYAlignment = Enum.TextYAlignment.Center

-- === ATMOSPHERE ФУНКЦИИ ===
function ApplyGUIStyle(enable)
    pcall(function()
        local guiService = game:GetService("GuiService")
        if enable then
            originalGuiColor = guiService.BackgroundColor3
            guiService.BackgroundColor3 = Color3.fromRGB(80, 30, 120)
        else
            if originalGuiColor then
                guiService.BackgroundColor3 = originalGuiColor
            end
        end
    end)
end

function ApplyCloudColor(color)
    pcall(function()
        if Lighting:FindFirstChild("Clouds") then
            Lighting:FindFirstChild("Clouds").Color = color
        end
        if Lighting.CloudColor ~= nil then
            Lighting.CloudColor = color
        end
        if Lighting:FindFirstChild("Atmosphere") then
            local atmosphere = Lighting:FindFirstChild("Atmosphere")
            atmosphere.Color = color
            atmosphere.Density = 0.3
        end
        Lighting.FogColor = color
        Lighting.FogEnd = 1000
    end)
end

function ResetAtmosphere()
    pcall(function()
        if Lighting:FindFirstChild("Clouds") then
            Lighting:FindFirstChild("Clouds").Color = Color3.fromRGB(255, 255, 255)
        end
        if Lighting.CloudColor ~= nil then
            Lighting.CloudColor = Color3.fromRGB(255, 255, 255)
        end
        if Lighting:FindFirstChild("Atmosphere") then
            local atmosphere = Lighting:FindFirstChild("Atmosphere")
            atmosphere.Color = Color3.fromRGB(255, 255, 255)
            atmosphere.Density = 0.5
        end
        Lighting.FogColor = Color3.fromRGB(150, 150, 150)
        Lighting.FogEnd = 2000
        ApplyGUIStyle(false)
    end)
end

-- === RAINBOW AURA ФУНКЦИИ ===
function CreateRainbowAura(targetPlayer)
    if auraObjects[targetPlayer] then
        for _, obj in pairs(auraObjects[targetPlayer]) do
            obj:Destroy()
        end
        auraObjects[targetPlayer] = nil
    end
    
    if not targetPlayer.Character then return end
    local head = targetPlayer.Character:FindFirstChild("Head")
    if not head then return end
    
    -- Создаем BillboardGui над головой
    local billboard = Instance.new("BillboardGui")
    billboard.Parent = head
    billboard.Size = UDim2.new(0, 60, 0, 60)
    billboard.Adornee = head
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 300
    
    -- Создаем Frame с эффектом свечения
    local frame = Instance.new("Frame")
    frame.Parent = billboard
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.Parent = frame
    frameCorner.CornerRadius = UDim.new(0, 30)
    
    -- Создаем UIGradient для радужного эффекта
    local gradient = Instance.new("UIGradient")
    gradient.Parent = frame
    gradient.Rotation = 45
    
    -- Создаем цветовые точки для радуги
    local colors = {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
    }
    gradient.Color = ColorSequence.new(colors)
    
    -- Добавляем свечение
    local glow = Instance.new("ImageLabel")
    glow.Parent = frame
    glow.Size = UDim2.new(1.5, 0, 1.5, 0)
    glow.Position = UDim2.new(-0.25, 0, -0.25, 0)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://13063196338"
    glow.ImageColor3 = Color3.fromRGB(255, 255, 255)
    glow.ImageTransparency = 0.3
    
    auraObjects[targetPlayer] = {billboard, gradient, frame, glow}
end

function RemoveRainbowAura(targetPlayer)
    if auraObjects[targetPlayer] then
        for _, obj in pairs(auraObjects[targetPlayer]) do
            obj:Destroy()
        end
        auraObjects[targetPlayer] = nil
    end
end

function UpdateRainbowAura()
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= LocalPlayer then
            if RainbowAuraEnabled and targetPlayer.Character then
                local head = targetPlayer.Character:FindFirstChild("Head")
                if head and not auraObjects[targetPlayer] then
                    CreateRainbowAura(targetPlayer)
                end
            else
                RemoveRainbowAura(targetPlayer)
            end
        end
    end
end

function ClearRainbowAura()
    for player, objects in pairs(auraObjects) do
        for _, obj in pairs(objects) do
            obj:Destroy()
        end
    end
    auraObjects = {}
end

-- === ESP ФУНКЦИИ ===
function CreateESP(targetPlayer)
    if espObjects[targetPlayer] then
        espObjects[targetPlayer]:Destroy()
        espObjects[targetPlayer] = nil
    end
    if not targetPlayer.Character then return end
    local highlight = Instance.new("Highlight")
    highlight.Parent = targetPlayer.Character
    highlight.FillColor = Color3.fromRGB(150, 50, 200)
    highlight.FillTransparency = 0.4
    highlight.OutlineColor = Color3.fromRGB(255, 200, 255)
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    espObjects[targetPlayer] = highlight
end

function RemoveESP(targetPlayer)
    if espObjects[targetPlayer] then
        espObjects[targetPlayer]:Destroy()
        espObjects[targetPlayer] = nil
    end
end

function UpdateESP()
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= LocalPlayer then
            if ESPEnabled and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                CreateESP(targetPlayer)
            else
                RemoveESP(targetPlayer)
            end
        end
    end
end

function ClearESP()
    for _, obj in pairs(espObjects) do
        obj:Destroy()
    end
    espObjects = {}
end

-- === BIG HEAD ФУНКЦИИ ===
function CreateBigHead(targetPlayer)
    if bigHeadObjects[targetPlayer] then
        bigHeadObjects[targetPlayer]:Destroy()
        bigHeadObjects[targetPlayer] = nil
    end
    if not targetPlayer.Character then return end
    local head = targetPlayer.Character:FindFirstChild("Head")
    if not head then return end
    if not head:GetAttribute("OriginalSize") then
        head:SetAttribute("OriginalSize", head.Size)
    end
    head.Size = head.Size * 2
    bigHeadObjects[targetPlayer] = head
end

function RemoveBigHead(targetPlayer)
    if bigHeadObjects[targetPlayer] then
        local head = bigHeadObjects[targetPlayer]
        local originalSize = head:GetAttribute("OriginalSize")
        if originalSize then
            head.Size = originalSize
        end
        head:SetAttribute("OriginalSize", nil)
        bigHeadObjects[targetPlayer] = nil
    end
end

function UpdateBigHead()
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= LocalPlayer then
            if BigHeadEnabled and targetPlayer.Character then
                local head = targetPlayer.Character:FindFirstChild("Head")
                if head and not bigHeadObjects[targetPlayer] then
                    CreateBigHead(targetPlayer)
                end
            else
                RemoveBigHead(targetPlayer)
            end
        end
    end
end

function ClearBigHead()
    for _, head in pairs(bigHeadObjects) do
        local originalSize = head:GetAttribute("OriginalSize")
        if originalSize then
            head.Size = originalSize
        end
        head:SetAttribute("OriginalSize", nil)
    end
    bigHeadObjects = {}
end

-- === ПОСТОЯННОЕ ОБНОВЛЕНИЕ ===
RunService.Heartbeat:Connect(function()
    -- ESP
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= LocalPlayer then
            if ESPEnabled and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                CreateESP(targetPlayer)
            else
                RemoveESP(targetPlayer)
            end
        end
    end
    
    -- Big Head
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= LocalPlayer then
            if BigHeadEnabled and targetPlayer.Character then
                local head = targetPlayer.Character:FindFirstChild("Head")
                if head and not bigHeadObjects[targetPlayer] then
                    CreateBigHead(targetPlayer)
                end
            else
                RemoveBigHead(targetPlayer)
            end
        end
    end
    
    -- Rainbow Aura
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= LocalPlayer then
            if RainbowAuraEnabled and targetPlayer.Character then
                local head = targetPlayer.Character:FindFirstChild("Head")
                if head and not auraObjects[targetPlayer] then
                    CreateRainbowAura(targetPlayer)
                end
            else
                RemoveRainbowAura(targetPlayer)
            end
        end
    end
end)

-- === СОБЫТИЯ ===
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        UpdateESP()
        UpdateBigHead()
        UpdateRainbowAura()
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
    RemoveBigHead(player)
    RemoveRainbowAura(player)
end)

-- === ЗАПУСК ===
UpdateESP()
UpdateBigHead()
UpdateRainbowAura()

-- === ОТКРЫТИЕ МЕНЮ ===
local OpenBtn = Instance.new("TextButton")
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 50, 0, 30)
OpenBtn.Position = UDim2.new(0, 10, 0, 10)
OpenBtn.BackgroundColor3 = Color3.fromRGB(60, 30, 80)
OpenBtn.BackgroundTransparency = 0
OpenBtn.BorderSizePixel = 0
OpenBtn.Text = "≡"
OpenBtn.TextColor3 = Color3.fromRGB(220, 150, 255)
OpenBtn.TextSize = 22
OpenBtn.Font = Enum.Font.GothamBold

local OpenCorner = Instance.new("UICorner")
OpenCorner.Parent = OpenBtn
OpenCorner.CornerRadius = UDim.new(0, 30)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- === WATERMARK ===
local Watermark = Instance.new("TextLabel")
Watermark.Parent = ScreenGui
Watermark.Size = UDim2.new(0, 200, 0, 30)
Watermark.Position = UDim2.new(0, 10, 1, -40)
Watermark.BackgroundTransparency = 1
Watermark.Text = "Zertyx v3.7 | BloxStrike"
Watermark.TextColor3 = Color3.fromRGB(180, 150, 200)
Watermark.TextSize = 13
Watermark.Font = Enum.Font.GothamBold
Watermark.TextXAlignment = Enum.TextXAlignment.Left
Watermark.TextYAlignment = Enum.TextYAlignment.Bottom

-- === FPS ===
local FPS = Instance.new("TextLabel")
FPS.Parent = ScreenGui
FPS.Size = UDim2.new(0, 60, 0, 30)
FPS.Position = UDim2.new(1, -70, 1, -40)
FPS.BackgroundTransparency = 1
FPS.Text = "60 FPS"
FPS.TextColor3 = Color3.fromRGB(180, 150, 200)
FPS.TextSize = 13
FPS.Font = Enum.Font.GothamMedium
FPS.TextXAlignment = Enum.TextXAlignment.Right
FPS.TextYAlignment = Enum.TextYAlignment.Bottom

local fc = 0
local ft = tick()
RunService.RenderStepped:Connect(function()
    fc = fc + 1
    if tick() - ft >= 1 then
        FPS.Text = fc .. " FPS"
        fc = 0
        ft = tick()
    end
end)

_G.Zertyx = {
    ToggleMenu = function() MainFrame.Visible = not MainFrame.Visible end
}

print("ZERTYX v3.7 LOADED!")
print("Press ≡ to open menu")
print("ESP: ON | Big Head: OFF | Rainbow Aura: OFF | Atmosphere: OFF")
