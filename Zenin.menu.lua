--[[
    Zertyx - Empty Menu
    Version: 1.7
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

-- === MAIN FRAME (WHITE) ===
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 640, 0, 420)
MainFrame.Position = UDim2.new(0.5, -320, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 0
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false

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

-- === CLOSE BUTTON (X) ===
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.BackgroundTransparency = 0.2
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.GothamBold

local CloseCorner = Instance.new("UICorner")
CloseCorner.Parent = CloseBtn
CloseCorner.CornerRadius = UDim.new(0, 30)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- === EMPTY TEXT ===
local EmptyText = Instance.new("TextLabel")
EmptyText.Parent = MainFrame
EmptyText.Size = UDim2.new(1, 0, 1, 0)
EmptyText.Position = UDim2.new(0, 0, 0, 0)
EmptyText.BackgroundTransparency = 1
EmptyText.Text = "EMPTY MENU"
EmptyText.TextColor3 = Color3.fromRGB(150, 150, 150)
EmptyText.TextSize = 30
EmptyText.Font = Enum.Font.GothamBold
EmptyText.TextXAlignment = Enum.TextXAlignment.Center
EmptyText.TextYAlignment = Enum.TextYAlignment.Center

-- === GLOBAL ACCESS ===
_G.Zertyx = {
    ToggleMenu = function()
        MainFrame.Visible = not MainFrame.Visible
    end,
    IsOpen = function()
        return MainFrame.Visible
    end
}

print("Zertyx Empty Menu Loaded!")
print("Press ≡ button in top-left corner to open menu")
