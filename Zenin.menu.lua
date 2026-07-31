--[[
    Zertyx - BloxStrike Menu (ESP + Skeleton)
    Version: 1.4
    Size: 640x420
    Open: Button ≡ in top-left corner
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- === ESP STORAGE ===
local espObjects = {}
local skeletonObjects = {}
local nameObjects = {}
local espEnabled = true
local skeletonEnabled = false
local nameEnabled = true

-- === CONFIG ===
local ZertyxConfig = {
    MenuSize = UDim2.new(0, 640, 0, 420),
    MenuPosition = UDim2.new(0.5, -320, 0.5, -210),
    Theme = {
        Background = Color3.fromRGB(18, 22, 30),
        Primary = Color3.fromRGB(59, 77, 102),
        Accent = Color3.fromRGB(79, 124, 176),
        Text = Color3.fromRGB(191, 209, 232),
        TextBright = Color3.fromRGB(255, 255, 255),
        Border = Color3.fromRGB(42, 52, 64)
    }
}

-- === CREATE GUI ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "Zertyx"
ScreenGui.ResetOnSpawn = false

-- === MAIN FRAME ===
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = ZertyxConfig.MenuSize
MainFrame.Position = ZertyxConfig.MenuPosition
MainFrame.BackgroundColor3 = ZertyxConfig.Theme.Background
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false

local MainCorner = Instance.new("UICorner")
MainCorner.Parent = MainFrame
MainCorner.CornerRadius = UDim.new(0, 20)

-- === OPEN BUTTON (TOP-LEFT) ===
local OpenButton = Instance.new("TextButton")
OpenButton.Parent = ScreenGui
OpenButton.Size = UDim2.new(0, 50, 0, 30)
OpenButton.Position = UDim2.new(0, 10, 0, 10)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 40, 55)
OpenButton.BackgroundTransparency = 0.2
OpenButton.BorderSizePixel = 0
OpenButton.Text = "≡"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.TextSize = 22
OpenButton.Font = Enum.Font.GothamBold

local OpenCorner = Instance.new("UICorner")
OpenCorner.Parent = OpenButton
OpenCorner.CornerRadius = UDim.new(0, 30)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- === TITLE BAR ===
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, -24, 0, 32)
TitleBar.Position = UDim2.new(0, 12, 0, 8)
TitleBar.BackgroundTransparency = 1

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.Size = UDim2.new(0, 100, 1, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "ZERTYX"
TitleText.TextColor3 = Color3.fromRGB(106, 147, 199)
TitleText.TextSize = 18
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.TextYAlignment = Enum.TextYAlignment.Center

local VersionText = Instance.new("TextLabel")
VersionText.Parent = TitleBar
VersionText.Size = UDim2.new(0, 50, 1, 0)
VersionText.Position = UDim2.new(0, 105, 0, 0)
VersionText.BackgroundTransparency = 1
VersionText.Text = "v1.4"
VersionText.TextColor3 = Color3.fromRGB(100, 120, 150)
VersionText.TextSize = 12
VersionText.Font = Enum.Font.GothamMedium
VersionText.TextXAlignment = Enum.TextXAlignment.Left
VersionText.TextYAlignment = Enum.TextYAlignment.Center

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TitleBar
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -28, 0, 2)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseBtn.BackgroundTransparency = 0.3
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold

local CloseCorner = Instance.new("UICorner")
CloseCorner.Parent = CloseBtn
CloseCorner.CornerRadius = UDim.new(0, 30)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- === TABS ===
local TabsContainer = Instance.new("Frame")
TabsContainer.Parent = MainFrame
TabsContainer.Size = UDim2.new(1, -24, 0, 38)
TabsContainer.Position = UDim2.new(0, 12, 0, 44)
TabsContainer.BackgroundTransparency = 1

local TabButtons = {}
local TabContents = {}

local function CreateTab(tabName)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = TabsContainer
    TabBtn.Size = UDim2.new(0, 85, 1, 0)
    TabBtn.Position = UDim2.new(0, (#TabButtons) * 90, 0, 0)
    TabBtn.BackgroundColor3 = ZertyxConfig.Theme.Primary
    TabBtn.BackgroundTransparency = 0.7
    TabBtn.BorderSizePixel = 0
    TabBtn.Text = tabName:upper()
    TabBtn.TextColor3 = ZertyxConfig.Theme.Text
    TabBtn.TextSize = 13
    TabBtn.Font = Enum.Font.GothamMedium
    TabBtn.AutoButtonColor = false
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.Parent = TabBtn
    TabCorner.CornerRadius = UDim.new(0, 30)
    
    TabBtn.MouseEnter:Connect(function()
        if TabBtn.BackgroundTransparency > 0.3 then
            TabBtn.BackgroundTransparency = 0.4
        end
    end)
    TabBtn.MouseLeave:Connect(function()
        if TabBtn.BackgroundTransparency > 0.3 then
            TabBtn.BackgroundTransparency = 0.7
        end
    end)
    
    local Content = Instance.new("ScrollingFrame")
    Content.Parent = MainFrame
    Content.Size = UDim2.new(1, -24, 1, -110)
    Content.Position = UDim2.new(0, 12, 0, 88)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.Visible = (tabName == "Visuals")
    Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    Content.ScrollBarThickness = 4
    Content.ScrollBarImageColor3 = ZertyxConfig.Theme.Primary
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
            btn.BackgroundTransparency = 0.7
            btn.TextColor3 = ZertyxConfig.Theme.Text
            TabContents[name].Visible = false
        end
        TabBtn.BackgroundTransparency = 0.2
        TabBtn.TextColor3 = ZertyxConfig.Theme.TextBright
        Content.Visible = true
    end)
end

-- === SQUARE TOGGLE ===
local function CreateSquareToggle(row, defaultState, callback)
    local Toggle = Instance.new("TextButton")
    Toggle.Parent = row
    Toggle.Size = UDim2.new(0, 32, 0, 32)
    Toggle.Position = UDim2.new(0, row.Size.X.Offset - 42, 0.5, -16)
    Toggle.BackgroundColor3 = defaultState and ZertyxConfig.Theme.Accent or Color3.fromRGB(40, 40, 50)
    Toggle.BorderSizePixel = 0
    Toggle.Text = defaultState and "✓" or ""
    Toggle.TextColor3 = ZertyxConfig.Theme.TextBright
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
        Toggle.BackgroundColor3 = state and ZertyxConfig.Theme.Accent or Color3.fromRGB(40, 40, 50)
        if callback then callback(state) end
    end)
    
    return Toggle, function() return state end
end

-- === CREATE ROW ===
local function CreateRow(parent, label, yPos)
    local Row = Instance.new("Frame")
    Row.Parent = parent
    Row.Size = UDim2.new(1, -10, 0, 42)
    Row.Position = UDim2.new(0, 5, 0, yPos)
    Row.BackgroundColor3 = ZertyxConfig.Theme.Primary
    Row.BackgroundTransparency = 0.85
    Row.BorderSizePixel = 0
    
    local RowCorner = Instance.new("UICorner")
    RowCorner.Parent = Row
    RowCorner.CornerRadius = UDim.new(0, 12)
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Row
    Label.Size = UDim2.new(0, 140, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = label
    Label.TextColor3 = ZertyxConfig.Theme.Text
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextYAlignment = Enum.TextYAlignment.Center
    
    return Row
end

-- === SLIDER ===
local function CreateSlider(row, minVal, maxVal, defaultVal, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Parent = row
    SliderFrame.Size = UDim2.new(0, 150, 0, 6)
    SliderFrame.Position = UDim2.new(0, row.Size.X.Offset - 200, 0.5, -3)
    SliderFrame.BackgroundColor3 = ZertyxConfig.Theme.Border
    SliderFrame.BorderSizePixel = 0
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.Parent = SliderFrame
    SliderCorner.CornerRadius = UDim.new(0, 10)
    
    local Fill = Instance.new("Frame")
    Fill.Parent = SliderFrame
    Fill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    Fill.BackgroundColor3 = ZertyxConfig.Theme.Accent
    Fill.BorderSizePixel = 0
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.Parent = Fill
    FillCorner.CornerRadius = UDim.new(0, 10)
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Parent = row
    ValueLabel.Size = UDim2.new(0, 40, 0, 20)
    ValueLabel.Position = UDim2.new(0, row.Size.X.Offset - 50, 0.5, -10)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(defaultVal)
    ValueLabel.TextColor3 = ZertyxConfig.Theme.Text
    ValueLabel.TextSize = 13
    ValueLabel.Font = Enum.Font.GothamMedium
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    
    local dragging = false
    local currentVal = defaultVal
    
    SliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    SliderFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    SliderFrame.MouseMoved:Connect(function()
        if dragging then
            local mousePos = Mouse.X
            local absPos = SliderFrame.AbsolutePosition.X
            local width = SliderFrame.AbsoluteSize.X
            local percent = math.clamp((mousePos - absPos) / width, 0, 1)
            local val = math.round(minVal + (maxVal - minVal) * percent)
            currentVal = val
            Fill.Size = UDim2.new(percent, 0, 1, 0)
            ValueLabel.Text = tostring(val)
            if callback then callback(val) end
        end
    end)
    
    return function() return currentVal end
end

-- === DROPDOWN ===
local function CreateDropdown(row, options, defaultIndex, callback)
    local Dropdown = Instance.new("TextButton")
    Dropdown.Parent = row
    Dropdown.Size = UDim2.new(0, 110, 0, 28)
    Dropdown.Position = UDim2.new(0, row.Size.X.Offset - 120, 0.5, -14)
    Dropdown.BackgroundColor3 = ZertyxConfig.Theme.Background
    Dropdown.BackgroundTransparency = 0.3
    Dropdown.BorderSizePixel = 0
    Dropdown.Text = options[defaultIndex or 1]
    Dropdown.TextColor3 = ZertyxConfig.Theme.Text
    Dropdown.TextSize = 12
    Dropdown.Font = Enum.Font.GothamMedium
    Dropdown.AutoButtonColor = false
    
    local DropCorner = Instance.new("UICorner")
    DropCorner.Parent = Dropdown
    DropCorner.CornerRadius = UDim.new(0, 30)
    
    local selectedIndex = defaultIndex or 1
    Dropdown.MouseButton1Click:Connect(function()
        selectedIndex = selectedIndex % #options + 1
        Dropdown.Text = options[selectedIndex]
        if callback then callback(selectedIndex, options[selectedIndex]) end
    end)
    
    return Dropdown
end

-- === ESP FUNCTIONS ===

-- Create Skeleton
local function createSkeleton(player)
    if skeletonObjects[player] then
        for _, obj in pairs(skeletonObjects[player]) do
            obj:Destroy()
        end
        skeletonObjects[player] = nil
    end
    
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    local parts = {}
    local joints = {
        {"Head", "UpperTorso"},
        {"UpperTorso", "LowerTorso"},
        {"LeftUpperArm", "LeftLowerArm"},
        {"RightUpperArm", "RightLowerArm"},
        {"LeftUpperLeg", "LeftLowerLeg"},
        {"RightUpperLeg", "RightLowerLeg"}
    }
    
    for _, joint in pairs(joints) do
        local part1 = character:FindFirstChild(joint[1])
        local part2 = character:FindFirstChild(joint[2])
        if part1 and part2 then
            local attachment1 = Instance.new("Attachment")
            attachment1.Parent = part1
            attachment1.Position = Vector3.new(0, 0, 0)
            
            local attachment2 = Instance.new("Attachment")
            attachment2.Parent = part2
            attachment2.Position = Vector3.new(0, 0, 0)
            
            local constraint = Instance.new("RopeConstraint")
            constraint.Parent = character
            constraint.Attachment0 = attachment1
            constraint.Attachment1 = attachment2
            constraint.Thickness = 0.15
            constraint.Color = Color3.fromRGB(0, 255, 100)
            constraint.Visible = skeletonEnabled
            
            if not skeletonObjects[player] then
                skeletonObjects[player] = {}
            end
            table.insert(skeletonObjects[player], attachment1)
            table.insert(skeletonObjects[player], attachment2)
            table.insert(skeletonObjects[player], constraint)
        end
    end
end

-- Create Name Tag
local function createNameTag(player)
    if nameObjects[player] then
        nameObjects[player]:Destroy()
        nameObjects[player] = nil
    end
    
    local character = player.Character
    if not character then return end
    
    local head = character:FindFirstChild("Head")
    if not head then return end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Parent = head
    billboard.Size = UDim2.new(0, 100, 0, 30)
    billboard.Adornee = head
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    
    local label = Instance.new("TextLabel")
    label.Parent = billboard
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = player.Name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextStrokeTransparency = 0.3
    
    nameObjects[player] = billboard
end

-- Create Highlight (ESP)
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

-- Update all ESP
local function updateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            local humanoid = character and character:FindFirstChild("Humanoid")
            
            if espEnabled and character and humanoid then
                if not espObjects[player] then
                    createHighlight(player)
                end
            else
                if espObjects[player] then
                    espObjects[player]:Destroy()
                    espObjects[player] = nil
                end
            end
            
            if skeletonEnabled and character and humanoid then
                if not skeletonObjects[player] then
                    createSkeleton(player)
                end
            else
                if skeletonObjects[player] then
                    for _, obj in pairs(skeletonObjects[player]) do
                        obj:Destroy()
                    end
                    skeletonObjects[player] = nil
                end
            end
            
            if nameEnabled and character and humanoid then
                if not nameObjects[player] then
                    createNameTag(player)
                end
            else
                if nameObjects[player] then
                    nameObjects[player]:Destroy()
                    nameObjects[player] = nil
                end
            end
        end
    end
end

-- Clear all ESP
local function clearESP()
    for player, highlight in pairs(espObjects) do
        highlight:Destroy()
    end
    espObjects = {}
    
    for player, objects in pairs(skeletonObjects) do
        for _, obj in pairs(objects) do
            obj:Destroy()
        end
    end
    skeletonObjects = {}
    
    for player, nameTag in pairs(nameObjects) do
        nameTag:Destroy()
    end
    nameObjects = {}
end

-- Toggle ESP
local function toggleESP(state)
    espEnabled = state
    if state then
        updateESP()
    else
        clearESP()
        updateESP()
    end
end

-- Toggle Skeleton
local function toggleSkeleton(state)
    skeletonEnabled = state
    updateESP()
end

-- Toggle Name
local function toggleName(state)
    nameEnabled = state
    updateESP()
end

-- === VISUALS TAB ===
function CreateVisualsTab(parent)
    local yPos = 0
    
    local row1 = CreateRow(parent, "ESP", yPos)
    local espToggle, getEspState = CreateSquareToggle(row1, true, function(state)
        toggleESP(state)
    end)
    yPos = yPos + 48
    
    local row2 = CreateRow(parent, "ESP Range", yPos)
    local rangeSlider = CreateSlider(row2, 0, 100, 75)
    yPos = yPos + 48
    
    local row3 = CreateRow(parent, "Skeleton", yPos)
    local skeletonToggle, getSkeletonState = CreateSquareToggle(row3, false, function(state)
        toggleSkeleton(state)
    end)
    yPos = yPos + 48
    
    local row4 = CreateRow(parent, "Player Names", yPos)
    local nameToggle, getNameState = CreateSquareToggle(row4, true, function(state)
        toggleName(state)
    end)
    yPos = yPos + 48
    
    local row5 = CreateRow(parent, "Skeleton Color", yPos)
    local colorDropdown = CreateDropdown(row5, {"Rainbow", "Red", "Blue", "Green", "Yellow"}, 1)
    yPos = yPos + 48
    
    parent.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- === AIM TAB ===
function CreateAimTab(parent)
    local yPos = 0
    
    local row1 = CreateRow(parent, "Aimbot", yPos)
    local aimToggle = CreateSquareToggle(row1, false)
    yPos = yPos + 48
    
    local row2 = CreateRow(parent, "FOV", yPos)
    local getFOV = CreateSlider(row2, 0, 360, 120)
    yPos = yPos + 48
    
    local row3 = CreateRow(parent, "Smooth", yPos)
    local getSmooth = CreateSlider(row3, 0, 100, 50)
    yPos = yPos + 48
    
    local row4 = CreateRow(parent, "Target", yPos)
    local targetDropdown = CreateDropdown(row4, {"Head", "Body", "Neck"}, 1)
    yPos = yPos + 48
    
    local row5 = CreateRow(parent, "Safety", yPos)
    local safeToggle = CreateSquareToggle(row5, true)
    yPos = yPos + 48
    
    local row6 = CreateRow(parent, "Rage", yPos)
    local rageToggle = CreateSquareToggle(row6, false)
    yPos = yPos + 48
    
    parent.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- === MISC TAB ===
function CreateMiscTab(parent)
    local yPos = 0
    
    local row1 = CreateRow(parent, "Watermark", yPos)
    local watermarkToggle = CreateSquareToggle(row1, true)
    yPos = yPos + 48
    
    local row2 = CreateRow(parent, "FPS Counter", yPos)
    local fpsToggle = CreateSquareToggle(row2, true)
    yPos = yPos + 48
    
    local row3 = CreateRow(parent, "Crosshair", yPos)
    local crosshairToggle = CreateSquareToggle(row3, true)
    yPos = yPos + 48
    
    local row4 = CreateRow(parent, "Crosshair Color", yPos)
    local crosshairColor = CreateDropdown(row4, {"Red", "Green", "Blue", "White", "Yellow"}, 4)
    yPos = yPos + 48
    
    local row5 = CreateRow(parent, "Menu Key", yPos)
    local keyLabel = Instance.new("TextLabel")
    keyLabel.Parent = row5
    keyLabel.Size = UDim2.new(0, 60, 0, 26)
    keyLabel.Position = UDim2.new(0, row5.Size.X.Offset - 70, 0.5, -13)
    keyLabel.BackgroundColor3 = ZertyxConfig.Theme.Background
    keyLabel.BackgroundTransparency = 0.3
    keyLabel.BorderSizePixel = 0
    keyLabel.Text = "≡"
    keyLabel.TextColor3 = ZertyxConfig.Theme.Text
    keyLabel.TextSize = 14
    keyLabel.Font = Enum.Font.GothamBold
    keyLabel.TextXAlignment = Enum.TextXAlignment.Center
    
    local KeyCorner = Instance.new("UICorner")
    KeyCorner.Parent = keyLabel
    KeyCorner.CornerRadius = UDim.new(0, 30)
    yPos = yPos + 48
    
    parent.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- === CREATE TABS ===
CreateTab("Visuals")
CreateTab("Aim")
CreateTab("Misc")

-- Activate first tab
local firstTab = TabButtons["Visuals"]
if firstTab then
    firstTab.BackgroundTransparency = 0.2
    firstTab.TextColor3 = ZertyxConfig.Theme.TextBright
end

-- === WATERMARK ===
local Watermark = Instance.new("TextLabel")
Watermark.Parent = ScreenGui
Watermark.Size = UDim2.new(0, 200, 0, 30)
Watermark.Position = UDim2.new(0, 10, 1, -40)
Watermark.BackgroundTransparency = 1
Watermark.Text = "Zertyx v1.4 | BloxStrike"
Watermark.TextColor3 = Color3.fromRGB(106, 147, 199)
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
FPSCounter.TextColor3 = Color3.fromRGB(100, 255, 100)
FPSCounter.TextSize = 13
FPSCounter.Font = Enum.Font.GothamMedium
FPSCounter.TextXAlignment = Enum.TextXAlignment.Right
FPSCounter.TextYAlignment = Enum.TextYAlignment.Bottom

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

-- === ESP UPDATE EVENTS ===
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        updateESP()
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    if espObjects[player] then
        espObjects[player]:Destroy()
        espObjects[player] = nil
    end
    if skeletonObjects[player] then
        for _, obj in pairs(skeletonObjects[player]) do
            obj:Destroy()
        end
        skeletonObjects[player] = nil
    end
    if nameObjects[player] then
        nameObjects[player]:Destroy()
        nameObjects[player] = nil
    end
end)

-- Update ESP every second
task.spawn(function()
    while task.wait(1) do
        updateESP()
    end
end)

-- Initial ESP
task.wait(1)
toggleESP(true)
toggleName(true)
toggleSkeleton(false)

-- === GLOBAL ACCESS ===
_G.Zertyx = {
    ToggleMenu = function()
        MainFrame.Visible = not MainFrame.Visible
    end,
    IsOpen = function()
        return MainFrame.Visible
    end,
    ToggleESP = toggleESP,
    ToggleSkeleton = toggleSkeleton,
    ToggleName = toggleName,
    ClearESP = clearESP
}

print("Zertyx v1.4 Loaded Successfully!")
print("Press ≡ button in top-left corner to open menu")
print("ESP: ON | Skeleton: OFF | Names: ON")
