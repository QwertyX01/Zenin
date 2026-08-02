-- Zertyx CHEAT v5.9 - SAFE MODE
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- НАСТРОЙКИ
local ESPEnabled = true
local BigHeadEnabled = false
local FOVEnabled = false
local GrenadeTrackerEnabled = false
local FOVValue = 120

-- Хранилища объектов
local espObjects = {}
local bigHeadObjects = {}
local originalFOV = nil
local grenadeData = {}

-- УДАЛЯЕМ СТАРОЕ МЕНЮ (безопасно)
pcall(function()
    LocalPlayer.PlayerGui:FindFirstChild("Zertyx"):Destroy()
end)

-- === GUI ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "Zertyx"
ScreenGui.ResetOnSpawn = false

-- === ОСНОВНОЙ ФРЕЙМ ===
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 640, 0, 420)
MainFrame.Position = UDim2.new(0.5, -320, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 0
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false

local MainCorner = Instance.new("UICorner")
MainCorner.Parent = MainFrame
MainCorner.CornerRadius = UDim.new(0, 24)

local Shadow = Instance.new("ImageLabel")
Shadow.Parent = MainFrame
Shadow.Size = UDim2.new(1, 20, 1, 20)
Shadow.Position = UDim2.new(0, -10, 0, -10)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1317777270"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.5

-- === ВЕРХНЯЯ ПАНЕЛЬ ===
local Header = Instance.new("Frame")
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 48)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Header.BackgroundTransparency = 0
Header.BorderSizePixel = 0

local BottomLine = Instance.new("Frame")
BottomLine.Parent = Header
BottomLine.Size = UDim2.new(1, 0, 0, 1)
BottomLine.Position = UDim2.new(0, 0, 1, 0)
BottomLine.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
BottomLine.BorderSizePixel = 0

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 16, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Zertyx"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextSize = 28
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextYAlignment = Enum.TextYAlignment.Center

local Version = Instance.new("TextLabel")
Version.Parent = Header
Version.Size = UDim2.new(0, 50, 0, 20)
Version.Position = UDim2.new(0, 120, 0, 28)
Version.BackgroundTransparency = 1
Version.Text = "v5.9"
Version.TextColor3 = Color3.fromRGB(150, 150, 150)
Version.TextSize = 12
Version.Font = Enum.Font.GothamMedium
Version.TextXAlignment = Enum.TextXAlignment.Left
Version.TextYAlignment = Enum.TextYAlignment.Top

-- === ВКЛАДКИ С АНИМАЦИЕЙ ===
local TabContainer = Instance.new("Frame")
TabContainer.Parent = MainFrame
TabContainer.Size = UDim2.new(1, 0, 0, 40)
TabContainer.Position = UDim2.new(0, 0, 0, 48)
TabContainer.BackgroundTransparency = 1
TabContainer.BorderSizePixel = 0

local tabs = {"Visuals", "Aim", "Misc"}
local tabBtns = {}
local tabContents = {}

for i = 1, 3 do
    local btn = Instance.new("TextButton")
    btn.Parent = TabContainer
    btn.Size = UDim2.new(0, 80, 0, 30)
    btn.Position = UDim2.new(0, 16 + (i-1) * 90, 0.5, -15)
    btn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    btn.BackgroundTransparency = 0
    btn.BorderSizePixel = 0
    btn.Text = string.upper(tabs[i])
    btn.TextColor3 = Color3.fromRGB(80, 80, 80)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamMedium
    btn.AutoButtonColor = false

    local corner = Instance.new("UICorner")
    corner.Parent = btn
    corner.CornerRadius = UDim.new(0, 16)

    local content = Instance.new("ScrollingFrame")
    content.Parent = MainFrame
    content.Size = UDim2.new(1, -20, 1, -100)
    content.Position = UDim2.new(0, 10, 0, 96)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.Visible = (i == 1)
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.ScrollBarThickness = 4
    content.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200)
    content.Name = tabs[i] .. "Content"

    tabBtns[tabs[i]] = btn
    tabContents[tabs[i]] = content

    btn.MouseButton1Click:Connect(function()
        for name, b in pairs(tabBtns) do
            local tween = TweenService:Create(b, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(240, 240, 240),
                TextColor3 = Color3.fromRGB(80, 80, 80)
            })
            tween:Play()
            TabContents[name].Visible = false
        end
        local tween = TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = Color3.fromRGB(200, 200, 200),
            TextColor3 = Color3.fromRGB(0, 0, 0)
        })
        tween:Play()
        content.Visible = true
    end)
end

if tabBtns["Visuals"] then
    tabBtns["Visuals"].BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    tabBtns["Visuals"].TextColor3 = Color3.fromRGB(0, 0, 0)
end

-- === UI ЭЛЕМЕНТЫ ===
local function CreateToggleRow(parent, label, defaultState, callback, yPos)
    local row = Instance.new("Frame")
    row.Parent = parent
    row.Size = UDim2.new(1, -10, 0, 40)
    row.Position = UDim2.new(0, 5, 0, yPos)
    row.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    row.BackgroundTransparency = 0
    row.BorderSizePixel = 0

    local rowCorner = Instance.new("UICorner")
    rowCorner.Parent = row
    rowCorner.CornerRadius = UDim.new(0, 12)

    local labelText = Instance.new("TextLabel")
    labelText.Parent = row
    labelText.Size = UDim2.new(0, 180, 1, 0)
    labelText.Position = UDim2.new(0, 12, 0, 0)
    labelText.BackgroundTransparency = 1
    labelText.Text = label
    labelText.TextColor3 = Color3.fromRGB(40, 40, 40)
    labelText.TextSize = 14
    labelText.Font = Enum.Font.GothamMedium
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.TextYAlignment = Enum.TextYAlignment.Center

    local toggle = Instance.new("TextButton")
    toggle.Parent = row
    toggle.Size = UDim2.new(0, 30, 0, 30)
    toggle.Position = UDim2.new(1, -40, 0.5, -15)
    toggle.BackgroundColor3 = defaultState and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(200, 200, 200)
    toggle.BackgroundTransparency = 0
    toggle.BorderSizePixel = 0
    toggle.Text = defaultState and "✓" or ""
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.TextSize = 18
    toggle.Font = Enum.Font.GothamBold
    toggle.AutoButtonColor = false

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.Parent = toggle
    toggleCorner.CornerRadius = UDim.new(0, 6)

    local state = defaultState
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = state and "✓" or ""
        toggle.BackgroundColor3 = state and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(200, 200, 200)
        if callback then callback(state) end
    end)

    return row, toggle
end

local function CreateSlider(parent, label, minVal, maxVal, defaultVal, callback, yPos)
    local row = Instance.new("Frame")
    row.Parent = parent
    row.Size = UDim2.new(1, -10, 0, 40)
    row.Position = UDim2.new(0, 5, 0, yPos)
    row.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    row.BackgroundTransparency = 0
    row.BorderSizePixel = 0

    local rowCorner = Instance.new("UICorner")
    rowCorner.Parent = row
    rowCorner.CornerRadius = UDim.new(0, 12)

    local labelText = Instance.new("TextLabel")
    labelText.Parent = row
    labelText.Size = UDim2.new(0, 100, 1, 0)
    labelText.Position = UDim2.new(0, 12, 0, 0)
    labelText.BackgroundTransparency = 1
    labelText.Text = label
    labelText.TextColor3 = Color3.fromRGB(40, 40, 40)
    labelText.TextSize = 14
    labelText.Font = Enum.Font.GothamMedium
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.TextYAlignment = Enum.TextYAlignment.Center

    local sliderFrame = Instance.new("Frame")
    sliderFrame.Parent = row
    sliderFrame.Size = UDim2.new(0, 120, 0, 6)
    sliderFrame.Position = UDim2.new(0, 120, 0.5, -3)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    sliderFrame.BorderSizePixel = 0

    local sliderCorner = Instance.new("UICorner")
    sliderCorner.Parent = sliderFrame
    sliderCorner.CornerRadius = UDim.new(0, 10)

    local fill = Instance.new("Frame")
    fill.Parent = sliderFrame
    fill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    fill.BorderSizePixel = 0

    local fillCorner = Instance.new("UICorner")
    fillCorner.Parent = fill
    fillCorner.CornerRadius = UDim.new(0, 10)

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Parent = row
    valueLabel.Size = UDim2.new(0, 30, 0, 20)
    valueLabel.Position = UDim2.new(0, 250, 0.5, -10)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(defaultVal)
    valueLabel.TextColor3 = Color3.fromRGB(40, 40, 40)
    valueLabel.TextSize = 13
    valueLabel.Font = Enum.Font.GothamMedium

    local dragging = false
    local currentVal = defaultVal

    sliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    sliderFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    sliderFrame.MouseMoved:Connect(function()
        if dragging then
            local mousePos = LocalPlayer:GetMouse().X
            local absPos = sliderFrame.AbsolutePosition.X
            local width = sliderFrame.AbsoluteSize.X
            local percent = math.clamp((mousePos - absPos) / width, 0, 1)
            local val = math.round(minVal + (maxVal - minVal) * percent)
            currentVal = val
            fill.Size = UDim2.new(percent, 0, 1, 0)
            valueLabel.Text = tostring(val)
            if callback then callback(val) end
        end
    end)

    return row
end

-- === НАПОЛНЕНИЕ VISUALS ===
local visualsContent = tabContents["Visuals"]
local yPos = 10

CreateToggleRow(visualsContent, "ESP", ESPEnabled, function(state)
    ESPEnabled = state
    if state then UpdateESP() else ClearESP() end
end, yPos)
yPos = yPos + 50

CreateToggleRow(visualsContent, "Big Head", BigHeadEnabled, function(state)
    BigHeadEnabled = state
    if state then UpdateBigHead() else ClearBigHead() end
end, yPos)
yPos = yPos + 50

local fovRow, fovToggle = CreateToggleRow(visualsContent, "FOV", FOVEnabled, function(state)
    FOVEnabled = state
    if state then 
        fovSlider.Visible = true
        originalFOV = originalFOV or Camera.FieldOfView
        Camera.FieldOfView = FOVValue
    else 
        fovSlider.Visible = false
        if originalFOV then Camera.FieldOfView = originalFOV end
    end
end, yPos)
yPos = yPos + 50

local fovSlider = CreateSlider(visualsContent, "FOV Value", 70, 120, FOVValue, function(val)
    FOVValue = val
    if FOVEnabled then Camera.FieldOfView = FOVValue end
end, yPos)
fovSlider.Visible = false
yPos = yPos + 50

local grenadeRow, grenadeToggle = CreateToggleRow(visualsContent, "Trajectory Grenades", GrenadeTrackerEnabled, function(state)
    GrenadeTrackerEnabled = state
    if state then StartGrenadeTracking() else StopGrenadeTracking() end
end, yPos)
yPos = yPos + 50

visualsContent.CanvasSize = UDim2.new(0, 0, 0, yPos + 20)

-- === MISC TAB (пусто) ===
local miscContent = tabContents["Misc"]
local miscLabel = Instance.new("TextLabel")
miscLabel.Parent = miscContent
miscLabel.Size = UDim2.new(1, 0, 1, 0)
miscLabel.Position = UDim2.new(0, 0, 0, 0)
miscLabel.BackgroundTransparency = 1
miscLabel.Text = "MISC TAB"
miscLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
miscLabel.TextSize = 24
miscLabel.Font = Enum.Font.GothamBold
miscLabel.TextXAlignment = Enum.TextXAlignment.Center
miscLabel.TextYAlignment = Enum.TextYAlignment.Center

-- === TRACK GRENADES ===
local grenadeTracked = {}

local function GetGrenadeType(obj)
    local name = obj.Name:lower()
    if name:find("grenade") then return "Grenade"
    elseif name:find("molotov") then return "Molotov"
    elseif name:find("flash") then return "Flash"
    else return nil end
end

local function CreateGrenadeUI(grenade)
    local billboard = Instance.new("BillboardGui")
    billboard.Parent = grenade
    billboard.Size = UDim2.new(0, 60, 0, 60)
    billboard.Adornee = grenade
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 0, 0)
    billboard.MaxDistance = 500

    local whiteCircle = Instance.new("Frame")
    whiteCircle.Parent = billboard
    whiteCircle.Size = UDim2.new(1, 0, 1, 0)
    whiteCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    whiteCircle.BackgroundTransparency = 0
    whiteCircle.BorderSizePixel = 0
    whiteCircle.ZIndex = 1
    local wc = Instance.new("UICorner"); wc.Parent = whiteCircle; wc.CornerRadius = UDim.new(1, 0)

    local blackCircle = Instance.new("Frame")
    blackCircle.Parent = whiteCircle
    blackCircle.Size = UDim2.new(0.85, 0, 0.85, 0)
    blackCircle.Position = UDim2.new(0.075, 0, 0.075, 0)
    blackCircle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blackCircle.BackgroundTransparency = 0
    blackCircle.BorderSizePixel = 0
    blackCircle.ZIndex = 2
    local bc = Instance.new("UICorner"); bc.Parent = blackCircle; bc.CornerRadius = UDim.new(1, 0)

    local label = Instance.new("TextLabel")
    label.Parent = blackCircle
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = GetGrenadeType(grenade) or "?"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center

    return billboard
end

local function StartGrenadeTracking()
    StopGrenadeTracking()
    RunService.Heartbeat:Connect(function()
        if not GrenadeTrackerEnabled then return end
        pcall(function()
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and not obj:IsA("Terrain") then
                    local gType = GetGrenadeType(obj)
                    if gType and obj.Parent and obj.Parent:IsA("Model") and not obj.Parent:FindFirstChild("Humanoid") then
                        if not grenadeTracked[obj] then
                            grenadeTracked[obj] = {billboard = CreateGrenadeUI(obj)}
                        end
                    end
                end
            end
            for grenade, data in pairs(grenadeTracked) do
                if not grenade.Parent or not grenade:IsDescendantOf(workspace) then
                    if data.billboard then data.billboard:Destroy() end
                    grenadeTracked[grenade] = nil
                end
            end
        end)
    end)
end

local function StopGrenadeTracking()
    for _, data in pairs(grenadeTracked) do
        if data.billboard then data.billboard:Destroy() end
    end
    grenadeTracked = {}
end

-- === ESP (защищено) ===
function CreateESP(targetPlayer)
    pcall(function()
        if espObjects[targetPlayer] then espObjects[targetPlayer]:Destroy() end
        if not targetPlayer.Character then return end
        local highlight = Instance.new("Highlight")
        highlight.Parent = targetPlayer.Character
        highlight.FillColor = Color3.fromRGB(50, 150, 255)
        highlight.FillTransparency = 0.3
        highlight.OutlineColor = Color3.fromRGB(100, 200, 255)
        highlight.OutlineTransparency = 0.1
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        espObjects[targetPlayer] = highlight
    end)
end

function RemoveESP(targetPlayer)
    pcall(function()
        if espObjects[targetPlayer] then
            espObjects[targetPlayer]:Destroy()
            espObjects[targetPlayer] = nil
        end
    end)
end

function UpdateESP()
    pcall(function()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if ESPEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    CreateESP(player)
                else
                    RemoveESP(player)
                end
            end
        end
    end)
end

function ClearESP()
    pcall(function()
        for _, obj in pairs(espObjects) do obj:Destroy() end
        espObjects = {}
    end)
end

-- === BIG HEAD (защищено) ===
function CreateBigHead(targetPlayer)
    pcall(function()
        if bigHeadObjects[targetPlayer] then bigHeadObjects[targetPlayer]:Destroy() end
        if not targetPlayer.Character then return end
        local head = targetPlayer.Character:FindFirstChild("Head")
        if not head then return end
        if not head:GetAttribute("OriginalSize") then
            head:SetAttribute("OriginalSize", head.Size)
        end
        head.Size = head.Size * 2
        bigHeadObjects[targetPlayer] = head
    end)
end

function RemoveBigHead(targetPlayer)
    pcall(function()
        if bigHeadObjects[targetPlayer] then
            local head = bigHeadObjects[targetPlayer]
            local originalSize = head:GetAttribute("OriginalSize")
            if originalSize then head.Size = originalSize end
            head:SetAttribute("OriginalSize", nil)
            bigHeadObjects[targetPlayer] = nil
        end
    end)
end

function UpdateBigHead()
    pcall(function()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if BigHeadEnabled and player.Character then
                    local head = player.Character:FindFirstChild("Head")
                    if head and not bigHeadObjects[player] then
                        CreateBigHead(player)
                    end
                else
                    RemoveBigHead(player)
                end
            end
        end
    end)
end

function ClearBigHead()
    pcall(function()
        for _, head in pairs(bigHeadObjects) do
            local originalSize = head:GetAttribute("OriginalSize")
            if originalSize then head.Size = originalSize end
            head:SetAttribute("OriginalSize", nil)
        end
        bigHeadObjects = {}
    end)
end

-- === ОБНОВЛЕНИЯ ===
RunService.RenderStepped:Connect(function()
    if FOVEnabled then pcall(function() Camera.FieldOfView = FOVValue end) end
end)

RunService.Heartbeat:Connect(function()
    if ESPEnabled then UpdateESP() end
    if BigHeadEnabled then UpdateBigHead() end
end)

-- === СОБЫТИЯ ===
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(0.3)
        if ESPEnabled then UpdateESP() end
        if BigHeadEnabled then UpdateBigHead() end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
    RemoveBigHead(player)
end)

UpdateESP()
UpdateBigHead()

-- === ОТКРЫТИЕ МЕНЮ ===
local OpenBtn = Instance.new("TextButton")
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 50, 0, 30)
OpenBtn.Position = UDim2.new(0, 10, 0, 10)
OpenBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
OpenBtn.BackgroundTransparency = 0
OpenBtn.BorderSizePixel = 0
OpenBtn.Text = "≡"
OpenBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
OpenBtn.TextSize = 22
OpenBtn.Font = Enum.Font.GothamBold

local OpenCorner = Instance.new("UICorner")
OpenCorner.Parent = OpenBtn
OpenCorner.CornerRadius = UDim.new(0, 30)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- === WATERMARK + FPS ===
local Watermark = Instance.new("TextLabel")
Watermark.Parent = ScreenGui
Watermark.Size = UDim2.new(0, 200, 0, 30)
Watermark.Position = UDim2.new(0, 10, 1, -40)
Watermark.BackgroundTransparency = 1
Watermark.Text = "Zertyx v5.9 | BloxStrike"
Watermark.TextColor3 = Color3.fromRGB(150, 150, 150)
Watermark.TextSize = 13
Watermark.Font = Enum.Font.GothamBold
Watermark.TextXAlignment = Enum.TextXAlignment.Left
Watermark.TextYAlignment = Enum.TextYAlignment.Bottom

local FPS = Instance.new("TextLabel")
FPS.Parent = ScreenGui
FPS.Size = UDim2.new(0, 60, 0, 30)
FPS.Position = UDim2.new(1, -70, 1, -40)
FPS.BackgroundTransparency = 1
FPS.Text = "60 FPS"
FPS.TextColor3 = Color3.fromRGB(150, 150, 150)
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

print("ZERTYX v5.9 LOADED!")
print("Press ≡ to open menu")
print("ESP: ON | Big Head: OFF | FOV: OFF | Trajectory Grenades: OFF")
