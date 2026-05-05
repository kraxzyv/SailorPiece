-- [[ RYOSEN HUB - EXCLUSIVE BY KRAXZYV ]]
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local LP = Players.LocalPlayer

-- --- [ CONFIGURATION ] ---
local HubName = "Ryosen Hub"
local Owner = "KRAXZYV"
local MainColor = Color3.fromRGB(200, 0, 0)
local LogoID = "rbxassetid://79712382797224"
_G.AutoFarm = false

-- --- [ UI CLEANER ] ---
if CoreGui:FindFirstChild("RyosenHub_Final") then CoreGui["RyosenHub_Final"]:Destroy() end
local ScreenGui = Instance.new("ScreenGui"); ScreenGui.Name = "RyosenHub_Final"; ScreenGui.Parent = CoreGui

-- --- [ 1. LOADING SCREEN (RYOSEN HUB) ] ---
local function StartLoading()
    local LF = Instance.new("Frame")
    LF.Size = UDim2.new(0, 350, 0, 200); LF.Position = UDim2.new(0.5, -175, 0.5, -100)
    LF.BackgroundColor3 = Color3.fromRGB(5, 5, 5); LF.Parent = ScreenGui
    Instance.new("UICorner", LF); Instance.new("UIStroke", LF).Color = MainColor

    local LogoImg = Instance.new("ImageLabel")
    LogoImg.Size = UDim2.new(0, 80, 0, 80); LogoImg.Position = UDim2.new(0.5, -40, 0.1, 0)
    LogoImg.Image = LogoID; LogoImg.BackgroundTransparency = 1; LogoImg.Parent = LF

    local LT = Instance.new("TextLabel")
    LT.Size = UDim2.new(1, 0, 0, 40); LT.Position = UDim2.new(0, 0, 0.55, 0)
    LT.Text = "Ryosen Hub"; LT.TextColor3 = MainColor; LT.Font = Enum.Font.GothamBold; LT.TextSize = 28; LT.BackgroundTransparency = 1; LT.Parent = LF

    local BB = Instance.new("Frame")
    BB.Size = UDim2.new(0, 260, 0, 4); BB.Position = UDim2.new(0.5, -130, 0.9, 0)
    BB.BackgroundColor3 = Color3.fromRGB(20, 0, 0); BB.Parent = LF
    local B = Instance.new("Frame")
    B.Size = UDim2.new(0, 0, 1, 0); B.BackgroundColor3 = MainColor; B.Parent = BB
    
    TweenService:Create(B, TweenInfo.new(1.8), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    task.wait(2); LF:Destroy()
end

-- --- [ 2. UI ENGINE ] ---
local function CreateMainUI()
    local MF = Instance.new("Frame")
    MF.Size = UDim2.new(0, 320, 0, 380); MF.Position = UDim2.new(0.5, -160, 0.5, -190)
    MF.BackgroundColor3 = Color3.fromRGB(10, 10, 12); MF.Active = true; MF.Draggable = true; MF.Parent = ScreenGui
    Instance.new("UICorner", MF); Instance.new("UIStroke", MF).Color = MainColor

    local TL = Instance.new("TextLabel")
    TL.Size = UDim2.new(1, 0, 0, 50); TL.Text = "Ryosen Hub"; TL.TextColor3 = MainColor; TL.Font = Enum.Font.GothamBold; TL.TextSize = 18; TL.BackgroundTransparency = 1; TL.Parent = MF

    local SC = Instance.new("ScrollingFrame")
    SC.Size = UDim2.new(1, -24, 1, -70); SC.Position = UDim2.new(0, 12, 0, 55); SC.BackgroundTransparency = 1; SC.ScrollBarThickness = 0; SC.Parent = MF
    Instance.new("UIListLayout", SC).Padding = UDim.new(0, 8)
    return SC
end

local function AddBtn(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40); btn.BackgroundColor3 = Color3.fromRGB(15, 0, 0); btn.Text = text; btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.Font = Enum.Font.GothamMedium; btn.Parent = parent
    Instance.new("UICorner", btn); Instance.new("UIStroke", btn).Color = MainColor
    btn.MouseButton1Click:Connect(callback)
end

local function AddLabel(parent, text, color)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 0, 25); l.Text = text; l.TextColor3 = color or MainColor; l.BackgroundTransparency = 1; l.Font = Enum.Font.Gotham; l.TextSize = 14; l.Parent = parent
end

-- --- [ 3. MAGNETIC & AUTO CLICK SLOT 2 (KETINGGIAN 13) ] ---
task.spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                -- AUTO EQUIP SLOT 2
                local Tool = LP.Backpack:GetChildren()[2] or LP.Character:FindFirstChildOfClass("Tool")
                if Tool and Tool.Parent == LP.Backpack then
                    LP.Character.Humanoid:EquipTool(Tool)
                end
                
                -- AUTO CLICKER
                VirtualUser:CaptureController()
                VirtualUser:Button1Down(Vector2.new(1280, 672))

                -- FIND ENEMY & MAGNETIC
                for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                        repeat
                            task.wait()
                            LP.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 13, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                        until not _G.AutoFarm or v.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end
end)

-- --- [ 4. EXECUTION ] ---
StartLoading()
local Con = CreateMainUI()

AddLabel(Con, "--- MAIN FEATURE ---")
local Tgl = Instance.new("TextButton")
Tgl.Size = UDim2.new(1, 0, 0, 40); Tgl.BackgroundColor3 = Color3.fromRGB(15, 0, 0); Tgl.Text = "AUTO FARM: OFF"; Tgl.TextColor3 = Color3.fromRGB(255, 255, 255); Tgl.Parent = Con
Instance.new("UICorner", Tgl); Instance.new("UIStroke", Tgl).Color = MainColor

Tgl.MouseButton1Click:Connect(function()
    _G.AutoFarm = not _G.AutoFarm
    Tgl.Text = _G.AutoFarm and "AUTO FARM: ON" or "AUTO FARM: OFF"
    Tgl.TextColor3 = _G.AutoFarm and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255)
end)

AddLabel(Con, "--- INFO ---")
AddBtn(Con, "JOIN DISCORD", function() setclipboard("https://discord.gg/KmRnDnsd5P") end)

-- CREDIT: OWNER KRAXZYV
AddLabel(Con, "--- CREDIT ---")
AddLabel(Con, "Owner: Kraxzyv " .. Owner, Color3.fromRGB(255, 255, 255))

AddBtn(Con, "EXIT HUB", function() _G.AutoFarm = false; ScreenGui:Destroy() end)
