local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Tempest Hub | Sailor Piece (No Key)",
   LoadingTitle = "Tempest Hub Loading...",
   LoadingSubtitle = "by Kraxzyv",
   KeySystem = false
})

local VIM = game:GetService("VirtualInputManager")
local LP = game.Players.LocalPlayer
_G.AutoFarm = false
local MyIslandPos = nil

local function AutoDamage()
    VIM:SendMouseButtonEvent(500, 500, 0, true, game, 0)
    task.wait(0.01)
    VIM:SendMouseButtonEvent(500, 500, 0, false, game, 0)
end

local MainTab = Window:CreateTab("Main", 4483362458)

MainTab:CreateToggle({
   Name = "AUTO FARM (BETA)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      if Value then MyIslandPos = LP.Character.HumanoidRootPart.Position end
      task.spawn(function()
         while _G.AutoFarm do
            pcall(function()
               for _, v in pairs(workspace:GetDescendants()) do
                  if v:IsA("Humanoid") and v.Parent ~= LP.Character and v.Health > 0 and v.MaxHealth > 100 then
                     local n = v.Parent.Name:lower()
                     if not n:find("penjual") and not n:find("quest") then
                        local ERoot = v.Parent:FindFirstChild("HumanoidRootPart")
                        if ERoot and (ERoot.Position - MyIslandPos).Magnitude < 400 then
                           LP.Character.HumanoidRootPart.CFrame = ERoot.CFrame * CFrame.new(0, 13, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                           local tools = LP.Backpack:GetChildren()
                           if tools[2] then LP.Character.Humanoid:EquipTool(tools[2]) end
                           AutoDamage()
                           break
                        end
                     end
                  end
               end
            end)
            task.wait()
         end
      end)
   end,
})

local CreditTab = Window:CreateTab("Credits", 4483362458)
CreditTab:CreateLabel("Script by: Kraxzyv")
