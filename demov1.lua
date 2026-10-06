local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

-- CẤU HÌNH KEY & ADMIN
local CORRECT_KEY = "VEROXHUB_KEY128634"
local ADMIN_NAME = "Monkeynicehihi"

----------------------------------------------------
-- 0. TẠO OVERHEAD TITLE TRÊN ĐẦU NHÂN VẬT
----------------------------------------------------
local function CreateOverhead(character)
    local head = character:WaitForChild("Head", 5)
    if not head then return end

    if head:FindFirstChild("OverheadTitle") then
        head.OverheadTitle:Destroy()
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "OverheadTitle"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2.8, 0)
    billboard.AlwaysOnTop = true

    local line1 = Instance.new("TextLabel")
    line1.Size = UDim2.new(1, 0, 0.45, 0)
    line1.Position = UDim2.new(0, 0, 0, 0)
    line1.BackgroundTransparency = 1
    line1.TextScaled = true
    line1.Font = Enum.Font.GothamBold
    line1.TextStrokeTransparency = 0
    line1.Parent = billboard

    local line2 = Instance.new("TextLabel")
    line2.Size = UDim2.new(1, 0, 0.5, 0)
    line2.Position = UDim2.new(0, 0, 0.45, 0)
    line2.BackgroundTransparency = 1
    line2.TextScaled = true
    line2.Font = Enum.Font.GothamBold
    line2.TextStrokeTransparency = 0
    line2.Parent = billboard

    if LocalPlayer.Name == ADMIN_NAME then
        line1.Text = "BY: NICE PRIME"
        line1.TextColor3 = Color3.fromRGB(255, 255, 255)
        line2.Text = "ADMIN👑"
        line2.TextColor3 = Color3.fromRGB(255, 200, 0)
    else
        line1.Text = "VEROX HUB"
        line1.TextColor3 = Color3.fromRGB(200, 200, 200)
        line2.Text = "MEMBER"
        line2.TextColor3 = Color3.fromRGB(150, 150, 150)
    end

    billboard.Parent = head
end

if LocalPlayer.Character then
    CreateOverhead(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(function(char)
    CreateOverhead(char)
end)

----------------------------------------------------
-- PARENT AN TOÀN & CLEAN UI CŨ
----------------------------------------------------
local function GetSafeParent()
    local target = nil
    if gethui then pcall(function() target = gethui() end) end
    if not target and LocalPlayer then pcall(function() target = LocalPlayer:FindFirstChildOfClass("PlayerGui") end) end
    if not target then pcall(function() target = CoreGui end) end
    return target
end

local ParentGui = GetSafeParent()

for _, v in ipairs(ParentGui:GetChildren()) do
    if v.Name == "VeroxHubGui" then
        v:Destroy()
    end
end

-- PALETTE MÀU
local Theme = {
    Background = Color3.fromRGB(15, 17, 23),
    Card = Color3.fromRGB(24, 28, 38),
    Accent = Color3.fromRGB(0, 230, 153),
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(200, 210, 225),
    Close = Color3.fromRGB(255, 75, 75),
    Warning = Color3.fromRGB(255, 170, 0),
    Admin = Color3.fromRGB(0, 255, 150),
    Member = Color3.fromRGB(170, 170, 170)
}

-- SCREEN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VeroxHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = ParentGui

----------------------------------------------------
-- 1. FRAME HỆ THỐNG KEY (KEY SYSTEM)
----------------------------------------------------
local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 360, 0, 260)
KeyFrame.Position = UDim2.new(0.5, -180, 0.5, -130)
KeyFrame.BackgroundColor3 = Theme.Background
KeyFrame.BorderSizePixel = 0
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.ClipsDescendants = true
KeyFrame.Parent = ScreenGui

local UICornerKey = Instance.new("UICorner")
UICornerKey.CornerRadius = UDim.new(0, 12)
UICornerKey.Parent = KeyFrame

local KeyBGImage = Instance.new("ImageLabel")
KeyBGImage.Size = UDim2.new(1, 0, 1, 0)
KeyBGImage.BackgroundTransparency = 1
KeyBGImage.Image = "rbxassetid://137468238820595"
KeyBGImage.ImageTransparency = 0.2
KeyBGImage.ScaleType = Enum.ScaleType.Crop
KeyBGImage.ZIndex = 0
KeyBGImage.Parent = KeyFrame

local KeyDarkOverlay = Instance.new("Frame")
KeyDarkOverlay.Size = UDim2.new(1, 0, 1, 0)
KeyDarkOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
KeyDarkOverlay.BackgroundTransparency = 0.4
KeyDarkOverlay.BorderSizePixel = 0
KeyDarkOverlay.ZIndex = 1
KeyDarkOverlay.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.Position = UDim2.new(0, 0, 0, 10)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "🔑 VEROX HUB - KEY SYSTEM"
KeyTitle.TextColor3 = Theme.Text
KeyTitle.TextSize = 14
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.ZIndex = 2
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -40, 0, 38)
KeyInput.Position = UDim2.new(0, 20, 0, 50)
KeyInput.BackgroundColor3 = Theme.Card
KeyInput.BackgroundTransparency = 0.3
KeyInput.TextColor3 = Theme.Accent
KeyInput.PlaceholderText = "Nhập Key tại đây..."
KeyInput.PlaceholderColor3 = Theme.SubText
KeyInput.Text = ""
KeyInput.Font = Enum.Font.GothamBold
KeyInput.TextSize = 12
KeyInput.BorderSizePixel = 0
KeyInput.ZIndex = 2
KeyInput.Parent = KeyFrame

local UICornerInput = Instance.new("UICorner")
UICornerInput.CornerRadius = UDim.new(0, 8)
UICornerInput.Parent = KeyInput

local BtnGetKey = Instance.new("TextButton")
BtnGetKey.Size = UDim2.new(0.43, 0, 0, 38)
BtnGetKey.Position = UDim2.new(0, 20, 0, 98)
BtnGetKey.BackgroundColor3 = Theme.Card
BtnGetKey.BackgroundTransparency = 0.3
BtnGetKey.Text = "GET KEY"
BtnGetKey.TextColor3 = Theme.Warning
BtnGetKey.Font = Enum.Font.GothamBold
BtnGetKey.TextSize = 11
BtnGetKey.BorderSizePixel = 0
BtnGetKey.ZIndex = 2
BtnGetKey.Parent = KeyFrame

local UICornerGet = Instance.new("UICorner")
UICornerGet.CornerRadius = UDim.new(0, 8)
UICornerGet.Parent = BtnGetKey

local BtnCheckKey = Instance.new("TextButton")
BtnCheckKey.Size = UDim2.new(0.43, 0, 0, 38)
BtnCheckKey.Position = UDim2.new(0.57, -20, 0, 98)
BtnCheckKey.BackgroundColor3 = Theme.Accent
BtnCheckKey.Text = "XÁC NHẬN KEY"
BtnCheckKey.TextColor3 = Color3.fromRGB(0, 0, 0)
BtnCheckKey.Font = Enum.Font.GothamBold
BtnCheckKey.TextSize = 11
BtnCheckKey.BorderSizePixel = 0
BtnCheckKey.ZIndex = 2
BtnCheckKey.Parent = KeyFrame

local UICornerCheck = Instance.new("UICorner")
UICornerCheck.CornerRadius = UDim.new(0, 8)
UICornerCheck.Parent = BtnCheckKey

local KeyStatus = Instance.new("TextLabel")
KeyStatus.Size = UDim2.new(1, -40, 0, 22)
KeyStatus.Position = UDim2.new(0, 20, 0, 142)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = ""
KeyStatus.TextColor3 = Theme.Text
KeyStatus.TextSize = 10
KeyStatus.Font = Enum.Font.GothamMedium
KeyStatus.ZIndex = 2
KeyStatus.Parent = KeyFrame

local KeyNote = Instance.new("TextLabel")
KeyNote.Size = UDim2.new(1, -40, 0, 80)
KeyNote.Position = UDim2.new(0, 20, 0, 170)
KeyNote.BackgroundTransparency = 1
KeyNote.Text = "📢 THÔNG BÁO\n• NGƯỜI GỬI: NICE PRIME\n• KEY SẼ RESET SAU 20:00 HẰNG NGÀY"
KeyNote.TextColor3 = Theme.SubText
KeyNote.TextSize = 10
KeyNote.Font = Enum.Font.GothamMedium
KeyNote.TextWrapped = true
KeyNote.TextYAlignment = Enum.TextYAlignment.Top
KeyNote.ZIndex = 2
KeyNote.Parent = KeyFrame

----------------------------------------------------
-- 2. MAIN HUB FRAME
----------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 340)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -170)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BackgroundTransparency = 1
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 12)
UICornerMain.Parent = MainFrame

local MainBGImage = Instance.new("ImageLabel")
MainBGImage.Name = "MainBGImage"
MainBGImage.Size = UDim2.new(1, 0, 1, 0)
MainBGImage.BackgroundTransparency = 1
MainBGImage.BorderSizePixel = 0
MainBGImage.Image = "rbxassetid://137468238820595"
MainBGImage.ImageTransparency = 0.15
MainBGImage.ScaleType = Enum.ScaleType.Crop
MainBGImage.ZIndex = 0
MainBGImage.Parent = MainFrame

local DarkOverlay = Instance.new("Frame")
DarkOverlay.Size = UDim2.new(1, 0, 1, 0)
DarkOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
DarkOverlay.BackgroundTransparency = 0.45
DarkOverlay.BorderSizePixel = 0
DarkOverlay.ZIndex = 1
DarkOverlay.Parent = MainFrame

local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Name = "VeroxToggle"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 20, 0.3, 0)
ToggleBtn.BackgroundColor3 = Theme.Background
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Image = "rbxassetid://137468238820595"
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Visible = false
ToggleBtn.Parent = ScreenGui

local UICornerToggle = Instance.new("UICorner")
UICornerToggle.CornerRadius = UDim.new(1, 0)
UICornerToggle.Parent = ToggleBtn

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 65)
Header.BackgroundTransparency = 1
Header.BorderSizePixel = 0
Header.ZIndex = 2
Header.Parent = MainFrame

local RoleBadge = Instance.new("TextLabel")
RoleBadge.Size = UDim2.new(1, -50, 0, 16)
RoleBadge.Position = UDim2.new(0, 16, 0, 6)
RoleBadge.BackgroundTransparency = 1
RoleBadge.Font = Enum.Font.GothamBold
RoleBadge.TextSize = 11
RoleBadge.TextXAlignment = Enum.TextXAlignment.Left
RoleBadge.ZIndex = 2
RoleBadge.Parent = Header

if LocalPlayer.Name == ADMIN_NAME then
    RoleBadge.Text = "👑 ROLE: ADMIN/DEV"
    RoleBadge.TextColor3 = Theme.Admin
else
    RoleBadge.Text = "👤 ROLE: MEMBER"
    RoleBadge.TextColor3 = Theme.Member
end

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -50, 0, 22)
TitleLabel.Position = UDim2.new(0, 16, 0, 22)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Theme.Text
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Text = "VEROX HUB"
TitleLabel.ZIndex = 2
TitleLabel.Parent = Header

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(1, -50, 0, 14)
VersionLabel.Position = UDim2.new(0, 16, 0, 44)
VersionLabel.BackgroundTransparency = 1
VersionLabel.TextColor3 = Theme.SubText
VersionLabel.TextSize = 10
VersionLabel.Font = Enum.Font.GothamMedium
VersionLabel.TextXAlignment = Enum.TextXAlignment.Left
VersionLabel.Text = "v1"
VersionLabel.ZIndex = 2
VersionLabel.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -36, 0, 12)
CloseBtn.BackgroundColor3 = Theme.Card
CloseBtn.BackgroundTransparency = 0.3
CloseBtn.TextColor3 = Theme.Close
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.Text = "✕"
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 2
CloseBtn.Parent = Header

local UICornerClose = Instance.new("UICorner")
UICornerClose.CornerRadius = UDim.new(0, 6)
UICornerClose.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

local ScrollContainer = Instance.new("ScrollingFrame")
ScrollContainer.Size = UDim2.new(1, -24, 1, -78)
ScrollContainer.Position = UDim2.new(0, 12, 0, 68)
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.BorderSizePixel = 0
ScrollContainer.ScrollBarThickness = 3
ScrollContainer.ScrollBarImageColor3 = Theme.Accent
ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollContainer.ZIndex = 2
ScrollContainer.Parent = MainFrame

local function CreateButton(parent, text, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = Theme.Card
    btn.BackgroundTransparency = 0.35
    btn.TextColor3 = color or Theme.Text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.Text = text
    btn.BorderSizePixel = 0
    btn.ZIndex = 3
    btn.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    return btn
end

-- PAGE 1
local GamePage = Instance.new("Frame")
GamePage.Name = "GamePage"
GamePage.Size = UDim2.new(1, 0, 1, 0)
GamePage.BackgroundTransparency = 1
GamePage.ZIndex = 2
GamePage.Parent = ScrollContainer

local GameList = Instance.new("UIListLayout")
GameList.SortOrder = Enum.SortOrder.LayoutOrder
GameList.Padding = UDim.new(0, 8)
GameList.Parent = GamePage

local BtnFixLag = CreateButton(GamePage, "⚡ FIX LAG (XÓA ĐỒ HỌA + SKIN)", Theme.Warning)
local BtnFishingMaster = CreateButton(GamePage, "🎣 FISHING MASTER", Theme.Accent)
local BtnStealEgg = CreateButton(GamePage, "🥚 STEAL AN EGG", Theme.Accent)

-- PAGE 2
local FishCategoryPage = Instance.new("Frame")
FishCategoryPage.Size = UDim2.new(1, 0, 1, 0)
FishCategoryPage.BackgroundTransparency = 1
FishCategoryPage.Visible = false
FishCategoryPage.ZIndex = 2
FishCategoryPage.Parent = ScrollContainer

local FishCatList = Instance.new("UIListLayout")
FishCatList.SortOrder = Enum.SortOrder.LayoutOrder
FishCatList.Padding = UDim.new(0, 8)
FishCatList.Parent = FishCategoryPage

local BackToGameBtn1 = CreateButton(FishCategoryPage, "⬅ Trở lại danh sách Game", Theme.SubText)
local BtnFishNoKeyOption = CreateButton(FishCategoryPage, "🔓 NO KEY", Theme.Accent)
local BtnFishKeyOption = CreateButton(FishCategoryPage, "🔑 CÓ KEY", Theme.Text)

-- PAGE 3
local EggCategoryPage = Instance.new("Frame")
EggCategoryPage.Size = UDim2.new(1, 0, 1, 0)
EggCategoryPage.BackgroundTransparency = 1
EggCategoryPage.Visible = false
EggCategoryPage.ZIndex = 2
EggCategoryPage.Parent = ScrollContainer

local EggCatList = Instance.new("UIListLayout")
EggCatList.SortOrder = Enum.SortOrder.LayoutOrder
EggCatList.Padding = UDim.new(0, 8)
EggCatList.Parent = EggCategoryPage

local BackToGameBtn2 = CreateButton(EggCategoryPage, "⬅ Trở lại danh sách Game", Theme.SubText)
local BtnEggNoKeyOption = CreateButton(EggCategoryPage, "🔓 NO KEY", Theme.Accent)
local BtnEggKeyOption = CreateButton(EggCategoryPage, "🔑 CÓ KEY", Theme.Text)

-- PAGE 4
local FishNoKeyPage = Instance.new("Frame")
FishNoKeyPage.Size = UDim2.new(1, 0, 1, 0)
FishNoKeyPage.BackgroundTransparency = 1
FishNoKeyPage.Visible = false
FishNoKeyPage.ZIndex = 2
FishNoKeyPage.Parent = ScrollContainer

local FishNoKeyList = Instance.new("UIListLayout")
FishNoKeyList.SortOrder = Enum.SortOrder.LayoutOrder
FishNoKeyList.Padding = UDim.new(0, 8)
FishNoKeyList.Parent = FishNoKeyPage

local BackToFishCat = CreateButton(FishNoKeyPage, "⬅ Trở lại (Fishing Master)", Theme.SubText)
local BtnTocoHub = CreateButton(FishNoKeyPage, "⚡ TOCO HUB", Theme.Accent)

-- PAGE 5
local FishKeyPage = Instance.new("Frame")
FishKeyPage.Size = UDim2.new(1, 0, 1, 0)
FishKeyPage.BackgroundTransparency = 1
FishKeyPage.Visible = false
FishKeyPage.ZIndex = 2
FishKeyPage.Parent = ScrollContainer

local FishKeyList = Instance.new("UIListLayout")
FishKeyList.SortOrder = Enum.SortOrder.LayoutOrder
FishKeyList.Padding = UDim.new(0, 8)
FishKeyList.Parent = FishKeyPage

local BackToFishCat2 = CreateButton(FishKeyPage, "⬅ Trở lại (Fishing Master)", Theme.SubText)

-- PAGE 6
local EggNoKeyPage = Instance.new("Frame")
EggNoKeyPage.Size = UDim2.new(1, 0, 1, 0)
EggNoKeyPage.BackgroundTransparency = 1
EggNoKeyPage.Visible = false
EggNoKeyPage.ZIndex = 2
EggNoKeyPage.Parent = ScrollContainer

local EggNoKeyList = Instance.new("UIListLayout")
EggNoKeyList.SortOrder = Enum.SortOrder.LayoutOrder
EggNoKeyList.Padding = UDim.new(0, 8)
EggNoKeyList.Parent = EggNoKeyPage

local BackToEggCat = CreateButton(EggNoKeyPage, "⬅ Trở lại (Steal An Egg)", Theme.SubText)
local BtnChiilyHubV3 = CreateButton(EggNoKeyPage, "🌶️ CHIILY HUB V3", Theme.Accent)

-- PAGE 7
local EggKeyPage = Instance.new("Frame")
EggKeyPage.Size = UDim2.new(1, 0, 1, 0)
EggKeyPage.BackgroundTransparency = 1
EggKeyPage.Visible = false
EggKeyPage.ZIndex = 2
EggKeyPage.Parent = ScrollContainer

local EggKeyList = Instance.new("UIListLayout")
EggKeyList.SortOrder = Enum.SortOrder.LayoutOrder
EggKeyList.Padding = UDim.new(0, 8)
EggKeyList.Parent = EggKeyPage

local BackToEggCat2 = CreateButton(EggKeyPage, "⬅ Trở lại (Steal An Egg)", Theme.SubText)

----------------------------------------------------
-- LOGIC SỰ KIỆN KEY SYSTEM
----------------------------------------------------
BtnGetKey.MouseButton1Click:Connect(function()
    KeyInput.Text = CORRECT_KEY
    if setclipboard then
        pcall(function() setclipboard(CORRECT_KEY) end)
        KeyStatus.Text = "✓ Đã sao chép Key: " .. CORRECT_KEY
    else
        KeyStatus.Text = "Key của bạn: " .. CORRECT_KEY
    end
    KeyStatus.TextColor3 = Theme.Accent
end)

BtnCheckKey.MouseButton1Click:Connect(function()
    if KeyInput.Text == CORRECT_KEY then
        KeyStatus.Text = "✓ Key chính xác! Đang mở Hub..."
        KeyStatus.TextColor3 = Theme.Accent
        task.wait(1)
        KeyFrame:Destroy()
        MainFrame.Visible = true
        ToggleBtn.Visible = true
    else
        KeyStatus.Text = "✕ Key sai! Vui lòng thử lại."
        KeyStatus.TextColor3 = Theme.Close
    end
end)

----------------------------------------------------
-- LOGIC CHUYỂN TRANG
----------------------------------------------------
BtnFishingMaster.MouseButton1Click:Connect(function() GamePage.Visible = false; FishCategoryPage.Visible = true end)
BtnStealEgg.MouseButton1Click:Connect(function() GamePage.Visible = false; EggCategoryPage.Visible = true end)
BackToGameBtn1.MouseButton1Click:Connect(function() FishCategoryPage.Visible = false; GamePage.Visible = true end)
BackToGameBtn2.MouseButton1Click:Connect(function() EggCategoryPage.Visible = false; GamePage.Visible = true end)
BtnFishNoKeyOption.MouseButton1Click:Connect(function() FishCategoryPage.Visible = false; FishNoKeyPage.Visible = true end)
BtnFishKeyOption.MouseButton1Click:Connect(function() FishCategoryPage.Visible = false; FishKeyPage.Visible = true end)
BackToFishCat.MouseButton1Click:Connect(function() FishNoKeyPage.Visible = false; FishCategoryPage.Visible = true end)
BackToFishCat2.MouseButton1Click:Connect(function() FishKeyPage.Visible = false; FishCategoryPage.Visible = true end)
BtnEggNoKeyOption.MouseButton1Click:Connect(function() EggCategoryPage.Visible = false; EggNoKeyPage.Visible = true end)
BtnEggKeyOption.MouseButton1Click:Connect(function() EggCategoryPage.Visible = false; EggKeyPage.Visible = true end)
BackToEggCat.MouseButton1Click:Connect(function() EggNoKeyPage.Visible = false; EggCategoryPage.Visible = true end)
BackToEggCat2.MouseButton1Click:Connect(function() EggKeyPage.Visible = false; EggCategoryPage.Visible = true end)

-- RUN SCRIPTS
BtnTocoHub.MouseButton1Click:Connect(function()
    BtnTocoHub.Text = "⏳ ĐANG KHỞI CHẠY..."
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Tocolate1111111/fishingmaster/refs/heads/main/tocohub.lua"))() end)
    task.wait(1)
    BtnTocoHub.Text = "✓ ĐÃ BẬT TOCO HUB"
    task.wait(2)
    BtnTocoHub.Text = "⚡ TOCO HUB"
end)

BtnChiilyHubV3.MouseButton1Click:Connect(function()
    BtnChiilyHubV3.Text = "⏳ ĐANG KHỞI CHẠY..."
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/khauow386-dot/Kha-hup-rayfi/refs/heads/main/Chilihupv3"))() end)
    task.wait(1)
    BtnChiilyHubV3.Text = "✓ ĐÃ BẬT CHIILY HUB V3"
    task.wait(2)
    BtnChiilyHubV3.Text = "🌶 CHIILY HUB V3"
end)

-- FIX LAG
BtnFixLag.MouseButton1Click:Connect(function()
    BtnFixLag.Text = "⏳ ĐANG FIX LAG..."
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then v:Destroy() end
        end
        for _, obj in ipairs(game:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0
                obj.CastShadow = false
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj:Destroy()
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = false
            end
        end
        local function RemoveSkins(char)
            for _, item in ipairs(char:GetChildren()) do
                if item:IsA("Clothing") or item:IsA("ShirtGraphic") or item:IsA("Accessory") or item:IsA("CharacterMesh") then
                    item:Destroy()
                end
            end
        end
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then RemoveSkins(plr.Character) end
            plr.CharacterAdded:Connect(RemoveSkins)
        end
    end)
    task.wait(1)
    BtnFixLag.Text = "✓ ĐÃ FIX LAG THÀNH CÔNG"
    task.wait(2)
    BtnFixLag.Text = "⚡ FIX LAG (XÓA ĐỒ HỌA + SKIN)"
end)

