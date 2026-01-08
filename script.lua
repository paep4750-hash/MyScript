--[[
    สคริปต์นี้เป็นตัว Loader สำหรับดึงฟังก์ชันหลัก (Main Script)
    มีการเช็คระบบความปลอดภัยเบื้องต้น
]]

local UserID = 9437139923 -- ระบบอาจมีการบันทึก ID ของคุณไว้
local Script_Version = "v1.2"

-- ส่วนของการดึงฟังก์ชันจาก Server หลัก
local function LoadMain()
    local success, err = pcall(function()
        -- มันจะพยายามไปโหลดไฟล์ Main จากที่นี่
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BloxinStud10/24-Hours/main/Scripts/Main_Source.lua"))()
    end)
    
    if not success then
        warn("ไม่สามารถโหลดสคริปต์หลักได้: " .. tostring(err))
    end
end

-- ตรวจสอบว่า Executor ของคุณรองรับ HttpGet ไหม
if game:HttpGet then
    print("Hacklord: กำลังตรวจสอบสิทธิ์การใช้งาน...")
    LoadMain()
else
    print("Executor ของคุณไม่รองรับการดึงข้อมูลภายนอก")
end
