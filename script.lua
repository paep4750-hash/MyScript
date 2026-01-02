-- [[ 🛡️ NORINI HUB V65.0 | FPS MOTION & ZOMBIE RNG ]] --
-- [[ Owner: Goa8758 | UserID: 9437139923 ]] --

local lp = game.Players.LocalPlayer
local mouse = lp:GetMouse()
local targetID = 9437139923
local isDev = (lp.UserId == targetID)

-- [[ 🛠️ ระบบป้องกันการเด้งและโหลด Library ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "NORINI HUB 👿 V65.0",
   LoadingTitle = isDev and "แอดมิน Goa8758 เข้าระบบแล้ว" or "FPS Motion & RNG Hub",
   LoadingSubtitle = "Aimbot & ESP Edition",
   KeySystem = not isDev,
   KeySettings = {
      Title = "ระบบยืนยันคีย์",
      Subtitle = "คีย์ของคุณคือ: 15466675546844776",
      Note = "คีย์นี้ใช้ได้เฉพาะกลุ่มเพื่อน Goa8758",
      SaveKey = true,
      Key = {"15466675546844776"}
   }
})

-- [[ 🎯 แท็บแฮก FPS (Aimbot & ESP) ]] --
local FPSTab = Window:CreateTab("FPS แฮก", "crosshair")
FPSTab:CreateSection("🎯 ระบบล็อคเป้า (Aimbot)")

_G.AimbotEnabled = false
FPSTab:CreateToggle({
   Name = "เปิดระบบ Aimbot (ล็อคเป้าอัตโนมัติ)",
   CurrentValue = false,
   Callback = function(v)
      _G.AimbotEnabled = v
   end,
})

-- ระบบล็อคเป้าเบื้องหลัง
game:GetService("RunService").RenderStepped:Connect(function()
    if _G.AimbotEnabled then
        local target = nil
        local dist = math.huge
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                if onScreen then
                    local mag = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                    if mag < dist then
                        dist = mag
                        target = player.Character.HumanoidRootPart
                    end
                end
            end
        end
        if target then
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Position)
        end
    end
end)

FPSTab:CreateSection("👁️ ระบบมองทะลุ (ESP)")
FPSTab:CreateButton({
   Name = "เปิด ESP (มองทะลุคนอื่น)",
   Callback = function()
      for _, player in pairs(game.Players:GetPlayers()) do
          if player ~= lp and player.Character then
              local highlight = Instance.new("Highlight")
              highlight.Parent = player.Character
              highlight.FillColor = Color3.fromRGB(255, 0, 0)
              highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
          end
      end
      Rayfield:Notify({Title = "สำเร็จ", Content = "เปิดมองทะลุคนในเซิร์ฟเวอร์แล้ว", Duration = 3})
   end,
})

-- [[ 🧟 แท็บฟาร์ม Zombies RNG ]] --
local FarmTab = Window:CreateTab("Zombies RNG", "skull")
FarmTab:CreateToggle({
   Name = "Auto Roll (สุ่มอัตโนมัติ)",
   CurrentValue = false,
   Callback = function(v)
      _G.AutoRoll = v
      task.spawn(function()
         while _G.AutoRoll do
            pcall(function()
                game:GetService("ReplicatedStorage").Events.RollEvent:FireServer("Roll")
            end)
            task.wait(1)
         end
      end)
   end,
})

-- [[ 🛡️ แท็บ FE & แก้บัค ]] --
local MainTab = Window:CreateTab("หน้าหลัก (FE)", "shield")
MainTab:CreateButton({
   Name = "เปิดโหมดอมตะ (God Mode)",
   Callback = function()
      pcall(function()
          lp.Character.Humanoid.Health = math.huge
      end)
      Rayfield:Notify({Title = "สำเร็จ", Content = "คุณเป็นอมตะแล้ว", Duration = 3})
   end,
})

MainTab:CreateSlider({
   Name = "ปรับความเร็ว (Speed)",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v) pcall(function() lp.Character.Humanoid.WalkSpeed = v end) end,
})
