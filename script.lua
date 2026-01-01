-- [[ 🛡️ เจตจำนงของเจ้าของ: Goa8758 | ID: 9437139923 ]] --
-- [[ 🛠️ แก้ไขบัคทั้งหมดโดย Gemini Dev | Version: 64.0 ]] --

local lp = game.Players.LocalPlayer
local targetID = 9437139923
local isDev = (lp.UserId == targetID)

-- [[ 1. ฟังก์ชันป้องกันบัคการโหลด (Anti-Load Bug) ]] --
local function SafeLoad(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not success then
        warn("ดาวน์โหลด Library ไม่สำเร็จ กำลังลองใหม่...")
        task.wait(2)
        return loadstring(game:HttpGet(url))()
    end
    return result
end

local Rayfield = SafeLoad('https://sirius.menu/rayfield')

-- [[ 2. สร้างหน้าต่างเมนูหลัก ]] --
local Window = Rayfield:CreateWindow({
   Name = "NORINI HUB 👿 V64.0",
   LoadingTitle = isDev and "แอดมิน Goa8758 เข้าระบบแล้ว" or "ระบบป้องกันทำงาน...",
   LoadingSubtitle = "แก้บัคทั้งหมดเรียบร้อยแล้ว",
   KeySystem = not isDev,
   KeySettings = {
      Title = "Key System",
      Subtitle = "Join Discord for Key",
      Note = "คีย์ปัจจุบัน: 15466675546844776",
      FileName = "NoriniKey_Safe.json",
      SaveKey = true,
      Key = {"15466675546844776"}
   }
})

-- [[ 3. ฟังก์ชันฟาร์ม Zombies RNG (แก้บัคการเชื่อมต่อ) ]] --
local FarmTab = Window:CreateTab("Zombies RNG", "target")
FarmTab:CreateSection("🧟 ระบบฟาร์มอัตโนมัติ (เสถียร)")

_G.AutoRoll = false
FarmTab:CreateToggle({
   Name = "Auto Roll (สุ่มอัตโนมัติ)",
   CurrentValue = false,
   Callback = function(v)
      _G.AutoRoll = v
      task.spawn(function()
         while _G.AutoRoll do
            pcall(function()
                -- ตรวจสอบ Event ก่อนส่งคำสั่งป้องกันเกมเด้ง
                local event = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
                if event and event:FindFirstChild("RollEvent") then
                    event.RollEvent:FireServer("Roll")
                end
            end)
            task.wait(0.7) -- ความเร็วที่ปลอดภัยต่อเครื่อง
         end
      end)
   end,
})

-- [[ 4. แท็บ FE (แก้บัคตัวละครตายแล้วฟังก์ชันหาย) ]] --
local MainTab = Window:CreateTab("หน้าหลัก (FE)", "home")
MainTab:CreateSection("🛡️ อมตะ & บัคเลข (Anti-Reset)")

local function ApplyImmortal()
    pcall(function()
        local char = lp.Character or lp.CharacterAdded:Wait()
        local hum = char:WaitForChild("Humanoid")
        hum.Health = math.huge
        hum.RequiresNeck = false
    end)
end

MainTab:CreateButton({
   Name = "เปิดโหมดวิญญาณ (อมตะถาวร)",
   Callback = function()
      _G.Immortal = true
      ApplyImmortal()
      -- เช็คเมื่อตัวละครเกิดใหม่ ให้ใส่อมตะให้ทันที
      lp.CharacterAdded:Connect(function()
          if _G.Immortal then task.wait(0.5) ApplyImmortal() end
      end)
      Rayfield:Notify({Title = "สำเร็จ", Content = "คุณเป็นอมตะแล้วแม้จะเกิดใหม่", Duration = 3})
   end,
})

MainTab:CreateButton({
   Name = "เปิดระบบเลขบัค Infinite",
   Callback = function()
      task.spawn(function()
         while task.wait(1) do
            pcall(function()
               for _, v in pairs(lp:GetDescendants()) do
                  if v:IsA("NumberValue") and (v.Name:lower():find("health") or v.Name:lower():find("money") or v.Name:lower():find("luck")) then
                     v.Value = 9.9e18
                  end
               end
            end)
         end
      end)
   end,
})

-- [[ 5. แท็บเสริม (Fly/Speed/Jump) ]] --
local MoveTab = Window:CreateTab("การเคลื่อนที่", "zap")
MoveTab:CreateSlider({
   Name = "ปรับความเร็ว (Speed)",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v)
       pcall(function() lp.Character.Humanoid.WalkSpeed = v end)
   end,
})

MoveTab:CreateButton({
   Name = "สร้างปุ่มกระโดด (สำหรับมือถือ)",
   Callback = function()
      if game.CoreGui:FindFirstChild("MobileJumpUI") then return end -- ป้องกันบัคปุ่มซ้อน
      
      local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
      ScreenGui.Name = "MobileJumpUI"
      local JumpBtn = Instance.new("TextButton", ScreenGui)
      JumpBtn.Size = UDim2.new(0, 70, 0, 70)
      JumpBtn.Position = UDim2.new(0.85, 0, 0.7, 0)
      JumpBtn.Text = "JUMP"
      JumpBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
      JumpBtn.TextColor3 = Color3.new(1,1,1)
      Instance.new("UICorner", JumpBtn).CornerRadius = UDim.new(1, 0)
      JumpBtn.MouseButton1Click:Connect(function()
          pcall(function() lp.Character.Humanoid:ChangeState(3) end)
      end)
   end,
})

Rayfield:Notify({Title = "NORINI HUB Ready", Content = "แก้บัคเสร็จสิ้น ขอให้สนุกครับ Goa8758", Duration = 5})
