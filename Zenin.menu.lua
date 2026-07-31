--[[
    Zertyx - Menu with Header and Tabs
    Version: 1.9
    Size: 640x420
    Open: Button ≡ in top-left corner
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

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
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 0
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false

-- === HEADER (GRAY) ===
local Header = Instance.new("Frame")
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 50)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
Header.BackgroundTransparency = 0
Header.BorderSizePixel = 0

-- === TITLE (RED) ===
local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.Size = UDim2.new(0, 150, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Zertyx"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextYAlignment = Enum.TextYAlignment.Center

-- === TABS CONTAINER (BELOW HEADER) ===
local TabsContainer = Instance.new("Frame")
TabsContainer.Parent = MainFrame
TabsContainer.Size = UDim2.new(1, 0, 0, 35)
TabsContainer.Position = UDim2.new(0, 0, 0, 50) -- Сразу под хедером
TabsContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
TabsContainer.BackgroundTransparency = 0
TabsContainer.BorderSizePixel = 0

-- === TAB BUTTONS ===
local tabs = {"Visuals", "Aim", "Misc"}
local TabButtons = {}
local TabContents = {}

for i, tabName in ipairs(tabs) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = TabsContainer
    TabBtn.Size = UDim2.new(0, 90, 1, 0)
    TabBtn.Position = UDim2.new(0, 10 + (i-1) * 95, 0, 0)
    TabBtn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    TabBtn.BackgroundTransparency = 0
    TabBtn.BorderSizePixel = 0
    TabBtn.Text = tabName:upper()
    TabBtn.TextColor3 = Color3.fromRGB(80, 80, 80)
    TabBtn.TextSize = 13
    TabBtn.Font = Enum.Font.GothamMedium
    TabBtn.AutoButtonColor = false
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.Parent = TabBtn
    TabCorner.CornerRadius = UDim.new(0, 8)
    
    -- Content for each tab
    local Content = Instance.new("ScrollingFrame")
    Content.Parent = MainFrame
    Content.Size = UDim2.new(1, -20, 1, -100)
    Content.Position = UDim2.new(0, 10, 0, 90) -- Ниже хедера и вкладок
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.Visible = (i == 1)
    Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    Content.ScrollBarThickness = 4
    Content.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200)
    Content.Name = tabName .. "Content"
    
    -- Empty text in each tab
    local EmptyText = Instance.new("TextLabel")
    EmptyText.Parent = Content
    EmptyText.Size = UDim2.new(1, 0, 1, 0)
    EmptyText.Position = UDim2.new(0, 0, 0, 0)
    EmptyText.BackgroundTransparency = 1
    EmptyText.Text = tabName:upper() .. " TAB"
    EmptyText.TextColor3 = Color3.fromRGB(180, 180, 180)
    EmptyText.TextSize = 24
    EmptyText.Font = Enum.Font.GothamBold
    EmptyText.TextXAlignment = Enum.TextXAlignment.Center
    EmptyText.TextYAlignment = Enum.TextYAlignment.Center
    
    TabButtons[tabName] = TabBtn
    TabContents[tabName] = Content
    
    TabBtn.MouseButton1Click:Connect(function()
        for name, btn in pairs(TabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
            btn.TextColor3 = Color3.fromRGB(80, 80, 80)
            TabContents[name].Visible = false
        end
        TabBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        Content.Visible = true
    end)
end

-- Activate first tab
local firstTab = TabButtons["Visuals"]
if firstTab then
    firstTab.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    firstTab.TextColor3 = Color3.fromRGB(0, 0, 0)
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

-- === GLOBAL ACCESS ===
_G.Zertyx = {
    ToggleMenu = function()
        MainFrame.Visible = not MainFrame.Visible
    end,
    IsOpen = function()
        return MainFrame.Visible
    end
}

print("Zertyx v1.9 Loaded Successfully!")
print("Press ≡ button in top-left corner to open menu")
