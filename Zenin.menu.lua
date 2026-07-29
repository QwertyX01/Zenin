-- Белое меню 470x330 с заголовком "Zenin CS" (красный)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(1, 1, 1)      -- белый фон
MainFrame.BackgroundTransparency = 0.02
MainFrame.BorderSize = 0                              -- без обводки
MainFrame.Size = UDim2.new(0, 470, 0, 330)
MainFrame.Position = UDim2.new(0.5, -235, 0.5, -165)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local Corner = Instance.new("UICorner")
Corner.Parent = MainFrame
Corner.CornerRadius = UDim.new(0, 8)

-- ЗАГОЛОВОК "Zenin CS" КРАСНЫМ
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 36)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "Zenin CS"
Title.TextColor3 = Color3.new(1, 0, 0)                -- красный
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Center

-- Контейнер вкладок
local TabContainer = Instance.new("Frame")
TabContainer.Parent = MainFrame
TabContainer.BackgroundTransparency = 1
TabContainer.Size = UDim2.new(1, 0, 0, 34)
TabContainer.Position = UDim2.new(0, 0, 0, 36)

-- Контейнер содержимого
local ContentContainer = Instance.new("Frame")
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Size = UDim2.new(1, -16, 1, -86)
ContentContainer.Position = UDim2.new(0, 8, 0, 70)

local Tabs = {}
local CurrentTab = nil

-- Функция создания вкладки
function CreateTab(name)
    local btn = Instance.new("TextButton")
    btn.Parent = TabContainer
    btn.BackgroundTransparency = 0.85
    btn.BackgroundColor3 = Color3.new(0.92, 0.92, 0.92)
    btn.BorderSize = 0
    btn.Size = UDim2.new(0, 70, 1, -4)
    btn.Position = UDim2.new(0, #Tabs * 78, 0, 2)
    btn.Text = name
    btn.TextColor3 = Color3.new(0, 0, 0)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamSemibold
    local cornerBtn = Instance.new("UICorner")
    cornerBtn.Parent = btn
    cornerBtn.CornerRadius = UDim.new(0, 4)
    
    local content = Instance.new("Frame")
    content.Parent = ContentContainer
    content.BackgroundTransparency = 1
    content.Size = UDim2.new(1, 0, 1, 0)
    content.Visible = false
    
    Tabs[name] = {Button = btn, Content = content}
    
    btn.MouseButton1Click:Connect(function()
        if CurrentTab then
            Tabs[CurrentTab].Content.Visible = false
            Tabs[CurrentTab].Button.BackgroundTransparency = 0.85
        end
        content.Visible = true
        btn.BackgroundTransparency = 0.3
        CurrentTab = name
    end)
    
    return content
end

-- Секция (группа элементов)
function CreateSection(parent, title)
    local section = Instance.new("Frame")
    section.Parent = parent
    section.BackgroundTransparency = 1
    section.Size = UDim2.new(1, 0, 0, 24)
    section.Position = UDim2.new(0, 0, 0, #parent:GetChildren() * 30 + 5)
    
    local label = Instance.new("TextLabel")
    label.Parent = section
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = title
    label.TextColor3 = Color3.new(0.2, 0.2, 0.2)
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    return section
end

-- Переключатель (Toggle)
function CreateToggle(parent, text, default, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, 22)
    frame.Position = UDim2.new(0, 0, 0, #parent:GetChildren() * 28 + 5)
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.65, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.Text = text
    label.TextColor3 = Color3.new(0, 0, 0)
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = frame
    toggleBtn.BackgroundColor3 = default and Color3.new(0.3, 0.8, 0.3) or Color3.new(0.7, 0.7, 0.7)
    toggleBtn.BorderSize = 0
    toggleBtn.Size = UDim2.new(0, 36, 0, 18)
    toggleBtn.Position = UDim2.new(0.8, 0, 0.5, -9)
    toggleBtn.Text = default and "Вкл" or "Выкл"
    toggleBtn.TextColor3 = Color3.new(1, 1, 1)
    toggleBtn.TextSize = 11
    toggleBtn.Font = Enum.Font.GothamBold
    local cornerTog = Instance.new("UICorner")
    cornerTog.Parent = toggleBtn
    cornerTog.CornerRadius = UDim.new(0, 4)
    
    local state = default
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        toggleBtn.BackgroundColor3 = state and Color3.new(0.3, 0.8, 0.3) or Color3.new(0.7, 0.7, 0.7)
        toggleBtn.Text = state and "Вкл" or "Выкл"
        if callback then callback(state) end
    end)
    return toggleBtn
end

-- Кнопка
function CreateButton(parent, text, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, 26)
    frame.Position = UDim2.new(0, 0, 0, #parent:GetChildren() * 32 + 5)
    
    local btn = Instance.new("TextButton")
    btn.Parent = frame
    btn.BackgroundColor3 = Color3.new(0.9, 0.9, 0.9)
    btn.BorderSize = 0
    btn.Size = UDim2.new(0.5, 0, 1, 0)
    btn.Position = UDim2.new(0, 0, 0, 0)
    btn.Text = text
    btn.TextColor3 = Color3.new(0, 0, 0)
    btn.TextSize = 13
    btn.Font = Enum.Font.Gotham
    local cornerBtn = Instance.new("UICorner")
    cornerBtn.Parent = btn
    cornerBtn.CornerRadius = UDim.new(0, 4)
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    return btn
end

-- ===== СОЗДАЁМ ВКЛАДКИ =====
local tabAim = CreateTab("Aimbot")
local secAim = CreateSection(tabAim, "Прицел")
CreateToggle(secAim, "Включить Aimbot", false, function(v) print("Aimbot:", v) end)
CreateToggle(secAim, "Silent Aim", true, function(v) print("Silent:", v) end)
CreateToggle(secAim, "Wallbang", false, function(v) print("Wallbang:", v) end)

local tabESP = CreateTab("ESP")
local secESP = CreateSection(tabESP, "Визуал")
CreateToggle(secESP, "Включить ESP", true, function(v) print("ESP:", v) end)
CreateToggle(secESP, "Здоровье", true, function(v) print("HP:", v) end)

local tabMisc = CreateTab("Прочее")
local secMisc = CreateSection(tabMisc, "Разное")
CreateToggle(secMisc, "God Mode", false, function(v) print("God:", v) end)
CreateButton(secMisc, "Закрыть меню", function() ScreenGui:Destroy() end)

-- Открыть первую вкладку
local firstTab = next(Tabs)
if firstTab then Tabs[firstTab].Button.MouseButton1Click:Fire() end

-- Открытие/закрытие по Insert
local visible = true
game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        visible = not visible
        MainFrame.Visible = visible
    end
end)
