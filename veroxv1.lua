local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

-- CẤU HÌNH KEY MỚI & ADMIN & HÌNH NỀN
local CORRECT_KEY = "VEROXHUB_FREEKEY!"
local ADMIN_NAME = "Monkeynicehihi"
local BACKGROUND_IMAGE_ID = "rbxassetid://137468238820595"

-- NGÔN NGỮ MẶC ĐỊNH ("VI" hoặc "EN")
local CurrentLang = "VI"

----------------------------------------------------
-- REMOTE EVENT CHAT TRONG MENU
----------------------------------------------------
local InternalChatEvent = ReplicatedStorage:FindFirstChild("VeroxHubChatEvent")
if not InternalChatEvent then
    InternalChatEvent = Instance.new("RemoteEvent")
    InternalChatEvent.Name = "VeroxHubChatEvent"
    InternalChatEvent.Parent = ReplicatedStorage
end

----------------------------------------------------
-- TỰ ĐỘNG CHAT KHUNG CHAT GAME
----------------------------------------------------
local function SendChatMessage(message)
    pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            local generalChannel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
            if generalChannel then generalChannel:SendAsync(message) end
        else
            ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                :FindFirstChild("SayMessageRequest")
                :FireServer(message, "All")
        end
    end)
end

task.spawn(function()
    task.wait(1.5)
    SendChatMessage("VEROX HUB")
    task.wait(0.5)
    SendChatMessage("BY NICE PRIME!")
end)

----------------------------------------------------
-- OVERHEAD TITLE TRÊN ĐẦU NHÂN VẬT
----------------------------------------------------
local function CreateOverhead(character)
    local head = character:WaitForChild("Head", 5)
    if not head then return end

    if head:FindFirstChild("OverheadTitle") then head.OverheadTitle:Destroy() end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "OverheadTitle"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 220, 0, 55)
    billboard.StudsOffset = Vector3.new(0, 2.8, 0)
    billboard.AlwaysOnTop = true

    local line1 = Instance.new("TextLabel")
    line1.Size = UDim2.new(1, 0, 0.45, 0)
    line1.BackgroundTransparency = 1
    line1.TextScaled = true
    line1.Font = Enum.Font.GothamBold
    line1.TextStrokeTransparency = 0
    line1.Text = "BY NICE PRIME!"
    line1.TextColor3 = Color3.fromRGB(255, 255, 255)
    line1.Parent = billboard

    local line2 = Instance.new("TextLabel")
    line2.Size = UDim2.new(1, 0, 0.5, 0)
    line2.Position = UDim2.new(0, 0, 0.45, 0)
    line2.BackgroundTransparency = 1
    line2.TextScaled = true
    line2.Font = Enum.Font.SpecialElite
    line2.TextStrokeTransparency = 0
    line2.Parent = billboard

    if LocalPlayer.Name == ADMIN_NAME then
        line2.Text = "👑 [OWNER] 👑"
        line2.TextColor3 = Color3.fromRGB(255, 40, 40)
        line2.Font = Enum.Font.GothamBold
    elseif LocalPlayer.Name == "Khaden1999" then
        line2.Text = "☠️ H̵A̵C̵K̵E̵R̵ ̵G̵O̵D̵ ☠️"
        line2.TextColor3 = Color3.fromRGB(0, 255, 120)
    else
        line2.Text = "VEROX MEMBER"
        line2.TextColor3 = Color3.fromRGB(180, 180, 180)
        line2.Font = Enum.Font.GothamBold
    end

    billboard.Parent = head
end

if LocalPlayer.Character then CreateOverhead(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(function(char) CreateOverhead(char) end)

----------------------------------------------------
-- CLEAN UI CŨ
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
    if v.Name == "VeroxHubGui" then v:Destroy() end
end

local Theme = {
    Background = Color3.fromRGB(16, 14, 22),
    Sidebar = Color3.fromRGB(11, 9, 15),
    Card = Color3.fromRGB(24, 20, 32),
    Accent = Color3.fromRGB(150, 100, 255),
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(150, 145, 165),
    Close = Color3.fromRGB(255, 80, 80),
    Warning = Color3.fromRGB(255, 170, 0),
    Admin = Color3.fromRGB(255, 215, 0)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VeroxHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = ParentGui

----------------------------------------------------
-- DỮ LIỆU NGÔN NGỮ
----------------------------------------------------
local Translations = {
    VI = {
        KeyTitle = "🔑 VEROX HUB - HỆ THỐNG KEY",
        KeyPlaceholder = "Nhập Key tại đây...",
        BtnGetKey = "LẤY KEY",
        BtnCheckKey = "XÁC NHẬN KEY",
        KeyNote = "📢 THÔNG BÁO\n• TỪ ADMIN\n• HIỆN TẠI SẼ FREE ĐẾN NGÀY 20 NHÉ ANH EM SAU NGÀY HAỊ MƯƠI SẼ BẮT ĐẦU THÊM KEY!",
        KeySuccess = "✓ Key chính xác! Đang mở Hub...",
        KeyFail = "✕ Key sai! Vui lòng thử lại.",
        KeyCopied = "✓ Đã lấy & sao chép Key: ",
        
        TabHome = "Trang Chủ",
        TabBrowse = "Danh Sách Game",
        TabESP = "Tính Năng ESP",
        TabChat = "Trò Chuyện",
        TabFixLag = "Giảm Lag",
        TabSettings = "Cài Đặt",
        
        Hello = "Xin chào, ",
        AdminRank = "👑 [OWNER]",
        HackerRank = "☠️ HACKER GOD",
        MemberRank = "Thành viên Verox",
        ServerHop = "🌐 CHUYỂN SERVER (HOP)",
        BtnMenuHop = "BẤM ĐỂ CHUYỂN SERVER",
        HopOpening = "⏳ ĐANG MỞ HOP...",
        SysInfo = "THÔNG TIN HỆ THỐNG",
        
        PlayerEspToggle = "👁️ ESP HIỆN TÊN NGƯỜI CHƠI",
        TrapEspToggle = "⚠️ ESP ĐỊNH VỊ BÃY (TRAP)",
        
        SelectGame = "Danh sách Game & Chế độ Key",
        BackToGameList = "⬅ Trở lại danh sách Game",
        BackToStealEgg = "⬅ Trở lại (Steal An Egg)",
        BackToFishMaster = "⬅ Trở lại (Fishing Master)",
        StealEggNoKey = "🔓 STEAL AN EGG NO KEY",
        StealEggKey = "🔑 STEAL AN EGG CÓ KEY",
        FishNoKey = "🔓 FISHING MASTER NO KEY",
        
        ChatPlaceholder = "Nhập bình luận tại đây...",
        BtnSend = "GỬI",
        BtnFixLagAction = "⚡ FIX LAG (XÓA ĐỒ HỌA + SKIN)",
        
        LangTitle = "⚙️ CÀI ĐẶT NGÔN NGỮ",
        SelectLangLabel = "Chọn Ngôn Ngữ / Select Language:"
    },
    EN = {
        KeyTitle = "🔑 VEROX HUB - KEY SYSTEM",
        KeyPlaceholder = "Enter Key here...",
        BtnGetKey = "GET KEY",
        BtnCheckKey = "CONFIRM KEY",
        KeyNote = "📢 ANNOUNCEMENT\n• FROM ADMIN\n• CURRENTLY FREE UNTIL DAY 20! KEY SYSTEM WILL BE ADDED AFTER!",
        KeySuccess = "✓ Correct Key! Opening Hub...",
        KeyFail = "✕ Wrong Key! Please try again.",
        KeyCopied = "✓ Key copied: ",
        
        TabHome = "Home",
        TabBrowse = "Browse",
        TabESP = "ESP Visuals",
        TabChat = "Server Chat",
        TabFixLag = "Fix Lag",
        TabSettings = "Settings",
        
        Hello = "Hello, ",
        AdminRank = "👑 [OWNER]",
        HackerRank = "☠️ HACKER GOD",
        MemberRank = "Verox Member",
        ServerHop = "🌐 SERVER HOP",
        BtnMenuHop = "CLICK TO MENU HOP",
        HopOpening = "⏳ OPENING HOP...",
        SysInfo = "SYSTEM INFO",
        
        PlayerEspToggle = "👁️ PLAYER NAME ESP",
        TrapEspToggle = "⚠️ TRAP DETECTOR ESP",
        
        SelectGame = "Game List & Key Modes",
        BackToGameList = "⬅ Back to Game List",
        BackToStealEgg = "⬅ Back (Steal An Egg)",
        BackToFishMaster = "⬅ Back (Fishing Master)",
        StealEggNoKey = "🔓 STEAL AN EGG NO KEY",
        StealEggKey = "🔑 STEAL AN EGG WITH KEY",
        FishNoKey = "🔓 FISHING MASTER NO KEY",
        
        ChatPlaceholder = "Enter comment here...",
        BtnSend = "SEND",
        BtnFixLagAction = "⚡ FIX LAG (REMOVE GRAPHICS + SKIN)",
        
        LangTitle = "⚙️ LANGUAGE SETTINGS",
        SelectLangLabel = "Select Language / Chọn Ngôn Ngữ:"
    }
}

----------------------------------------------------
-- 1. FRAME KEY SYSTEM
----------------------------------------------------
local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 360, 0, 270)
KeyFrame.Position = UDim2.new(0.5, -180, 0.5, -135)
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
KeyBGImage.Image = BACKGROUND_IMAGE_ID
KeyBGImage.ImageTransparency = 0.3
KeyBGImage.ScaleType = Enum.ScaleType.Crop
KeyBGImage.ZIndex = 0
KeyBGImage.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.Position = UDim2.new(0, 0, 0, 10)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = Translations[CurrentLang].KeyTitle
KeyTitle.TextColor3 = Theme.Text
KeyTitle.TextSize = 14
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.ZIndex = 2
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -40, 0, 38)
KeyInput.Position = UDim2.new(0, 20, 0, 50)
KeyInput.BackgroundColor3 = Theme.Card
KeyInput.BackgroundTransparency = 0.2
KeyInput.TextColor3 = Theme.Accent
KeyInput.PlaceholderText = Translations[CurrentLang].KeyPlaceholder
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
BtnGetKey.Size = UDim2.new(0, 155, 0, 36)
BtnGetKey.Position = UDim2.new(0, 20, 0, 96)
BtnGetKey.BackgroundColor3 = Theme.Card
BtnGetKey.BackgroundTransparency = 0.2
BtnGetKey.Text = Translations[CurrentLang].BtnGetKey
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
BtnCheckKey.Size = UDim2.new(0, 155, 0, 36)
BtnCheckKey.Position = UDim2.new(1, -175, 0, 96)
BtnCheckKey.BackgroundColor3 = Theme.Accent
BtnCheckKey.Text = Translations[CurrentLang].BtnCheckKey
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
KeyStatus.Size = UDim2.new(1, -40, 0, 20)
KeyStatus.Position = UDim2.new(0, 20, 0, 138)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = ""
KeyStatus.TextColor3 = Theme.Text
KeyStatus.TextSize = 10
KeyStatus.Font = Enum.Font.GothamMedium
KeyStatus.ZIndex = 2
KeyStatus.Parent = KeyFrame

local KeyNote = Instance.new("TextLabel")
KeyNote.Size = UDim2.new(1, -40, 0, 90)
KeyNote.Position = UDim2.new(0, 20, 0, 160)
KeyNote.BackgroundTransparency = 1
KeyNote.Text = Translations[CurrentLang].KeyNote
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
MainFrame.Size = UDim2.new(0, 660, 0, 380)
MainFrame.Position = UDim2.new(0.5, -330, 0.5, -190)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 16)
UICornerMain.Parent = MainFrame

local MainBGImage = Instance.new("ImageLabel")
MainBGImage.Name = "MainBackgroundImage"
MainBGImage.Size = UDim2.new(1, 0, 1, 0)
MainBGImage.BackgroundTransparency = 1
MainBGImage.Image = BACKGROUND_IMAGE_ID
MainBGImage.ImageTransparency = 0.35
MainBGImage.ScaleType = Enum.ScaleType.Crop
MainBGImage.ZIndex = 0
MainBGImage.Parent = MainFrame

local TogglePill = Instance.new("ImageButton")
TogglePill.Name = "VeroxPillToggle"
TogglePill.Size = UDim2.new(0, 50, 0, 50)
TogglePill.Position = UDim2.new(1, -65, 0, 20)
TogglePill.BackgroundColor3 = Theme.Sidebar
TogglePill.Image = BACKGROUND_IMAGE_ID
TogglePill.BorderSizePixel = 0
TogglePill.Active = true
TogglePill.Draggable = true
TogglePill.Visible = false
TogglePill.Parent = ScreenGui

local UICornerPill = Instance.new("UICorner")
UICornerPill.CornerRadius = UDim.new(1, 0)
UICornerPill.Parent = TogglePill

TogglePill.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -32, 0, 12)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextColor3 = Theme.SubText
CloseBtn.Font = Enum.Font.GothamMedium
CloseBtn.TextSize = 14
CloseBtn.Text = "✕"
CloseBtn.ZIndex = 10
CloseBtn.Parent = MainFrame

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

----------------------------------------------------
-- SIDEBAR BÊN TRÁI
----------------------------------------------------
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 180, 1, 0)
Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.BackgroundTransparency = 0.2
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 2
Sidebar.Parent = MainFrame

local UICornerSidebar = Instance.new("UICorner")
UICornerSidebar.CornerRadius = UDim.new(0, 16)
UICornerSidebar.Parent = Sidebar

local LogoIcon = Instance.new("TextLabel")
LogoIcon.Size = UDim2.new(0, 30, 0, 30)
LogoIcon.Position = UDim2.new(0, 14, 0, 14)
LogoIcon.BackgroundTransparency = 1
LogoIcon.Text = "🎮"
LogoIcon.TextSize = 18
LogoIcon.ZIndex = 3
LogoIcon.Parent = Sidebar

local LogoLabel = Instance.new("TextLabel")
LogoLabel.Size = UDim2.new(1, -55, 0, 20)
LogoLabel.Position = UDim2.new(0, 48, 0, 12)
LogoLabel.BackgroundTransparency = 1
LogoLabel.Text = "Verox Hub"
LogoLabel.TextColor3 = Theme.Text
LogoLabel.TextSize = 14
LogoLabel.Font = Enum.Font.GothamBold
LogoLabel.TextXAlignment = Enum.TextXAlignment.Left
LogoLabel.ZIndex = 3
LogoLabel.Parent = Sidebar

local SubLogoLabel = Instance.new("TextLabel")
SubLogoLabel.Size = UDim2.new(1, -55, 0, 14)
SubLogoLabel.Position = UDim2.new(0, 48, 0, 30)
SubLogoLabel.BackgroundTransparency = 1
SubLogoLabel.Text = "V2 - UPDATE!"
SubLogoLabel.TextColor3 = Theme.Accent
SubLogoLabel.TextSize = 9
SubLogoLabel.Font = Enum.Font.GothamBold
SubLogoLabel.TextXAlignment = Enum.TextXAlignment.Left
SubLogoLabel.ZIndex = 3
SubLogoLabel.Parent = Sidebar

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 1, -65)
TabContainer.Position = UDim2.new(0, 10, 0, 58)
TabContainer.BackgroundTransparency = 1
TabContainer.ZIndex = 3
TabContainer.Parent = Sidebar

local TabLayout = Instance.new("UIListLayout")
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 4)
TabLayout.Parent = TabContainer

----------------------------------------------------
-- CONTENT AREA BÊN PHẢI
----------------------------------------------------
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -200, 1, -20)
ContentArea.Position = UDim2.new(0, 190, 0, 12)
ContentArea.BackgroundTransparency = 1
ContentArea.ZIndex = 2
ContentArea.Parent = MainFrame

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1, -40, 0, 22)
HeaderTitle.Position = UDim2.new(0, 0, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = Translations[CurrentLang].TabHome
HeaderTitle.TextColor3 = Theme.Text
HeaderTitle.TextSize = 18
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.ZIndex = 3
HeaderTitle.Parent = ContentArea

local HeaderSub = Instance.new("TextLabel")
HeaderSub.Size = UDim2.new(1, -40, 0, 14)
HeaderSub.Position = UDim2.new(0, 0, 0, 22)
HeaderSub.BackgroundTransparency = 1
HeaderSub.Text = "Session"
HeaderSub.TextColor3 = Theme.SubText
HeaderSub.TextSize = 10
HeaderSub.Font = Enum.Font.GothamMedium
HeaderSub.TextXAlignment = Enum.TextXAlignment.Left
HeaderSub.ZIndex = 3
HeaderSub.Parent = ContentArea

----------------------------------------------------
-- QUẢN LÝ TAB & PAGES
----------------------------------------------------
local Tabs = {}
local Pages = {}

local function CreateTab(tabKey, icon, pageSub)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = "Tab_" .. tabKey
    tabBtn.Size = UDim2.new(1, 0, 0, 32)
    tabBtn.BackgroundColor3 = Theme.Card
    tabBtn.BackgroundTransparency = 1
    tabBtn.Text = "  " .. icon .. "  " .. Translations[CurrentLang][tabKey]
    tabBtn.TextColor3 = Theme.SubText
    tabBtn.Font = Enum.Font.GothamMedium
    tabBtn.TextSize = 11
    tabBtn.TextXAlignment = Enum.TextXAlignment.Left
    tabBtn.BorderSizePixel = 0
    tabBtn.ZIndex = 3
    tabBtn.Parent = TabContainer

    local UICornerTab = Instance.new("UICorner")
    UICornerTab.CornerRadius = UDim.new(0, 8)
    UICornerTab.Parent = tabBtn

    local page = Instance.new("ScrollingFrame")
    page.Name = "Page_" .. tabKey
    page.Size = UDim2.new(1, 0, 1, -45)
    page.Position = UDim2.new(0, 0, 0, 45)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Theme.Accent
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.ZIndex = 3
    page.Parent = ContentArea

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Padding = UDim.new(0, 8)
    pageLayout.Parent = page

    tabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            t.BackgroundTransparency = 1
            t.TextColor3 = Theme.SubText
            t.Font = Enum.Font.GothamMedium
        end
        for _, p in pairs(Pages) do
            p.Visible = false
        end
        tabBtn.BackgroundTransparency = 0.2
        tabBtn.BackgroundColor3 = Theme.Card
        tabBtn.TextColor3 = Theme.Text
        tabBtn.Font = Enum.Font.GothamBold
        page.Visible = true
        HeaderTitle.Text = Translations[CurrentLang][tabKey]
        HeaderSub.Text = pageSub or "Script Selection"
    end)

    table.insert(Tabs, tabBtn)
    table.insert(Pages, page)

    return page, tabBtn
end

local function CreateScriptButton(parent, text, callback, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 38)
    btn.BackgroundColor3 = Theme.Card
    btn.BackgroundTransparency = 0.2
    btn.TextColor3 = color or Theme.Text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.Text = text
    btn.BorderSizePixel = 0
    btn.ZIndex = 4
    btn.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    if callback then btn.MouseButton1Click:Connect(callback) end
    return btn
end

----------------------------------------------------
-- TẠO CÁC TAB SIDEBAR
----------------------------------------------------
local PageHome, TabHomeBtn = CreateTab("TabHome", "🏠", "Session Info & Tools")
local PageBrowse = CreateTab("TabBrowse", "🔍", Translations[CurrentLang].SelectGame)
local PageESP = CreateTab("TabESP", "👁️", "Player & Trap Esp Features")
local PageChat = CreateTab("TabChat", "💬", "Global Menu Discussion")
local PageFixLag = CreateTab("TabFixLag", "⚡", "Optimization Tools")
local PageSettings = CreateTab("TabSettings", "⚙️", "Language Settings")

TabHomeBtn.BackgroundTransparency = 0.2
TabHomeBtn.BackgroundColor3 = Theme.Card
TabHomeBtn.TextColor3 = Theme.Text
TabHomeBtn.Font = Enum.Font.GothamBold
PageHome.Visible = true

----------------------------------------------------
-- TAB HOME
----------------------------------------------------
local ProfileCard = Instance.new("Frame")
ProfileCard.Size = UDim2.new(1, -10, 0, 58)
ProfileCard.BackgroundColor3 = Theme.Card
ProfileCard.BackgroundTransparency = 0.2
ProfileCard.ZIndex = 3
ProfileCard.Parent = PageHome

local UICornerProf = Instance.new("UICorner")
UICornerProf.CornerRadius = UDim.new(0, 10)
UICornerProf.Parent = ProfileCard

local AvatarImg = Instance.new("ImageLabel")
AvatarImg.Size = UDim2.new(0, 40, 0, 40)
AvatarImg.Position = UDim2.new(0, 10, 0, 9)
AvatarImg.BackgroundTransparency = 1
AvatarImg.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
AvatarImg.ZIndex = 4
AvatarImg.Parent = ProfileCard

local UICornerAv = Instance.new("UICorner")
UICornerAv.CornerRadius = UDim.new(0, 8)
UICornerAv.Parent = AvatarImg

local HelloLabel = Instance.new("TextLabel")
HelloLabel.Name = "HelloLabel"
HelloLabel.Size = UDim2.new(1, -60, 0, 18)
HelloLabel.Position = UDim2.new(0, 58, 0, 12)
HelloLabel.BackgroundTransparency = 1
HelloLabel.Text = Translations[CurrentLang].Hello .. LocalPlayer.DisplayName
HelloLabel.TextColor3 = Theme.Text
HelloLabel.TextSize = 12
HelloLabel.Font = Enum.Font.GothamBold
HelloLabel.TextXAlignment = Enum.TextXAlignment.Left
HelloLabel.ZIndex = 4
HelloLabel.Parent = ProfileCard

local GoodLabel = Instance.new("TextLabel")
GoodLabel.Name = "GoodLabel"
GoodLabel.Size = UDim2.new(1, -60, 0, 14)
GoodLabel.Position = UDim2.new(0, 58, 0, 30)
GoodLabel.BackgroundTransparency = 1

local function GetUserRankText(lang)
    if LocalPlayer.Name == ADMIN_NAME then
        return Translations[lang].AdminRank
    elseif LocalPlayer.Name == "Khaden1999" then
        return Translations[lang].HackerRank
    else
        return Translations[lang].MemberRank
    end
end

GoodLabel.Text = GetUserRankText(CurrentLang)
GoodLabel.TextColor3 = (LocalPlayer.Name == ADMIN_NAME and Color3.fromRGB(255, 40, 40) or (LocalPlayer.Name == "Khaden1999" and Color3.fromRGB(0, 255, 120) or Theme.SubText))
GoodLabel.TextSize = 10
GoodLabel.Font = Enum.Font.GothamMedium
GoodLabel.TextXAlignment = Enum.TextXAlignment.Left
GoodLabel.ZIndex = 4
GoodLabel.Parent = ProfileCard

-- SERVER HOP CARD
local ServerHopCard = Instance.new("Frame")
ServerHopCard.Size = UDim2.new(1, -10, 0, 50)
ServerHopCard.BackgroundColor3 = Theme.Card
ServerHopCard.BackgroundTransparency = 0.2
ServerHopCard.ZIndex = 3
ServerHopCard.Parent = PageHome

local UICornerHop = Instance.new("UICorner")
UICornerHop.CornerRadius = UDim.new(0, 10)
UICornerHop.Parent = ServerHopCard

local HopTitle = Instance.new("TextLabel")
HopTitle.Name = "HopTitle"
HopTitle.Size = UDim2.new(0.5, 0, 1, 0)
HopTitle.Position = UDim2.new(0, 12, 0, 0)
HopTitle.BackgroundTransparency = 1
HopTitle.Text = Translations[CurrentLang].ServerHop
HopTitle.TextColor3 = Theme.Text
HopTitle.TextSize = 11
HopTitle.Font = Enum.Font.GothamBold
HopTitle.TextXAlignment = Enum.TextXAlignment.Left
HopTitle.ZIndex = 4
HopTitle.Parent = ServerHopCard

local HopBtn = Instance.new("TextButton")
HopBtn.Name = "HopBtn"
HopBtn.Size = UDim2.new(0, 150, 0, 32)
HopBtn.Position = UDim2.new(1, -160, 0.5, -16)
HopBtn.BackgroundColor3 = Theme.Accent
HopBtn.Text = Translations[CurrentLang].BtnMenuHop
HopBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
HopBtn.Font = Enum.Font.GothamBold
HopBtn.TextSize = 10
HopBtn.BorderSizePixel = 0
HopBtn.ZIndex = 4
HopBtn.Parent = ServerHopCard

local UICornerHopBtn = Instance.new("UICorner")
UICornerHopBtn.CornerRadius = UDim.new(0, 6)
UICornerHopBtn.Parent = HopBtn

HopBtn.MouseButton1Click:Connect(function()
    HopBtn.Text = Translations[CurrentLang].HopOpening
    pcall(function()
        loadstring(game:HttpGet("https://pastefy.app/YoZocJ8O/raw"))()
    end)
    task.wait(1.5)
    HopBtn.Text = Translations[CurrentLang].BtnMenuHop
end)

-- SYSTEM INFO GRID
local SysHeaderLabel = Instance.new("TextLabel")
SysHeaderLabel.Name = "SysHeaderLabel"
SysHeaderLabel.Size = UDim2.new(1, -10, 0, 18)
SysHeaderLabel.BackgroundTransparency = 1
SysHeaderLabel.Text = Translations[CurrentLang].SysInfo
SysHeaderLabel.TextColor3 = Theme.SubText
SysHeaderLabel.TextSize = 9
SysHeaderLabel.Font = Enum.Font.GothamBold
SysHeaderLabel.TextXAlignment = Enum.TextXAlignment.Left
SysHeaderLabel.ZIndex = 3
SysHeaderLabel.Parent = PageHome

local GridContainer = Instance.new("Frame")
GridContainer.Size = UDim2.new(1, -10, 0, 110)
GridContainer.BackgroundTransparency = 1
GridContainer.ZIndex = 3
GridContainer.Parent = PageHome

local GridLayout = Instance.new("UIGridLayout")
GridLayout.CellSize = UDim2.new(0.485, 0, 0, 48)
GridLayout.CellPadding = UDim2.new(0.03, 0, 0, 6)
GridLayout.Parent = GridContainer

local function CreateNexoraCard(title, val)
    local card = Instance.new("Frame")
    card.BackgroundColor3 = Theme.Card
    card.BackgroundTransparency = 0.2
    card.ZIndex = 3
    card.Parent = GridContainer

    local UICornerC = Instance.new("UICorner")
    UICornerC.CornerRadius = UDim.new(0, 8)
    UICornerC.Parent = card

    local tLbl = Instance.new("TextLabel")
    tLbl.Size = UDim2.new(1, -10, 0, 14)
    tLbl.Position = UDim2.new(0, 10, 0, 6)
    tLbl.BackgroundTransparency = 1
    tLbl.Text = title
    tLbl.TextColor3 = Theme.SubText
    tLbl.TextSize = 9
    tLbl.Font = Enum.Font.GothamMedium
    tLbl.TextXAlignment = Enum.TextXAlignment.Left
    tLbl.ZIndex = 4
    tLbl.Parent = card

    local vLbl = Instance.new("TextLabel")
    vLbl.Size = UDim2.new(1, -10, 0, 18)
    vLbl.Position = UDim2.new(0, 10, 0, 22)
    vLbl.BackgroundTransparency = 1
    vLbl.Text = val
    vLbl.TextColor3 = Theme.Text
    vLbl.TextSize = 11
    vLbl.Font = Enum.Font.GothamBold
    vLbl.TextXAlignment = Enum.TextXAlignment.Left
    vLbl.ZIndex = 4
    vLbl.Parent = card

    return vLbl
end

local FpsVal = CreateNexoraCard("📈 FPS", "60")
local PingVal = CreateNexoraCard("📶 Ping", "0 ms")
local ExecVal = CreateNexoraCard("💻 Executor", (identifyexecutor and identifyexecutor() or "Delta"))
local TimeVal = CreateNexoraCard("🕒 Time of day", "11:17")

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            FpsVal.Text = tostring(math.floor(Workspace:GetRealPhysicsFPS()))
            PingVal.Text = tostring(math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())) .. " ms"
            TimeVal.Text = os.date("%H:%M")
        end)
    end
end)

----------------------------------------------------
-- LOGIC HỆ THỐNG ESP (PLAYER & TRAP)
----------------------------------------------------
local PlayerEspEnabled = false
local TrapEspEnabled = false

-- 1. PLAYER ESP
local function ApplyPlayerEsp(player)
    if player == LocalPlayer then return end
    local function AddTag(character)
        local head = character:WaitForChild("Head", 5)
        if not head then return end
        if head:FindFirstChild("PlayerEspTag") then head.PlayerEspTag:Destroy() end
        
        local bb = Instance.new("BillboardGui")
        bb.Name = "PlayerEspTag"
        bb.Adornee = head
        bb.Size = UDim2.new(0, 180, 0, 40)
        bb.StudsOffset = Vector3.new(0, 2.2, 0)
        bb.AlwaysOnTop = true
        bb.Enabled = PlayerEspEnabled
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 12
        nameLabel.TextStrokeTransparency = 0
        nameLabel.Parent = bb
        
        bb.Parent = head
        
        task.spawn(function()
            while bb and bb.Parent and character and character:FindFirstChild("HumanoidRootPart") do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude)
                    nameLabel.Text = "👤 " .. player.DisplayName .. " [" .. dist .. "m]"
                end
                task.wait(0.2)
            end
        end)
    end
    if player.Character then AddTag(player.Character) end
    player.CharacterAdded:Connect(AddTag)
end

for _, plr in ipairs(Players:GetPlayers()) do ApplyPlayerEsp(plr) end
Players.PlayerAdded:Connect(ApplyPlayerEsp)

-- 2. TRAP ESP
local function ApplyTrapEsp(obj)
    local isTrap = string.find(string.lower(obj.Name), "trap") or string.find(string.lower(obj.Name), "bay")
    if isTrap and (obj:IsA("BasePart") or obj:IsA("Model")) then
        local targetPart = obj:IsA("BasePart") and obj or (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart"))
        if not targetPart then return end
        if targetPart:FindFirstChild("TrapEspTag") then targetPart.TrapEspTag:Destroy() end
        
        local bb = Instance.new("BillboardGui")
        bb.Name = "TrapEspTag"
        bb.Adornee = targetPart
        bb.Size = UDim2.new(0, 140, 0, 30)
        bb.AlwaysOnTop = true
        bb.Enabled = TrapEspEnabled
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255, 80, 80)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 11
        label.TextStrokeTransparency = 0
        label.Text = "⚠️ TRAP (BẪY)"
        label.Parent = bb
        
        bb.Parent = targetPart
        
        task.spawn(function()
            while bb and bb.Parent and targetPart do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - targetPart.Position).Magnitude)
                    label.Text = "⚠️ BẪY (" .. obj.Name .. ") [" .. dist .. "m]"
                end
                task.wait(0.3)
            end
        end)
    end
end

for _, item in ipairs(workspace:GetDescendants()) do ApplyTrapEsp(item) end
workspace.DescendantAdded:Connect(ApplyTrapEsp)

----------------------------------------------------
-- TAB ESP (GIAO DIỆN BẬT / TẮT)
----------------------------------------------------
local BtnPlayerEsp = CreateScriptButton(PageESP, Translations[CurrentLang].PlayerEspToggle, function()
    PlayerEspEnabled = not PlayerEspEnabled
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("Head") then
            local tag = plr.Character.Head:FindFirstChild("PlayerEspTag")
            if tag then tag.Enabled = PlayerEspEnabled end
        end
    end
    BtnPlayerEsp.TextColor3 = PlayerEspEnabled and Theme.Accent or Theme.Text
end, Theme.Text)

local BtnTrapEsp = CreateScriptButton(PageESP, Translations[CurrentLang].TrapEspToggle, function()
    TrapEspEnabled = not TrapEspEnabled
    for _, obj in ipairs(workspace:GetDescendants()) do
        local tag = obj:FindFirstChild("TrapEspTag")
        if tag then tag.Enabled = TrapEspEnabled end
    end
    BtnTrapEsp.TextColor3 = TrapEspEnabled and Theme.Warning or Theme.Text
end, Theme.Text)

----------------------------------------------------
-- TAB BROWSE
----------------------------------------------------
local BrowseMainView = Instance.new("Frame")
BrowseMainView.Size = UDim2.new(1, 0, 1, 0)
BrowseMainView.BackgroundTransparency = 1
BrowseMainView.ZIndex = 3
BrowseMainView.Parent = PageBrowse

local BrowseMainLayout = Instance.new("UIListLayout")
BrowseMainLayout.SortOrder = Enum.SortOrder.LayoutOrder
BrowseMainLayout.Padding = UDim.new(0, 8)
BrowseMainLayout.Parent = BrowseMainView

local StealEggSubView = Instance.new("Frame")
StealEggSubView.Size = UDim2.new(1, 0, 1, 0)
StealEggSubView.BackgroundTransparency = 1
StealEggSubView.Visible = false
StealEggSubView.ZIndex = 3
StealEggSubView.Parent = PageBrowse

local EggSubLayout = Instance.new("UIListLayout")
EggSubLayout.SortOrder = Enum.SortOrder.LayoutOrder
EggSubLayout.Padding = UDim.new(0, 8)
EggSubLayout.Parent = StealEggSubView

local EggNoKeyView = Instance.new("Frame")
EggNoKeyView.Size = UDim2.new(1, 0, 1, 0)
EggNoKeyView.BackgroundTransparency = 1
EggNoKeyView.Visible = false
EggNoKeyView.ZIndex = 3
EggNoKeyView.Parent = PageBrowse

local EggNoKeyLayout = Instance.new("UIListLayout")
EggNoKeyLayout.SortOrder = Enum.SortOrder.LayoutOrder
EggNoKeyLayout.Padding = UDim.new(0, 8)
EggNoKeyLayout.Parent = EggNoKeyView

local EggKeyView = Instance.new("Frame")
EggKeyView.Size = UDim2.new(1, 0, 1, 0)
EggKeyView.BackgroundTransparency = 1
EggKeyView.Visible = false
EggKeyView.ZIndex = 3
EggKeyView.Parent = PageBrowse

local EggKeyLayout = Instance.new("UIListLayout")
EggKeyLayout.SortOrder = Enum.SortOrder.LayoutOrder
EggKeyLayout.Padding = UDim.new(0, 8)
EggKeyLayout.Parent = EggKeyView

local FishSubView = Instance.new("Frame")
FishSubView.Size = UDim2.new(1, 0, 1, 0)
FishSubView.BackgroundTransparency = 1
FishSubView.Visible = false
FishSubView.ZIndex = 3
FishSubView.Parent = PageBrowse

local FishSubLayout = Instance.new("UIListLayout")
FishSubLayout.SortOrder = Enum.SortOrder.LayoutOrder
FishSubLayout.Padding = UDim.new(0, 8)
FishSubLayout.Parent = FishSubView

local FishNoKeyView = Instance.new("Frame")
FishNoKeyView.Size = UDim2.new(1, 0, 1, 0)
FishNoKeyView.BackgroundTransparency = 1
FishNoKeyView.Visible = false
FishNoKeyView.ZIndex = 3
FishNoKeyView.Parent = PageBrowse

local FishNoKeyLayout = Instance.new("UIListLayout")
FishNoKeyLayout.SortOrder = Enum.SortOrder.LayoutOrder
FishNoKeyLayout.Padding = UDim.new(0, 8)
FishNoKeyLayout.Parent = FishNoKeyView

-- BROWSE BUTTONS
CreateScriptButton(BrowseMainView, "🥚 STEAL AN EGG", function()
    BrowseMainView.Visible = false
    StealEggSubView.Visible = true
end, Theme.Accent)

CreateScriptButton(BrowseMainView, "🎣 FISHING MASTER", function()
    BrowseMainView.Visible = false
    FishSubView.Visible = true
end, Theme.Accent)

local BtnBackGameList1 = CreateScriptButton(StealEggSubView, Translations[CurrentLang].BackToGameList, function()
    StealEggSubView.Visible = false
    BrowseMainView.Visible = true
end, Theme.SubText)

local BtnStealEggNoKey = CreateScriptButton(StealEggSubView, Translations[CurrentLang].StealEggNoKey, function()
    StealEggSubView.Visible = false
    EggNoKeyView.Visible = true
end, Theme.Accent)

local BtnStealEggKey = CreateScriptButton(StealEggSubView, Translations[CurrentLang].StealEggKey, function()
    StealEggSubView.Visible = false
    EggKeyView.Visible = true
end, Theme.Text)

local BtnBackStealEgg1 = CreateScriptButton(EggNoKeyView, Translations[CurrentLang].BackToStealEgg, function()
    EggNoKeyView.Visible = false
    StealEggSubView.Visible = true
end, Theme.SubText)

-- DANH SÁCH SCRIPT STEAL AN EGG (NO KEY)
CreateScriptButton(EggNoKeyView, "⚡ WZEUS HUB", function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Wzeus-NTH/Wzeusno1/main/Wzeus/nthzz"))() end)
end, Theme.Accent)

CreateScriptButton(EggNoKeyView, "🌶️ CHIILY HUB V3", function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/khauow386-dot/Kha-hup-rayfi/refs/heads/main/Chilihupv3"))() end)
end, Theme.Accent)

CreateScriptButton(EggNoKeyView, "🌟 ARIS HUB", function()
    pcall(function() loadstring(game:HttpGet("https://vxezestudio.online/api/scripts/script_kfXJrZUcmVdSv/stream/init"))() end)
end, Theme.Accent)

CreateScriptButton(EggNoKeyView, "☁️ CLOUT HUB", function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ClouthubOnTop/Loader/main/main.lua"))() end)
end, Theme.Accent)

CreateScriptButton(EggNoKeyView, "🌙 NIGHT HUB", function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/kadit9999/stealanegg/refs/heads/main/nightegg.lua"))() end)
end, Theme.Accent)

local BtnBackStealEgg2 = CreateScriptButton(EggKeyView, Translations[CurrentLang].BackToStealEgg, function()
    EggKeyView.Visible = false
    StealEggSubView.Visible = true
end, Theme.SubText)

CreateScriptButton(EggKeyView, "🍊 MIRANDA HUB", function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/kadit9999/stealanegg/refs/heads/main/Miranda.lua"))() end)
end, Theme.Text)

local BtnBackGameList2 = CreateScriptButton(FishSubView, Translations[CurrentLang].BackToGameList, function()
    FishSubView.Visible = false
    BrowseMainView.Visible = true
end, Theme.SubText)

local BtnFishNoKey = CreateScriptButton(FishSubView, Translations[CurrentLang].FishNoKey, function()
    FishSubView.Visible = false
    FishNoKeyView.Visible = true
end, Theme.Accent)

local BtnBackFishMaster = CreateScriptButton(FishNoKeyView, Translations[CurrentLang].BackToFishMaster, function()
    FishNoKeyView.Visible = false
    FishSubView.Visible = true
end, Theme.SubText)

CreateScriptButton(FishNoKeyView, "⚡ TOCO HUB", function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Tocolate1111111/fishingmaster/refs/heads/main/tocohub.lua"))() end)
end, Theme.Accent)

----------------------------------------------------
-- TAB SERVER CHAT
----------------------------------------------------
local ChatLogsFrame = Instance.new("ScrollingFrame")
ChatLogsFrame.Size = UDim2.new(1, -10, 0, 180)
ChatLogsFrame.BackgroundColor3 = Theme.Card
ChatLogsFrame.BackgroundTransparency = 0.2
ChatLogsFrame.BorderSizePixel = 0
ChatLogsFrame.ScrollBarThickness = 3
ChatLogsFrame.ScrollBarImageColor3 = Theme.Accent
ChatLogsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ChatLogsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ChatLogsFrame.ZIndex = 3
ChatLogsFrame.Parent = PageChat

local UICornerLogs = Instance.new("UICorner")
UICornerLogs.CornerRadius = UDim.new(0, 8)
UICornerLogs.Parent = ChatLogsFrame

local ChatListLayout = Instance.new("UIListLayout")
ChatListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ChatListLayout.Padding = UDim.new(0, 4)
ChatListLayout.Parent = ChatLogsFrame

local ChatInputFrame = Instance.new("Frame")
ChatInputFrame.Size = UDim2.new(1, -10, 0, 34)
ChatInputFrame.BackgroundTransparency = 1
ChatInputFrame.ZIndex = 3
ChatInputFrame.Parent = PageChat

local ChatInput = Instance.new("TextBox")
ChatInput.Name = "ChatInput"
ChatInput.Size = UDim2.new(1, -70, 1, 0)
ChatInput.BackgroundColor3 = Theme.Card
ChatInput.BackgroundTransparency = 0.2
ChatInput.TextColor3 = Theme.Text
ChatInput.PlaceholderText = Translations[CurrentLang].ChatPlaceholder
ChatInput.PlaceholderColor3 = Theme.SubText
ChatInput.Text = ""
ChatInput.Font = Enum.Font.GothamMedium
ChatInput.TextSize = 11
ChatInput.BorderSizePixel = 0
ChatInput.ZIndex = 4
ChatInput.Parent = ChatInputFrame

local UICornerIn = Instance.new("UICorner")
UICornerIn.CornerRadius = UDim.new(0, 6)
UICornerIn.Parent = ChatInput

local SendChatBtn = Instance.new("TextButton")
SendChatBtn.Name = "SendChatBtn"
SendChatBtn.Size = UDim2.new(0, 62, 1, 0)
SendChatBtn.Position = UDim2.new(1, -62, 0, 0)
SendChatBtn.BackgroundColor3 = Theme.Accent
SendChatBtn.Text = Translations[CurrentLang].BtnSend
SendChatBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
SendChatBtn.Font = Enum.Font.GothamBold
SendChatBtn.TextSize = 11
SendChatBtn.BorderSizePixel = 0
SendChatBtn.ZIndex = 4
SendChatBtn.Parent = ChatInputFrame

local UICornerSnd = Instance.new("UICorner")
UICornerSnd.CornerRadius = UDim.new(0, 6)
UICornerSnd.Parent = SendChatBtn

local function AddMessageToChat(senderName, msgText)
    local msgLabel = Instance.new("TextLabel")
    msgLabel.Size = UDim2.new(1, -10, 0, 0)
    msgLabel.AutomaticSize = Enum.AutomaticSize.Y
    msgLabel.BackgroundTransparency = 1
    msgLabel.TextColor3 = Theme.Text
    msgLabel.TextSize = 11
    msgLabel.Font = Enum.Font.GothamMedium
    msgLabel.TextXAlignment = Enum.TextXAlignment.Left
    msgLabel.TextWrapped = true
    msgLabel.Text = " [" .. senderName .. "]: " .. msgText
    msgLabel.ZIndex = 4
    msgLabel.Parent = ChatLogsFrame
    
    task.wait(0.05)
    ChatLogsFrame.CanvasPosition = Vector2.new(0, ChatLogsFrame.AbsoluteCanvasSize.Y)
end

InternalChatEvent.OnClientEvent:Connect(function(senderName, msgText)
    AddMessageToChat(senderName, msgText)
end)

local function DoSendChat()
    local text = ChatInput.Text
    if text ~= "" then
        AddMessageToChat(LocalPlayer.DisplayName, text)
        InternalChatEvent:FireServer(LocalPlayer.DisplayName, text)
        ChatInput.Text = ""
    end
end

SendChatBtn.MouseButton1Click:Connect(DoSendChat)
ChatInput.FocusLost:Connect(function(enter) if enter then DoSendChat() end end)

----------------------------------------------------
-- TAB FIX LAG
----------------------------------------------------
local BtnFixLagAction = CreateScriptButton(PageFixLag, Translations[CurrentLang].BtnFixLagAction, function()
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
end, Theme.Warning)

----------------------------------------------------
-- TAB SETTINGS
----------------------------------------------------
local LangLabel = Instance.new("TextLabel")
LangLabel.Name = "LangLabel"
LangLabel.Size = UDim2.new(1, -10, 0, 20)
LangLabel.BackgroundTransparency = 1
LangLabel.Text = Translations[CurrentLang].SelectLangLabel
LangLabel.TextColor3 = Theme.SubText
LangLabel.TextSize = 11
LangLabel.Font = Enum.Font.GothamBold
LangLabel.TextXAlignment = Enum.TextXAlignment.Left
LangLabel.ZIndex = 3
LangLabel.Parent = PageSettings

local BtnLangVI = CreateScriptButton(PageSettings, "🇻🇳 TIẾNG VIỆT", nil, Theme.Accent)
local BtnLangEN = CreateScriptButton(PageSettings, "🇺🇸 ENGLISH", nil, Theme.Text)

local function UpdateLanguage(newLang)
    CurrentLang = newLang
    local langData = Translations[CurrentLang]
    
    KeyTitle.Text = langData.KeyTitle
    KeyInput.PlaceholderText = langData.KeyPlaceholder
    BtnGetKey.Text = langData.BtnGetKey
    BtnCheckKey.Text = langData.BtnCheckKey
    KeyNote.Text = langData.KeyNote
    
    for _, tabBtn in ipairs(TabContainer:GetChildren()) do
        if tabBtn:IsA("TextButton") then
            if tabBtn.Name == "Tab_TabHome" then tabBtn.Text = "  🏠  " .. langData.TabHome
            elseif tabBtn.Name == "Tab_TabBrowse" then tabBtn.Text = "  🔍  " .. langData.TabBrowse
            elseif tabBtn.Name == "Tab_TabESP" then tabBtn.Text = "  👁️  " .. langData.TabESP
            elseif tabBtn.Name == "Tab_TabChat" then tabBtn.Text = "  💬  " .. langData.TabChat
            elseif tabBtn.Name == "Tab_TabFixLag" then tabBtn.Text = "  ⚡  " .. langData.TabFixLag
            elseif tabBtn.Name == "Tab_TabSettings" then tabBtn.Text = "  ⚙️  " .. langData.TabSettings
            end
        end
    end
    
    HelloLabel.Text = langData.Hello .. LocalPlayer.DisplayName
    GoodLabel.Text = GetUserRankText(CurrentLang)
    HopTitle.Text = langData.ServerHop
    HopBtn.Text = langData.BtnMenuHop
    SysHeaderLabel.Text = langData.SysInfo
    
    BtnPlayerEsp.Text = langData.PlayerEspToggle
    BtnTrapEsp.Text = langData.TrapEspToggle
    
    BtnBackGameList1.Text = langData.BackToGameList
    BtnBackGameList2.Text = langData.BackToGameList
    BtnStealEggNoKey.Text = langData.StealEggNoKey
    BtnStealEggKey.Text = langData.StealEggKey
    BtnBackStealEgg1.Text = langData.BackToStealEgg
    BtnBackStealEgg2.Text = langData.BackToStealEgg
    BtnFishNoKey.Text = langData.FishNoKey
    BtnBackFishMaster.Text = langData.BackToFishMaster
    
    ChatInput.PlaceholderText = langData.ChatPlaceholder
    SendChatBtn.Text = langData.BtnSend
    BtnFixLagAction.Text = langData.BtnFixLagAction
    LangLabel.Text = langData.SelectLangLabel
    
    HeaderTitle.Text = langData.TabHome
end

BtnLangVI.MouseButton1Click:Connect(function() UpdateLanguage("VI") end)
BtnLangEN.MouseButton1Click:Connect(function() UpdateLanguage("EN") end)

----------------------------------------------------
-- LOGIC SỰ KIỆN KEY SYSTEM (SỬA LỖI KIỂM TRA KEY)
----------------------------------------------------
local function OpenMainHub()
    KeyFrame:Destroy()
    MainFrame.Visible = true
    TogglePill.Visible = true
end

BtnGetKey.MouseButton1Click:Connect(function()
    KeyInput.Text = CORRECT_KEY
    if setclipboard then
        pcall(function() setclipboard(CORRECT_KEY) end)
        KeyStatus.Text = Translations[CurrentLang].KeyCopied .. CORRECT_KEY
    else
        KeyStatus.Text = "Key: " .. CORRECT_KEY
    end
    KeyStatus.TextColor3 = Theme.Accent
end)

BtnCheckKey.MouseButton1Click:Connect(function()
    local enteredKey = KeyInput.Text:gsub("%s+", "") -- LOẠI BỎ TOÀN BỘ KHOẢNG TRẮNG DỪA
    
    if enteredKey == CORRECT_KEY then
        KeyStatus.Text = Translations[CurrentLang].KeySuccess
        KeyStatus.TextColor3 = Theme.Accent
        task.wait(0.8)
        OpenMainHub()
    else
        KeyStatus.Text = Translations[CurrentLang].KeyFail
        KeyStatus.TextColor3 = Theme.Close
    end
end)



