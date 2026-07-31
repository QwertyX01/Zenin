-- Zertyx CHEAT v3.8 - CHROMATIC HAT
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Lighting = game:GetService("Lighting")

-- НАСТРОЙКИ
local ESPEnabled = true
local BigHeadEnabled = false
local AtmosphereEnabled = false
local HatEnabled = false
local HatColor = Color3.fromRGB(255, 0, 0) -- Красный по умолчанию
local SelectedAtmoColor = Color3.fromRGB(150, 50, 200)
local espObjects = {}
local bigHeadObjects = {}
local hatObjects = {}
local originalGuiColor = nil

-- === ГЛАВНОЕ МЕНЮ ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "Zertyx"
ScreenGui.ResetOnSpawn = false

-- === МЕНЮ (ФИОЛЕТОВОЕ) ===
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

-- CHROMATIC HAT TOGGLE
CreateToggleRow(visualsContent, "Chromatic Hat", HatEnabled, function(state)
    HatEnabled = state
    if state then 
        UpdateHat()
        colorPickerHat.Visible = true
        colorPickerHatFrame.Visible = true
    else 
        ClearHat()
        colorPickerHat.Visible = false
        colorPickerHatFrame.Visible = false
    end
end, yPos)
yPos = yPos + 50

-- === ПАЛИТРА ДЛЯ ШЛЯПЫ ===
local colorPickerHatFrame = Instance.new("Frame")
colorPickerHatFrame.Parent = visualsContent
colorPickerHatFrame.Size = UDim2.new(1, -20, 0, 40)
colorPickerHatFrame.Position = UDim2.new(0, 10, 0, yPos)
colorPickerHatFrame.BackgroundColor3 = Color3.fromRGB(50, 30, 65)
colorPickerHatFrame.BackgroundTransparency = 0.5
colorPickerHatFrame.BorderSizePixel = 0
colorPickerHatFrame.Visible = false

local colorPickerHatCorner = Instance.new("UICorner")
colorPickerHatCorner.Parent = colorPickerHatFrame
colorPickerHatCorner.CornerRadius = UDim.new(0, 8)

local hatColors = {
    {Color3.fromRGB(255, 0, 0), "Red"},
    {Color3.fromRGB(0, 255, 0), "Green"},
    {Color3.fromRGB(0, 150, 255), "Blue"},
    {Color3.fromRGB(255, 255, 0), "Yellow"},
    {Color3.fromRGB(255, 0, 255), "Purple"},
    {Color3.fromRGB(255, 100, 0), "Orange"},
    {Color3.fromRGB(0, 255, 255), "Cyan"},
    {Color3.fromRGB(255, 200, 255), "Pink"}
}

local hatColorButtons = {}
local hatColorPicker = Instance.new("Frame")
hatColorPicker.Parent = colorPickerHatFrame
hatColorPicker.Size = UDim2.new(1, 0, 1, 0)
hatColorPicker.BackgroundTransparency = 1

for i = 1, #hatColors do
    local colorBtn = Instance.new("TextButton")
    colorBtn.Parent = hatColorPicker
    colorBtn.Size = UDim2.new(0, 30, 0, 30)
    colorBtn.Position = UDim2.new(0, 10 + (i-1) * 40, 0.5, -15)
    colorBtn.BackgroundColor3 = hatColors[i][1]
    colorBtn.BackgroundTransparency = 0
    colorBtn.BorderSizePixel = 0
    colorBtn.Text = ""
    colorBtn.AutoButtonColor = false
    
    local colorCorner = Instance.new("UICorner")
    colorCorner.Parent = colorBtn
    colorCorner.CornerRadius = UDim.new(0, 6)
    
    if hatColors[i][1] == HatColor then
        colorBtn.BorderSizePixel = 2
        colorBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    end
    
    colorBtn.MouseButton1Click:Connect(function()
        HatColor = hatColors[i][1]
        if HatEnabled then
            ClearHat()
            UpdateHat()
        end
        for _, btn in pairs(hatColorButtons) do
            btn.BorderSizePixel = 0
        end
        colorBtn.BorderSizePixel = 2
        colorBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    hatColorButtons[i] = colorBtn
end
yPos = yPos + 50

-- ATMOSPHERE TOGGLE
CreateToggleRow(visualsContent, "Atmosphere", AtmosphereEnabled, function(state)
    AtmosphereEnabled = state
    if state then 
        ApplyCloudColor(SelectedAtmoColor)
        ApplyGUIStyle(true)
        colorPickerAtmo.Visible = true
        colorPickerAtmoFrame.Visible = true
    else 
        ResetAtmosphere()
        colorPickerAtmo.Visible = false
        colorPickerAtmoFrame.Visible = false
    end
end, yPos)
yPos = yPos + 50

-- === ПАЛИТРА ДЛЯ ATMOSPHERE ===
local colorPickerAtmoFrame = Instance.new("Frame")
colorPickerAtmoFrame.Parent = visualsContent
colorPickerAtmoFrame.Size = UDim2.new(1, -20, 0, 40)
colorPickerAtmoFrame.Position = UDim2.new(0, 10, 0, yPos)
colorPickerAtmoFrame.BackgroundColor3 = Color3.fromRGB(50, 30, 65)
colorPickerAtmoFrame.BackgroundTransparency = 0.5
colorPickerAtmoFrame.BorderSizePixel = 0
colorPickerAtmoFrame.Visible = false

local colorPickerAtmoCorner = Instance.new("UICorner")
colorPickerAtmoCorner.Parent = colorPickerAtmoFrame
colorPickerAtmoCorner.CornerRadius = UDim.new(0, 8)

local atmoColors = {
    {Color3.fromRGB(150, 50, 200), "Purple"},
    {Color3.fromRGB(200, 100, 255), "Lavender"},
    {Color3.fromRGB(100, 50, 200), "Deep Purple"},
    {Color3.fromRGB(255, 100, 200), "Pink"},
    {Color3.fromRGB(50, 150, 255), "Blue"},
    {Color3.fromRGB(200, 50, 100), "Red"},
    {Color3.fromRGB(0, 200, 255), "Cyan"},
    {Color3.fromRGB(255, 150, 50), "Orange"}
}

local atmoColorButtons = {}
local atmoColorPicker = Instance.new("Frame")
atmoColorPicker.Parent = colorPickerAtmoFrame
atmoColorPicker.Size = UDim2.new(1, 0, 1, 0)
atmoColorPicker.BackgroundTransparency = 1

for i = 1, #atmoColors do
    local colorBtn = Instance.new("TextButton")
    colorBtn.Parent = atmoColorPicker
    colorBtn.Size = UDim2.new(0, 30, 0, 30)
    colorBtn.Position = UDim2.new(0, 10 + (i-1) * 40, 0.5, -15)
    colorBtn.BackgroundColor3 = atmoColors[i][1]
    colorBtn.BackgroundTransparency = 0
    colorBtn.BorderSizePixel = 0
    colorBtn.Text = ""
    colorBtn.AutoButtonColor = false
    
    local colorCorner = Instance.new("UICorner")
    colorCorner.Parent = colorBtn
    colorCorner.CornerRadius = UDim.new(0, 6)
    
    if atmoColors[i][1] == SelectedAtmoColor then
        colorBtn.BorderSizePixel = 2
        colorBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    end
    
    colorBtn.MouseButton1Click:Connect(function()
        SelectedAtmoColor = atmoColors[i][1]
        if AtmosphereEnabled then
            ApplyCloudColor(SelectedAtmoColor)
            ApplyGUIStyle(true)
        end
        for _, btn in pairs(atmoColorButtons) do
            btn.BorderSizePixel = 0
        end
        colorBtn.BorderSizePixel = 2
        colorBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    atmoColorButtons[i] = colorBtn
end

-- === HAT ФУНКЦИИ (ТАКАЯ ЖЕ ШЛЯПА КАК НА ФОТО) ===
function CreateHat(player)
    if hatObjects[player] then
        for _, obj in pairs(hatObjects[player]) do
            obj:Destroy()
        end
        hatObjects[player] = nil
    end
    
    if not player.Character then return end
    local head = player.Character:FindFirstChild("Head")
    if not head then return end
    
    -- Создаем BillboardGui
    local billboard = Instance.new("BillboardGui")
    billboard.Parent = head
    billboard.Size = UDim2.new(0, 80, 0, 80)
    billboard.Adornee = head
    billboard.StudsOffset = Vector3.new(0, 3.5, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 500
    
    -- Основная шляпа (круг с градиентом)
    local hat = Instance.new("Frame")
    hat.Parent = billboard
    hat.Size = UDim2.new(1, 0, 1, 0)
    hat.BackgroundColor3 = HatColor
    hat.BackgroundTransparency = 0.2
    hat.BorderSizePixel = 0
    
    local hatCorner = Instance.new("UICorner")
    hatCorner.Parent = hat
    hatCorner.CornerRadius = UDim.new(0, 40) -- Круглая шляпа
    
    -- Свечение
    local glow = Instance.new("ImageLabel")
    glow.Parent = hat
    glow.Size = UDim2.new(1.8, 0, 1.8, 0)
    glow.Position = UDim2.new(-0.4, 0, -0.4, 0)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://13063196338"
    glow.ImageColor3 = HatColor
    glow.ImageTransparency = 0.3
    
    -- Ободок шляпы (второй круг)
    local rim = Instance.new("Frame")
    rim.Parent = hat
    rim.Size = UDim2.new(0.8, 0, 0.8, 0)
    rim.Position = UDim2.new(0.1, 0, 0.1, 0)
    rim.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    rim.BackgroundTransparency = 0.8
    rim.BorderSizePixel = 0
    
    local rimCorner = Instance.new("UICorner")
    rimCorner.Parent = rim
    rimCorner.CornerRadius = UDim.new(0, 40)
    
    -- Радужный градиент (как на фото)
    local gradient = Instance.new("UIGradient")
    gradient.Parent = hat
    gradient.Rotation = 45
    local gradColors = {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
    }
    gradient.Color = ColorSequence.new(gradColors)
    
    -- Храним все объекты
    hatObjects[player] = {billboard, hat, glow, rim, gradient}
end

function RemoveHat(player)
    if hatObjects[player] then
        for _, obj in pairs(hatObjects[player]) do
            obj:Destroy()
        end
        hatObjects[player] = nil
    end
end

function UpdateHat()
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= LocalPlayer then
            if HatEnabled and targetPlayer.Character then
                local head = targetPlayer.Character:FindFirstChild("Head")
                if head and not hatObjects[targetPlayer] then
                    CreateHat(targetPlayer)
                end
            else
                RemoveHat(targetPlayer)
            end
        end
    end
end

function ClearHat()
    for player, objects in pairs(hatObjects) do
        for _, obj in pairs(objects) do
            obj:Destroy()
        end
    end
    hatObjects = {}
end

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
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= LocalPlayer then
            if ESPEnabled and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                CreateESP(targetPlayer)
            else
                RemoveESP(targetPlayer)
            end
        end
    end
    
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
    
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= LocalPlayer then
            if HatEnabled and targetPlayer.Character then
                local head = targetPlayer.Character:FindFirstChild("Head")
                if head and not hatObjects[targetPlayer] then
                    CreateHat(targetPlayer)
                end
            else
                RemoveHat(targetPlayer)
            end
        end
    end
end)

-- === СОБЫТИЯ ===
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        UpdateESP()
        UpdateBigHead()
        UpdateHat()
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
    RemoveBigHead(player)
    RemoveHat(player)
end)

-- === ЗАПУСК ===
UpdateESP()
UpdateBigHead()
UpdateHat()

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
Watermark.Text = "Zertyx v3.8 | BloxStrike"
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

print("ZERTYX v3.8 LOADED!")
print("Press ≡ to open menu")
print("ESP: ON | Big Head: OFF | Chromatic Hat: OFF | Atmosphere: OFF")
