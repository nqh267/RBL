local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RbxAnalytics = game:GetService("RbxAnalyticsService")
local LP = Players.LocalPlayer

local KEY_URL_RAW = "https://corexcheat.site/getkey/device.php"
local WEBHOOK_URL = "https://discord.com/api/webhooks/1450968550696030249/vb_tlTRIf2p1SgfjX8EGGqVewShD6Ia6QMlNYr6jNt9MCP-T0801GHD4JND6Xy__wXU4"
local KEY_LINK = "https://corexcheat.site/getkey/index.php"
local HWID = RbxAnalytics:GetClientId()

local requestFunc = (syn and syn.request) or request or http_request or (fluxus and fluxus.request)

local function SendKeyLog(inputKey, status)
    if not requestFunc then return end
    local payload = {
        embeds = {{
            title = "🔑 LOG HỆ THỐNG KEY",
            color = (status == "Thành Công") and 65280 or 16711680,
            fields = {
                { name = "👤 Người chơi", value = LP.Name, inline = true },
                { name = "🔐 Key nhập", value = "||" .. inputKey .. "||", inline = true },
                { name = "📌 Trạng thái", value = status, inline = false },
                { name = "💻 HWID", value = HWID, inline = false }
            },
            footer = { text = "NgHuy System" },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    requestFunc({
        Url = WEBHOOK_URL,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = HttpService:JSONEncode(payload)
    })
end

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "NgHuy"
KeyGui.Parent = game.CoreGui
KeyGui.IgnoreGuiInset = true

local Main = Instance.new("Frame", KeyGui)
Main.Size = UDim2.new(0, 300, 0, 190)
Main.Position = UDim2.new(0.5, -150, 0.5, -95)
Main.BackgroundColor3 = Color3.fromRGB(255,255,255)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "NgHuy"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(0,0,0)

local Box = Instance.new("TextBox", Main)
Box.Size = UDim2.new(0.85,0,0,40)
Box.Position = UDim2.new(0.075,0,0,55)
Box.PlaceholderText = "Nhập Key Vào Đây!"
Box.Text = ""
Box.ClearTextOnFocus = false
Box.Font = Enum.Font.Gotham
Box.TextSize = 14
Box.TextColor3 = Color3.fromRGB(0,0,0)
Box.BackgroundColor3 = Color3.fromRGB(240,240,240)
Box.BorderSizePixel = 0
Instance.new("UICorner", Box).CornerRadius = UDim.new(0,10)

local GetKey = Instance.new("TextButton", Main)
GetKey.Size = UDim2.new(0.4,0,0,36)
GetKey.Position = UDim2.new(0.075,0,0,110)
GetKey.Text = "LẤY KEY"
GetKey.Font = Enum.Font.GothamBold
GetKey.TextSize = 14
GetKey.TextColor3 = Color3.fromRGB(255,255,255)
GetKey.BackgroundColor3 = Color3.fromRGB(0,120,255)
GetKey.BorderSizePixel = 0
Instance.new("UICorner", GetKey).CornerRadius = UDim.new(0,10)

local Submit = Instance.new("TextButton", Main)
Submit.Size = UDim2.new(0.4,0,0,36)
Submit.Position = UDim2.new(0.525,0,0,110)
Submit.Text = "XÁC NHẬN"
Submit.Font = Enum.Font.GothamBold
Submit.TextSize = 14
Submit.TextColor3 = Color3.fromRGB(255,255,255)
Submit.BackgroundColor3 = Color3.fromRGB(0,200,120)
Submit.BorderSizePixel = 0
Instance.new("UICorner", Submit).CornerRadius = UDim.new(0,10)

local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1,0,0,30)
Status.Position = UDim2.new(0,0,1,-30)
Status.BackgroundTransparency = 1
Status.Text = ""
Status.Font = Enum.Font.Gotham
Status.TextSize = 13
Status.TextColor3 = Color3.fromRGB(255,0,0)

GetKey.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(KEY_LINK)
        Status.TextColor3 = Color3.fromRGB(0,170,0)
        Status.Text = "Đã sao chép link lấy key"
    else
        Status.TextColor3 = Color3.fromRGB(255,0,0)
        Status.Text = "Executor không hỗ trợ copy"
    end
end)

Submit.MouseButton1Click:Connect(function()
    local ok, res = pcall(function() return game:HttpGet(KEY_URL_RAW) end)
    if not ok then
        Status.TextColor3 = Color3.fromRGB(255,0,0)
        Status.Text = "Lỗi kết nối"
        return
    end
    local data = HttpService:JSONDecode(res)
    local correctKey = tostring(data.key)
    local userKey = Box.Text:gsub("%s+", "")
    if userKey == correctKey then
        SendKeyLog(userKey, "Thành Công")
        Status.TextColor3 = Color3.fromRGB(0,170,0)
        Status.Text = "KEY ĐÚNG!"
        task.wait(0.6)
        KeyGui:Destroy()
    else
        SendKeyLog(userKey, "Thất Bại")
        Box.Text = ""
        Status.TextColor3 = Color3.fromRGB(255,0,0)
        Status.Text = "KEY SAI HOẶC HẾT HẠN!"
    end
end)

repeat task.wait() until not KeyGui.Parent

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local Cam = workspace.CurrentCamera

if CoreGui:FindFirstChild("FruitR_DoubleSlider") then CoreGui.FruitR_DoubleSlider:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "FruitR_DoubleSlider"

local Config = {
    SilentAim = false, Headshot = false, Hitbox = false,
    AngleFov1 = 0, AngleFov2 = 0,
    GhostHack = false, TPWall = false, SpeedHack = false,
    ShowName = false, ShowLine = false, ShowBox = false, ShowHealth = false
}

local ESP_Store = {}
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5; FOVCircle.Color = Color3.fromRGB(0, 255, 255); FOVCircle.Transparency = 1; FOVCircle.Filled = false; FOVCircle.Visible = true

local function Drag(frame, hold)
    local dragging, dragInput, dragStart, startPos
    hold.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = frame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function ClearESP(plr)
    if ESP_Store[plr] then for _, obj in pairs(ESP_Store[plr]) do obj.Visible = false end end
end

local function GetESP(plr)
    if not ESP_Store[plr] then
        ESP_Store[plr] = { Box = Drawing.new("Square"), Line = Drawing.new("Line"), Name = Drawing.new("Text"), Health = Drawing.new("Square") }
        for _, v in pairs(ESP_Store[plr]) do v.Visible = false end
    end
    return ESP_Store[plr]
end

local function GetClosestPlayer()
    local target = nil; local shortestDistance = math.huge
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid").Health > 0 then
            local aimPart = Config.Headshot and v.Character:FindFirstChild("Head") or v.Character:FindFirstChild("HumanoidRootPart")
            if aimPart then
                local pos, onScreen = Cam:WorldToViewportPoint(aimPart.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)).Magnitude
                    if dist <= Config.AngleFov2 and dist < shortestDistance then target = aimPart; shortestDistance = dist end
                end
            end
        end
    end
    return target
end

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 280, 0, 320); Main.Position = UDim2.new(0.5, -140, 0.5, -160); Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Main.BackgroundTransparency = 0.15; Main.BorderSizePixel = 0; Main.Visible = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

local Header = Instance.new("Frame", Main); Header.Size = UDim2.new(1, 0, 0, 40); Header.BackgroundTransparency = 1
local Title = Instance.new("TextLabel", Header); Title.Size = UDim2.new(1, 0, 1, 0); Title.Text = "VanNghiaa"; Title.TextColor3 = Color3.fromRGB(255, 255, 255); Title.Font = Enum.Font.GothamBold; Title.TextSize = 18; Title.BackgroundTransparency = 1
Drag(Main, Header)

local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 80, 0, 28); CloseBtn.Position = UDim2.new(1, -85, 1, -35); CloseBtn.BackgroundTransparency = 1; CloseBtn.Text = "CLOSE"; CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255); CloseBtn.Font = Enum.Font.GothamMedium; CloseBtn.TextSize = 12
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)
local CloseStroke = Instance.new("UIStroke", CloseBtn); CloseStroke.Thickness = 1.2; CloseStroke.Color = Color3.fromRGB(0, 255, 255); CloseStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -10, 1, -95); Scroll.Position = UDim2.new(0, 5, 0, 45); Scroll.BackgroundTransparency = 1; Scroll.BorderSizePixel = 0; Scroll.ScrollBarThickness = 0; Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
local List = Instance.new("UIListLayout", Scroll); List.Padding = UDim.new(0, 5); List.HorizontalAlignment = Enum.HorizontalAlignment.Center; List.SortOrder = Enum.SortOrder.LayoutOrder

local function CreateCategory(text, order)
    local Box = Instance.new("Frame", Scroll); Box.Size = UDim2.new(0.98, 0, 0, 28); Box.BackgroundColor3 = Color3.fromRGB(0, 255, 255); Box.LayoutOrder = order; Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 6)
    local Label = Instance.new("TextLabel", Box); Label.Size = UDim2.new(1, 0, 1, 0); Label.Text = text; Label.TextColor3 = Color3.new(0, 0, 0); Label.Font = Enum.Font.GothamBold; Label.TextSize = 12; Label.BackgroundTransparency = 1
end

local function CreateSlider(min, max, key, order, hasText)
    local SFrame = Instance.new("Frame", Scroll); SFrame.Size = UDim2.new(0.95, 0, 0, hasText and 40 or 20); SFrame.BackgroundTransparency = 1; SFrame.LayoutOrder = order
    local Label; if hasText then Label = Instance.new("TextLabel", SFrame); Label.Size = UDim2.new(1, 0, 0, 12); Label.Text = key .. ": " .. Config[key]; Label.TextColor3 = Color3.fromRGB(220, 220, 220); Label.Font = Enum.Font.Gotham; Label.TextSize = 10; Label.BackgroundTransparency = 1 end
    local Bar = Instance.new("Frame", SFrame); Bar.Size = UDim2.new(0.98, 0, 0, 4); Bar.Position = UDim2.new(0.01, 0, 0, hasText and 25 or 8); Bar.BackgroundColor3 = Color3.fromRGB(60, 60, 60); Instance.new("UICorner", Bar)
    local Fill = Instance.new("Frame", Bar); Fill.Size = UDim2.new((Config[key]-min)/(max-min), 0, 1, 0); Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", Fill)
    local Knob = Instance.new("Frame", Bar); Knob.Size = UDim2.new(0, 12, 0, 12); Knob.Position = UDim2.new((Config[key]-min)/(max-min), -6, 0.5, -6); Knob.BackgroundColor3 = Color3.fromRGB(0, 255, 255); Instance.new("UICorner", Knob)
    local dragging = false
    Knob.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
    RunService.RenderStepped:Connect(function() if dragging then local move = math.clamp((UserInputService:GetMouseLocation().X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1); Config[key] = math.floor(min + (max - min) * move); Knob.Position = UDim2.new(move, -6, 0.5, -6); Fill.Size = UDim2.new(move, 0, 1, 0); if Label then Label.Text = key .. ": " .. Config[key] end end end)
end

local function CreateFeature(text, key, order)
    local Btn = Instance.new("TextButton", Scroll); Btn.Size = UDim2.new(0.98, 0, 0, 34); Btn.BackgroundTransparency = 1; Btn.Text = text; Btn.TextColor3 = Color3.fromRGB(200, 200, 200); Btn.Font = Enum.Font.GothamMedium; Btn.TextSize = 11; Btn.AutoButtonColor = false; Btn.LayoutOrder = order; Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    local Stroke = Instance.new("UIStroke", Btn); Stroke.Thickness = 1.1; Stroke.Color = Color3.fromRGB(80, 80, 80); Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Btn.MouseButton1Click:Connect(function()
        Config[key] = not Config[key]
        TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Config[key] and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(80, 80, 80)}):Play()
        Btn.TextColor3 = Config[key] and Color3.new(1, 1, 1) or Color3.fromRGB(200, 200, 200)
    end)
end

CreateCategory("Memory Hack", 1); CreateSlider(0, 800, "AngleFov1", 2, false); CreateFeature("LOCK AIM", "SilentAim", 3); CreateFeature("HEADSHOT", "Headshot", 4); CreateFeature("HITBOX", "Hitbox", 5); CreateSlider(0, 800, "AngleFov2", 6, true); CreateFeature("GHOST HACK", "GhostHack", 7); CreateFeature("TP WALL", "TPWall", 8); CreateFeature("SPEED HACK", "SpeedHack", 9)
CreateCategory("Esp Players", 10); CreateFeature("SHOW NAME", "ShowName", 11); CreateFeature("SHOW LINE", "ShowLine", 12); CreateFeature("SHOW BOX", "ShowBox", 13); CreateFeature("SHOW HEALTH", "ShowHealth", 14)

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2); FOVCircle.Radius = Config.AngleFov2; FOVCircle.Visible = (Config.AngleFov2 > 0)
    if Config.SilentAim then local target = GetClosestPlayer(); if target then Cam.CFrame = CFrame.new(Cam.CFrame.Position, target.Position) end end
    if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LP.Character.HumanoidRootPart; local hum = LP.Character:FindFirstChild("Humanoid")
        if Config.SpeedHack and hum and hum.MoveDirection.Magnitude > 0 then hrp.CFrame = hrp.CFrame + (hum.MoveDirection * 4.5) end
        for _, v in pairs(LP.Character:GetDescendants()) do if v:IsA("BasePart") then if Config.TPWall then v.CanCollide = false end if Config.GhostHack then v.Transparency = 0.5 end end end
    end
    for _, plr in pairs(Players:GetPlayers()) do
        local esp = GetESP(plr)
        if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") then
            local p_hrp = plr.Character.HumanoidRootPart; local p_hum = plr.Character.Humanoid; local pos, onScreen = Cam:WorldToViewportPoint(p_hrp.Position)
            if onScreen and p_hum.Health > 0 then
                local head = plr.Character:FindFirstChild("Head")
                if head then
                    local headP = Cam:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0)); local legP = Cam:WorldToViewportPoint(p_hrp.Position - Vector3.new(0, 3, 0)); local h = legP.Y - headP.Y; local w = h / 2
                    esp.Box.Visible = Config.ShowBox; esp.Box.Size = Vector2.new(w, h); esp.Box.Position = Vector2.new(pos.X - w/2, headP.Y); esp.Box.Color = Color3.new(0, 1, 1)
                    esp.Line.Visible = Config.ShowLine; esp.Line.From = Vector2.new(Cam.ViewportSize.X / 2, 0); esp.Line.To = Vector2.new(pos.X, headP.Y); esp.Line.Color = Color3.new(1, 1, 1)
                    esp.Name.Visible = Config.ShowName; esp.Name.Text = plr.Name; esp.Name.Position = Vector2.new(pos.X, headP.Y - 15); esp.Name.Center = true; esp.Name.Outline = true
                    esp.Health.Visible = Config.ShowHealth; esp.Health.Size = Vector2.new(2, h * (p_hum.Health/p_hum.MaxHealth)); esp.Health.Position = Vector2.new(pos.X - w/2 - 5, headP.Y + (h - esp.Health.Size.Y)); esp.Health.Color = Color3.new(0, 1, 0); esp.Health.Filled = true
                end
            else ClearESP(plr) end
            if not Config.ShowBox then esp.Box.Visible = false end
            if not Config.ShowLine then esp.Line.Visible = false end
            if not Config.ShowName then esp.Name.Visible = false end
            if not Config.ShowHealth then esp.Health.Visible = false end
        else ClearESP(plr) end
    end
end)

local Icon = Instance.new("ImageButton", ScreenGui)
Icon.Size = UDim2.new(0, 55, 0, 55); Icon.Position = UDim2.new(0.05, 0, 0.2, 0); Icon.BackgroundTransparency = 1; Icon.Image = "rbxassetid://105427836833419"; Icon.Active = true
Instance.new("UICorner", Icon).CornerRadius = UDim.new(1, 0)
Drag(Icon, Icon)
Icon.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
