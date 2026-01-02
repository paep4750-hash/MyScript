-- [[ 🛡️ NORINI HUB V66.1 | GEF FIX ]] --
-- [[ Owner: Goa8758 ]] --

local lp = game.Players.LocalPlayer
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "NORINI HUB 👿 V66.1",
   LoadingTitle = "GEF Build Edition",
   KeySystem = (lp.UserId ~= 9437139923), -- ถ้าเป็น Goa8758 ไม่ต้องใส่คีย์
   KeySettings = {
      Title = "Key System",
      Key = {"15466675546844776"}
   }
})

local GEFTab = Window:CreateTab("GEF (ระบบสร้าง)", "hammer")

_G.FastPlace = false
GEFTab:CreateToggle({
   Name = "เปิดระบบวางรัว (ตามของในมือ)",
   CurrentValue = false,
   Callback = function(v)
      _G.FastPlace = v
      task.spawn(function()
         while _G.FastPlace do
            pcall(function()
                -- ตรวจสอบว่าถืออุปกรณ์ก่อสร้างอยู่ไหม
                local tool = lp.Character:FindFirstChildOfClass("Tool")
                if tool and (tool.Name:lower():find("hammer") or tool.Name:lower():find("build") or tool.Name:lower():find("wood")) then
                    -- ส่งคำสั่งวางรัวๆ ไปที่ตำแหน่งเมาส์/เป้าหมาย
                    local remote = tool:FindFirstChildOfClass("RemoteEvent") or game:GetService("ReplicatedStorage"):FindFirstChild("PlaceStructure")
                    if remote then
                        remote:FireServer(unpack({})) -- ส่งคำสั่งวางแบบไม่จำกัด
                    end
                end
            end)
            task.wait(0.05) -- ความเร็วระดับ "บัค" กำลังดี เครื่องไม่ค้าง
         end
      end)
   end,
})

GEFTab:CreateSection("ช่วยมองเห็น")
GEFTab:CreateButton({
   Name = "ลบหมอก/เปิดไฟ (FullBright)",
   Callback = function()
      game:GetService("Lighting").Brightness = 2
      game:GetService("Lighting").ClockTime = 14
      game:GetService("Lighting").FogEnd = 100000
   end,
})
