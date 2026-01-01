-- [[ ⚠️ ระบบป้องกันโดย Goa8758 ]] --
local lp = game.Players.LocalPlayer
local targetID = 9437139923 -- ID ของคุณ [cite: 2025-12-27]
local isDev = (lp.UserId == targetID)

-- [[ 1. ฟังก์ชันปุ่มลอย Discord (ถ้าเป็น Goa8758 จะไม่ขึ้นให้เกะกะ) ]] --
if not isDev then
    local UI = Instance.new("ScreenGui", game.CoreGui)
    local Btn = Instance.new("TextButton", UI)
    Btn.Name = "DiscordBtn"
    Btn.Size = UDim2.new(0, 200, 0, 45)
    Btn.Position = UDim2.new(0.5, -100, 0.1, 0)
    Btn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    Btn.Text = "🔵 GET KEY @ DISCORD"
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 16
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 10)
    Btn.Draggable = true
    
    Btn.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/VcFbC3AY6")
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Copied!",
            Text = "คัดลอกลิงก์ดิสคอร์ดแล้ว",
            Duration = 5
        })
    end)
    
    -- ลบปุ่มเมื่อหน้าต่างเมนูหลักเปิดขึ้น
    task.spawn(function()
        repeat task.wait() until game.CoreGui:FindFirstChild("Rayfield")
        UI:Destroy()
    end)
end

-- [[ 2. โหลด Library แบบเสถียร (รันติดง่ายขึ้น) ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "NORINI FE HUB 👿 V62.0",
   LoadingTitle = isDev and "Owner: Goa8758 Authenticated" or "Loading Norini Hub...",
   LoadingSubtitle = "by Gemini Dev",
   KeySystem = not isDev,
   KeySettings = {
      Title = "Key System",
      Subtitle = "Join Discord for Key",
      Note = "คีย์จะถามใหม่ทุกวัน",
      FileName = "NoriniKey.json", 
      SaveKey = true, 
      Key = {"15466675546844776"} -- คีย์ของคุณ [cite: 2025-12-28]
   }
})

-- [[ 3. แท็บฟังก์ชัน (อมตะ / เลขบัค / บิน / กระโดด / Heatbox) ]] --
local MainTab = Window:CreateTab("หน้าหลัก (FE)", "home")
local ScriptTab = Window:CreateTab("ตัว script", "code")

MainTab:CreateSection("🛡️ ฟังก์ชันหลัก (Goa8758 Protected)")

MainTab:CreateButton({
   Name = "เปิดโหมดวิญญาณ FE (อมตะ 100%)",
   Callback = function()
      _G.FE_Soul = true
      task.spawn(function()
         while _G.FE_Soul do
            pcall(function()
               local char = lp.Character or lp.CharacterAdded:Wait()
               char.Humanoid.Health = math.huge
               char.Humanoid.RequiresNeck = false
               for _, p in pairs(char:GetChildren()) do
                  if p:IsA("BasePart") then p.CanTouch = false end
               end
            end)
            task.wait(0.1)
         end
      end)
   end,
})

MainTab:CreateButton({
   Name = "เปิดระบบเลขบัค Infinite (FORSAKEN)",
   Callback = function()
      task.spawn(function()
         while task.wait(0.1) do
            pcall(function()
               for _, v in pairs(lp:GetDescendants()) do
                  if v:IsA("NumberValue") and (v.Name:lower():find("health") or v.Name:lower():find("speed") or v.Name:lower():find("stamina")) then
                     v.Value = 999999999999999999
                  end
               end
               for _, gui in pairs(lp.PlayerGui:GetDescendants()) do
                  if gui:IsA("TextLabel") and (gui.Text:find("/") or gui.Text:lower():find("sp") or gui.Text:lower():find("hp")) then
                     gui.Text = "999999999999999999"
                  end
               end
            end)
         end
      end)
   end,
})

ScriptTab:CreateSection("✈️ การเคลื่อนที่ & ต่อสู้")

ScriptTab:CreateButton({
   Name = "สร้างปุ่มกระโดดสีแดง (Mobile Jump)",
   Callback = function()
      local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
      local JumpBtn = Instance.new("TextButton", ScreenGui)
      JumpBtn.Size = UDim2.new(0, 75, 0, 75)
      JumpBtn.Position = UDim2.new(0.8, 0, 0.65, 0)
      JumpBtn.Text = "JUMP"
      JumpBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
      Instance.new("UICorner", JumpBtn).CornerRadius = UDim.new(1, 0)
      JumpBtn.MouseButton1Click:Connect(function()
         lp.Character.Humanoid:ChangeState(3)
      end)
   end,
})

local isFlying = false
ScriptTab:CreateToggle({
   Name = "เปิดโหมดบิน (Fly Mode)",
   CurrentValue = false,
   Callback = function(v)
      isFlying = v
      local char = lp.Character or lp.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      if v then
         local bv = Instance.new("BodyVelocity", hrp)
         bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
         task.spawn(function()
            while isFlying do
               bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 50
               task.wait()
            end
            bv:Destroy()
         end)
      end
   end,
})

_G.HB_Size = 15
ScriptTab:CreateSlider({
   Name = "ขนาด Heat Box นักฆ่า",
   Range = {2, 100},
   Increment = 1,
   CurrentValue = 15,
   Callback = function(v) _G.HB_Size = v end,
})

ScriptTab:CreateToggle({
   Name = "เปิด Heat Box",
   CurrentValue = false,
   Callback = function(v)
      _G.HB_Enabled = v
      task.spawn(function()
         while _G.HB_Enabled do
            for _, plr in pairs(game.Players:GetPlayers()) do
               if plr ~= lp and plr.Character then
                  pcall(function()
                     local h = plr.Character.HumanoidRootPart
                     h.Size = Vector3.new(_G.HB_Size, _G.HB_Size, _G.HB_Size)
                     h.Transparency = 0.7
                     h.CanCollide = false
                  end)
               end
            end
            task.wait(0.2)
         end
      end)
   end,
})
