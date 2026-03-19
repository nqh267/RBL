local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local MainCorner = Instance.new("UICorner")
local MainStroke = Instance.new("UIStroke")
local TitleBtn = Instance.new("TextButton")
local VersionFrame = Instance.new("Frame")
local VersionCorner = Instance.new("UICorner")
local VersionStroke = Instance.new("UIStroke")
local VersionText = Instance.new("TextLabel")
local ContentFrame = Instance.new("ScrollingFrame")
local ContentCorner = Instance.new("UICorner")
local ContentStroke = Instance.new("UIStroke")

local THEME_COLOR = Color3.fromRGB(0, 255, 170)
local BG_COLOR = Color3.fromRGB(15, 20, 28)
local ESP_COLOR = Color3.fromRGB(255, 255, 255)

local FOV_RADIUS = 100
local AIM_SMOOTH = 1
local AIM_TARGET_PART = "UpperTorso"
local ESP_SETTINGS = {
    Enabled = false,
    Name = false,
    Box = false,
    Line = false,
    Distance = false,
    Health = false,
    AimAssist = false,
    ShowFOV = false
}

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.NumSides = 100
FOVCircle.Radius = FOV_RADIUS
FOVCircle.Filled = false
FOVCircle.Visible = false
FOVCircle.Color = THEME_COLOR

ScreenGui.Parent = game.CoreGui
ScreenGui.IgnoreGuiInset = true

MainFrame.Name = "NQH DEV"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = BG_COLOR
MainFrame.Position = UDim2.new(0.5, -140, 0.4, -175) 
MainFrame.Size = UDim2.new(0, 280, 0, 350) 
MainFrame.Active = true
MainFrame.ClipsDescendants = true 

MainCorner.CornerRadius = UDim.new(0, 8); MainCorner.Parent = MainFrame
MainStroke.Parent = MainFrame; MainStroke.Thickness = 1; MainStroke.Color = THEME_COLOR; MainStroke.Transparency = 0.5

local draggingMenu, dragStart, startPos
TitleBtn.Parent = MainFrame; TitleBtn.BackgroundTransparency = 1; TitleBtn.Size = UDim2.new(1, 0, 0, 30); TitleBtn.Text = "▼  NQH DEV"; TitleBtn.TextColor3 = Color3.new(1, 1, 1); TitleBtn.TextSize = 13; TitleBtn.Font = Enum.Font.GothamBlack; TitleBtn.TextXAlignment = Enum.TextXAlignment.Center 

TitleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingMenu = true; dragStart = input.Position; startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then draggingMenu = false end end)
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if draggingMenu and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

VersionFrame.Parent = MainFrame; VersionFrame.BackgroundColor3 = Color3.fromRGB(10, 30, 30); VersionFrame.Position = UDim2.new(0, 10, 0, 32); VersionFrame.Size = UDim2.new(1, -20, 0, 18)
VersionCorner.Parent = VersionFrame; VersionStroke.Parent = VersionFrame; VersionStroke.Color = THEME_COLOR
VersionText.Parent = VersionFrame; VersionText.Text = "NgHuy-V1"; VersionText.BackgroundTransparency = 1; VersionText.Size = UDim2.new(1,0,1,0); VersionText.TextColor3 = THEME_COLOR; VersionText.TextSize = 10; VersionText.Font = Enum.Font.GothamBold

ContentFrame.Parent = MainFrame; ContentFrame.BackgroundColor3 = Color3.fromRGB(18, 23, 30); ContentFrame.Position = UDim2.new(0, 10, 0, 56); 
ContentFrame.Size = UDim2.new(1, -20, 1, -66); 
ContentFrame.ScrollBarThickness = 2; ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 430) 
ContentCorner.Parent = ContentFrame; ContentStroke.Parent = ContentFrame; ContentStroke.Color = THEME_COLOR

local CurrentLang = "VN"
local UI_Elements = {}
local function UpdateLanguage() for obj, trans in pairs(UI_Elements) do obj.Text = trans[CurrentLang] end end

local function MakeSection(vn, en, yPos, color)
    local lbl = Instance.new("TextLabel", ContentFrame); lbl.Position = UDim2.new(0, 10, 0, yPos); lbl.Size = UDim2.new(0, 100, 0, 15); lbl.BackgroundTransparency = 1; lbl.TextColor3 = color; lbl.TextSize = 10; lbl.Font = Enum.Font.GothamBold; lbl.TextXAlignment = Enum.TextXAlignment.Left
    UI_Elements[lbl] = {VN = vn, EN = en}
    local line = Instance.new("Frame", ContentFrame); line.Position = UDim2.new(0, 10, 0, yPos + 16); line.Size = UDim2.new(1, -20, 0, 1); line.BackgroundColor3 = THEME_COLOR; line.BackgroundTransparency = 0.8
end

local function MakeToggle(vn, en, yPos, callback)
    local SwitchBg = Instance.new("TextButton", ContentFrame); SwitchBg.Size = UDim2.new(0, 30, 0, 15); SwitchBg.Position = UDim2.new(0, 10, 0, yPos); SwitchBg.BackgroundColor3 = Color3.fromRGB(50, 60, 70); SwitchBg.Text = ""
    Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(1, 0)
    local Dot = Instance.new("Frame", SwitchBg); Dot.Size = UDim2.new(0, 9, 0, 9); Dot.Position = UDim2.new(0, 3, 0.5, -4.5); Dot.BackgroundColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)
    local Label = Instance.new("TextLabel", ContentFrame); Label.BackgroundTransparency = 1; Label.Position = UDim2.new(0, 50, 0, yPos); Label.Size = UDim2.new(0, 180, 0, 15); Label.TextColor3 = Color3.new(1, 1, 1); Label.TextSize = 11; Label.Font = Enum.Font.GothamMedium; Label.TextXAlignment = Enum.TextXAlignment.Left
    UI_Elements[Label] = {VN = vn, EN = en}
    local active = false
    SwitchBg.MouseButton1Click:Connect(function()
        active = not active
        SwitchBg.BackgroundColor3 = active and THEME_COLOR or Color3.fromRGB(50, 60, 70)
        Dot:TweenPosition(active and UDim2.new(1, -12, 0.5, -4.5) or UDim2.new(0, 3, 0.5, -4.5), "Out", "Quad", 0.1, true)
        if callback then callback(active) end
    end)
end

MakeSection("NGÔN NGỮ", "LANGUAGE", 10, THEME_COLOR)
local LangBtn = Instance.new("TextButton", ContentFrame); LangBtn.Size = UDim2.new(1, -20, 0, 22); LangBtn.Position = UDim2.new(0, 10, 0, 30); LangBtn.BackgroundColor3 = Color3.fromRGB(30, 40, 50); LangBtn.Text = "Tiếng Việt  ▼"; LangBtn.TextColor3 = Color3.new(1,1,1); LangBtn.TextSize = 10; Instance.new("UICorner", LangBtn)
local LangDrop = Instance.new("Frame", ContentFrame); LangDrop.Size = UDim2.new(1, -20, 0, 40); LangDrop.Position = UDim2.new(0, 10, 0, 52); LangDrop.BackgroundColor3 = Color3.fromRGB(25, 30, 35); LangDrop.Visible = false; LangDrop.ZIndex = 10; Instance.new("UICorner", LangDrop)
local lVN = Instance.new("TextButton", LangDrop); lVN.Size = UDim2.new(1,0,0,20); lVN.Position = UDim2.new(0,0,0,0); lVN.Text = "Tiếng Việt"; lVN.BackgroundTransparency = 1; lVN.TextColor3 = Color3.new(1,1,1); lVN.ZIndex = 11
local lEN = Instance.new("TextButton", LangDrop); lEN.Size = UDim2.new(1,0,0,20); lEN.Position = UDim2.new(0,0,0,20); lEN.Text = "English"; lEN.BackgroundTransparency = 1; lEN.TextColor3 = Color3.new(1,1,1); lEN.ZIndex = 11
LangBtn.MouseButton1Click:Connect(function() LangDrop.Visible = not LangDrop.Visible end)
lVN.MouseButton1Click:Connect(function() CurrentLang = "VN"; LangBtn.Text = "Tiếng Việt  ▼"; LangDrop.Visible = false; UpdateLanguage() end)
lEN.MouseButton1Click:Connect(function() CurrentLang = "EN"; LangBtn.Text = "English  ▼"; LangDrop.Visible = false; UpdateLanguage() end)

MakeSection("AIMBOT-MENU", "AIMBOT-MENU", 80, Color3.fromRGB(255, 180, 50))
MakeToggle("Aimbot", "Aim Assist", 100, function(v) ESP_SETTINGS.AimAssist = v end)
MakeToggle("FOV", "Show Draw Fov", 120, function(v) ESP_SETTINGS.ShowFOV = v end)

local FOVLabel = Instance.new("TextLabel", ContentFrame); FOVLabel.Text = "FOV: 100"; FOVLabel.Position = UDim2.new(0, 10, 0, 140); FOVLabel.BackgroundTransparency = 1; FOVLabel.TextColor3 = THEME_COLOR; FOVLabel.TextSize = 10; FOVLabel.Font = Enum.Font.GothamBold; FOVLabel.TextXAlignment = Enum.TextXAlignment.Left
local SliderBg = Instance.new("Frame", ContentFrame); SliderBg.BackgroundColor3 = Color3.fromRGB(40, 50, 60); SliderBg.Position = UDim2.new(0, 10, 0, 155); SliderBg.Size = UDim2.new(1, -20, 0, 3)
local SliderFill = Instance.new("Frame", SliderBg); SliderFill.BackgroundColor3 = THEME_COLOR; SliderFill.Size = UDim2.new(0.2, 0, 1, 0)
local SliderBall = Instance.new("TextButton", SliderFill); SliderBall.Size = UDim2.new(0, 10, 0, 10); SliderBall.Position = UDim2.new(1, -5, 0.5, -5); SliderBall.Text = ""; SliderBall.BackgroundColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", SliderBall).CornerRadius = UDim.new(1, 0)

SliderBall.MouseButton1Down:Connect(function()
    local moveCon; moveCon = game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            ContentFrame.ScrollingEnabled = false
            local mousePos = game:GetService("UserInputService"):GetMouseLocation().X
            local rel = math.clamp((mousePos - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
            SliderFill.Size = UDim2.new(rel, 0, 1, 0)
            FOV_RADIUS = math.floor(rel * 500)
            FOVLabel.Text = "FOV: " .. FOV_RADIUS
            FOVCircle.Radius = FOV_RADIUS
        end
    end)
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            ContentFrame.ScrollingEnabled = true; if moveCon then moveCon:Disconnect() end
        end
    end)
end)

MakeSection("ESP-MENU", "ESP-MENU", 190, Color3.fromRGB(255, 50, 255)) 
MakeToggle("TẤT ESP", "Enable ESP", 210, function(v) ESP_SETTINGS.Enabled = v end)
MakeToggle("Hiện Tên", "ESP Name", 230, function(v) ESP_SETTINGS.Name = v end)
MakeToggle("Hiện Khoảng Cách", "ESP Distance", 250, function(v) ESP_SETTINGS.Distance = v end)
MakeToggle("Hiện Đường Kẻ", "ESP Line", 270, function(v) ESP_SETTINGS.Line = v end)
MakeToggle("Hiện Khung", "ESP Box", 290, function(v) ESP_SETTINGS.Box = v end)
MakeToggle("Hiện Máu", "ESP Health", 310, function(v) ESP_SETTINGS.Health = v end)

MakeSection("MÀU ESP", "ESP COLORS", 340, THEME_COLOR) 

local COLORS = {
    Color3.new(1, 1, 1),
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(255, 165, 0),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(128, 0, 128),
    Color3.fromRGB(255, 192, 203),
    Color3.fromRGB(165, 42, 42),
    Color3.fromRGB(192, 192, 192),
    Color3.fromRGB(0, 100, 0),
    Color3.fromRGB(75, 0, 130),
    Color3.fromRGB(255, 69, 0),
    Color3.fromRGB(210, 105, 30),
    Color3.fromRGB(173, 216, 230),
    Color3.fromRGB(255, 20, 147),
    Color3.fromRGB(128, 128, 0),
    Color3.fromRGB(255, 228, 196),
    Color3.fromRGB(0, 0, 0),
}

local ColorPickerFrame = Instance.new("Frame", ContentFrame); 
ColorPickerFrame.Position = UDim2.new(0, 10, 0, 360); 
ColorPickerFrame.Size = UDim2.new(1, -20, 0, 50); 
ColorPickerFrame.BackgroundColor3 = Color3.fromRGB(25, 35, 45); 
Instance.new("UICorner", ColorPickerFrame)

local activeColorMarker = nil

local function updateESPColor(newColor)
    ESP_COLOR = newColor
end

local function createColorButton(index, color)
    local button = Instance.new("TextButton", ColorPickerFrame);
    local cols_per_row = 10 
    local size = 18 
    local spacing = 3 
    local row = math.floor((index - 1) / cols_per_row)
    local col = (index - 1) % cols_per_row
    local startX = 5 + col * (size + spacing)
    local startY = 5 + row * (size + spacing)
    
    button.Size = UDim2.new(0, size, 0, size);
    button.Position = UDim2.new(0, startX, 0, startY);
    button.BackgroundColor3 = color;
    button.Text = "";
    button.BorderSizePixel = 1;
    button.BorderColor3 = Color3.new(0, 0, 0); 
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 4)

    if index == 1 then
        button.BorderSizePixel = 2
        button.BorderColor3 = THEME_COLOR
        activeColorMarker = button
    end
    
    button.MouseButton1Click:Connect(function()
        if activeColorMarker then
            activeColorMarker.BorderSizePixel = 1
            activeColorMarker.BorderColor3 = Color3.new(0, 0, 0)
        end
        button.BorderSizePixel = 2
        button.BorderColor3 = THEME_COLOR
        activeColorMarker = button
        updateESPColor(color)
    end)
end

for i, color in ipairs(COLORS) do
    createColorButton(i, color)
end

ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 430) 

local function IsTargetVisible(targetPart, sourcePosition)
    local Camera = game.Workspace.CurrentCamera
    local targetPosition = targetPart.Position
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {game.Players.LocalPlayer.Character, game.Players.LocalPlayer:FindFirstChild("Backpack")}
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    local raycastResult = game.Workspace:Raycast(sourcePosition, targetPosition - sourcePosition, raycastParams)
    
    if raycastResult then
        if raycastResult.Instance:IsDescendantOf(targetPart.Parent) then
            return true
        else
            return false
        end
    end
    return true
end

local MAX_DISTANCE = 400

local function AddESP(player)
    local Box = Drawing.new("Square"); Box.Thickness = 1; Box.Filled = false; Box.Visible = false
    local Line = Drawing.new("Line"); Line.Thickness = 1; Line.Visible = false
    local Name = Drawing.new("Text"); Name.Size = 13; Name.Center = true; Name.Outline = true; Name.Visible = false
    local HealthBarBG = Drawing.new("Square"); HealthBarBG.Thickness = 1; HealthBarBG.Filled = true; HealthBarBG.Color = Color3.fromRGB(0, 0, 0); HealthBarBG.Transparency = 0.5; HealthBarBG.Visible = false
    local HealthBarFill = Drawing.new("Square"); HealthBarFill.Thickness = 0; HealthBarFill.Filled = true; HealthBarFill.Visible = false

    local connection
    connection = game:GetService("RunService").RenderStepped:Connect(function()
        local camera = game.Workspace.CurrentCamera
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        
        if character and humanoid and character:FindFirstChild("HumanoidRootPart") and player ~= game.Players.LocalPlayer then
            local hrp = character.HumanoidRootPart
            local head = character:FindFirstChild("Head") or character:FindFirstChild("UpperTorso")
            local pos, onScreen = camera:WorldToViewportPoint(hrp.Position)
            local targetLinePos, targetLineOnScreen = camera:WorldToViewportPoint(head and head.Position or hrp.Position)
            local dist = (camera.CFrame.Position - hrp.Position).Magnitude
            
            if onScreen and ESP_SETTINGS.Enabled and dist <= MAX_DISTANCE then
                local boxHeight = 3000/dist
                local boxWidth = 2000/dist
                local boxTopY = pos.Y - boxHeight/2
                local boxLeftX = pos.X - boxWidth/2
                
                if ESP_SETTINGS.Box then
                    Box.Size = Vector2.new(boxWidth, boxHeight)
                    Box.Position = Vector2.new(boxLeftX, boxTopY)
                    Box.Color = ESP_COLOR; Box.Visible = true
                else Box.Visible = false end

                if ESP_SETTINGS.Line then
                    Line.From = Vector2.new(camera.ViewportSize.X/2, 0) 
                    Line.To = Vector2.new(targetLinePos.X, targetLinePos.Y); Line.Color = ESP_COLOR; Line.Visible = true
                else Line.Visible = false end

                if ESP_SETTINGS.Name then
                    Name.Text = player.Name .. (ESP_SETTINGS.Distance and " ["..math.floor(dist).."m]" or "")
                    Name.Position = Vector2.new(pos.X, boxTopY - 15); Name.Color = Color3.new(1,1,1); Name.Visible = true
                else Name.Visible = false end
                
                if ESP_SETTINGS.Health and humanoid.MaxHealth > 0 then
                    local healthRatio = humanoid.Health / humanoid.MaxHealth
                    local barHeight = boxHeight + 1 
                    local barWidth = 4 
                    local barLeftX = boxLeftX - barWidth - 2 
                    local barTopY = boxTopY
                    local fillHeight = barHeight * healthRatio
                    local hpColor = Color3.fromHSV(healthRatio * 0.33, 1, 1)

                    HealthBarBG.Size = Vector2.new(barWidth, barHeight)
                    HealthBarBG.Position = Vector2.new(barLeftX, barTopY)
                    HealthBarBG.Visible = true
                    HealthBarFill.Size = Vector2.new(barWidth, fillHeight)
                    HealthBarFill.Position = Vector2.new(barLeftX, barTopY + barHeight - fillHeight)
                    HealthBarFill.Color = hpColor;
                    HealthBarFill.Visible = true
                else
                    HealthBarBG.Visible = false; HealthBarFill.Visible = false
                end
            else
                Box.Visible = false; Line.Visible = false; Name.Visible = false
                HealthBarBG.Visible = false; HealthBarFill.Visible = false
            end
        else
            if not player.Parent then 
                connection:Disconnect(); 
                Box:Remove(); Line:Remove(); Name:Remove();
                HealthBarBG:Remove(); HealthBarFill:Remove(); 
            end
            Box.Visible = false; Line.Visible = false; Name.Visible = false
            HealthBarBG.Visible = false; HealthBarFill.Visible = false
        end
    end)
end

for _, p in pairs(game.Players:GetPlayers()) do AddESP(p) end
game.Players.PlayerAdded:Connect(AddESP)

game:GetService("RunService").RenderStepped:Connect(function()
    local Camera = game.Workspace.CurrentCamera
    local CenterX = Camera.ViewportSize.X / 2
    local CenterY = Camera.ViewportSize.Y / 2
    local LP = game.Players.LocalPlayer
    
    FOVCircle.Visible = ESP_SETTINGS.ShowFOV
    FOVCircle.Radius = FOV_RADIUS
    FOVCircle.Position = Vector2.new(CenterX, CenterY)
    
    if ESP_SETTINGS.AimAssist then
        local target = nil
        local maxDist = FOV_RADIUS
        local partName = AIM_TARGET_PART 
        local currentOffset = 0 
        local LocalPlayerCameraPosition = Camera.CFrame.Position 

        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild(partName) and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                local part = p.Character:FindFirstChild(partName)
                if part then
                    local TargetWorldPosition = part.Position - Vector3.new(0, currentOffset, 0)
                    local pos, vis = Camera:WorldToViewportPoint(TargetWorldPosition)
                    if vis and IsTargetVisible(part, LocalPlayerCameraPosition) then 
                        local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(CenterX, CenterY)).Magnitude
                        if mag < maxDist then
                            maxDist = mag
                            target = p
                        end
                    end
                end
            end
        end
        
        if target and target.Character then
            local part = target.Character:FindFirstChild(partName)
            if part then
                local TargetPosition = part.Position - Vector3.new(0, currentOffset, 0) 
                local CurrentCFrame = Camera.CFrame
                local NewCFrame = CFrame.new(CurrentCFrame.Position, TargetPosition)
                Camera.CFrame = CurrentCFrame:Lerp(NewCFrame, 1 / AIM_SMOOTH) 
            end
        end
    end
end)

local collapsed = false
TitleBtn.MouseButton1Click:Connect(function()
    if draggingMenu then return end
    collapsed = not collapsed
    TitleBtn.Text = collapsed and "▶  NQH DEV" or "▼  NQH DEV"
    MainFrame:TweenSize(collapsed and UDim2.new(0, 280, 0, 30) or UDim2.new(0, 280, 0, 350), "Out", "Quad", 0.2, true) 
    VersionFrame.Visible = not collapsed; ContentFrame.Visible = not collapsed
end)
UpdateLanguage()
