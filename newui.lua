local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer
local Cam = workspace.CurrentCamera

local Config = {
    Aimbot = false,
    Hitbox = false, 
    Radius = 0, 
    ShowLine = false,
    ShowBox = false,
    ShowHealth = false
}

local ESP_Store = {}

local function GetESP(plr)
    if not ESP_Store[plr] then
        ESP_Store[plr] = {
            Box = Drawing.new("Square"),
            Line = Drawing.new("Line"),
            Health = Drawing.new("Square")
        }
    end
    return ESP_Store[plr]
end

local function ClearESP(plr)
    if ESP_Store[plr] then
        for _, obj in pairs(ESP_Store[plr]) do obj.Visible = false end
    end
end

local function GetClosestPlayer()
    local target = nil
    local shortestDistance = (Config.Radius > 0) and Config.Radius or math.huge
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local aimPart = v.Character.HumanoidRootPart
            local pos, onScreen = Cam:WorldToViewportPoint(aimPart.Position)
            if onScreen then
                local mousePos = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)
                local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                if dist <= shortestDistance then
                    target = aimPart
                    shortestDistance = dist
                end
            end
        end
    end
    return target
end

if CoreGui:FindFirstChild("NgHuy_RBL") then CoreGui.NgHuy_RBL:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui
ScreenGui.Name = "NgHuy_RBL"
ScreenGui.IgnoreGuiInset = true 
ScreenGui.ResetOnSpawn = false

local SELECTED_FONT = Enum.Font.GothamBold
local MainIconID = "rbxassetid://123745846047688" 

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.Color = Color3.fromRGB(0, 255, 0)
FOVCircle.Transparency = 1
FOVCircle.Filled = false
FOVCircle.Visible = false

-- Panel chính
local Panel = Instance.new("Frame", ScreenGui)
Panel.Size = UDim2.new(0, 300, 0, 240)
Panel.Position = UDim2.new(0.5, -150, 0.5, -120)
Panel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Panel.BackgroundTransparency = 0.1
Panel.BorderSizePixel = 0
Panel.Active = true
Panel.Draggable = true
Panel.Visible = false

-- Bo góc panel
local PanelCorner = Instance.new("UICorner", Panel)
PanelCorner.CornerRadius = UDim.new(0, 10)

-- Viền panel
local PanelStroke = Instance.new("UIStroke", Panel)
PanelStroke.Color = Color3.fromRGB(0, 170, 255)
PanelStroke.Thickness = 2
PanelStroke.Transparency = 0.3

-- Header với tên menu
local Header = Instance.new("Frame", Panel)
Header.Size = UDim2.new(1, 0, 0, 35)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Header.BackgroundTransparency = 0.2
Header.BorderSizePixel = 0

local HeaderCorner = Instance.new("UICorner", Header)
HeaderCorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "NQH DEV"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = SELECTED_FONT
Title.TextSize = 18
Title.TextScaled = true

-- Tạo menu icon
local MenuIcon = Instance.new("ImageButton", ScreenGui)
MenuIcon.BackgroundTransparency = 0.3
MenuIcon.Position = UDim2.new(0.02, 0, 0.5, -25)
MenuIcon.Size = UDim2.new(0, 50, 0, 50)
MenuIcon.Image = MainIconID
MenuIcon.Draggable = true
MenuIcon.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

local IconCorner = Instance.new("UICorner", MenuIcon)
IconCorner.CornerRadius = UDim.new(1, 0)

MenuIcon.MouseButton1Click:Connect(function()
    Panel.Visible = not Panel.Visible
end)

-- Hàm tạo nút toggle
local function CreateToggle(posX, posY, text, callback)
    local ToggleFrame = Instance.new("Frame", Panel)
    ToggleFrame.Size = UDim2.new(0, 130, 0, 35)
    ToggleFrame.Position = UDim2.new(0, posX, 0, posY)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    ToggleFrame.BorderSizePixel = 0
    
    local ToggleCorner = Instance.new("UICorner", ToggleFrame)
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    
    local Label = Instance.new("TextLabel", ToggleFrame)
    Label.Size = UDim2.new(1, -40, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.Font = SELECTED_FONT
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleButton = Instance.new("ImageButton", ToggleFrame)
    ToggleButton.Size = UDim2.new(0, 25, 0, 25)
    ToggleButton.Position = UDim2.new(1, -30, 0.5, -12.5)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.AutoButtonColor = false
    ToggleButton.Image = "rbxassetid://0"
    
    local ButtonCorner = Instance.new("UICorner", ToggleButton)
    ButtonCorner.CornerRadius = UDim.new(0, 5)
    
    local Checkmark = Instance.new("ImageLabel", ToggleButton)
    Checkmark.Size = UDim2.new(1, -6, 1, -6)
    Checkmark.Position = UDim2.new(0, 3, 0, 3)
    Checkmark.BackgroundTransparency = 1
    Checkmark.Image = "rbxassetid://3926305904" -- Icon checkmark
    Checkmark.ImageColor3 = Color3.fromRGB(0, 255, 0)
    Checkmark.Visible = false
    Checkmark.BackgroundColor3 = Color3.new(1,1,1)
    
    local isOn = false
    
    ToggleButton.MouseButton1Click:Connect(function()
        isOn = not isOn
        Checkmark.Visible = isOn
        ToggleButton.BackgroundColor3 = isOn and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(60, 60, 70)
        callback(isOn)
    end)
    
    return {Frame = ToggleFrame, SetState = function(state)
        isOn = state
        Checkmark.Visible = state
        ToggleButton.BackgroundColor3 = state and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(60, 60, 70)
        callback(state)
    end}
end

-- Dòng 1: Aim và Hitbox
CreateToggle(15, 50, "AIMBOT", function(state)
    Config.Aimbot = state
    FOVCircle.Visible = state
end)

CreateToggle(155, 50, "HITBOX", function(state)
    Config.Hitbox = state
end)

-- Dòng 2: ESP
CreateToggle(15, 95, "ESP LINE", function(state)
    Config.ShowLine = state
end)

CreateToggle(155, 95, "ESP BOX", function(state)
    Config.ShowBox = state
end)

CreateToggle(15, 140, "ESP HP", function(state)
    Config.ShowHealth = state
end)

-- Dòng 3: AIM RADIUS slider
local RadiusLabel = Instance.new("TextLabel", Panel)
RadiusLabel.Size = UDim2.new(0, 130, 0, 25)
RadiusLabel.Position = UDim2.new(0, 15, 0, 185)
RadiusLabel.BackgroundTransparency = 1
RadiusLabel.Text = "AIM RADIUS: 0"
RadiusLabel.TextColor3 = Color3.new(1, 1, 1)
RadiusLabel.Font = SELECTED_FONT
RadiusLabel.TextSize = 14
RadiusLabel.TextXAlignment = Enum.TextXAlignment.Left

local SliderFrame = Instance.new("Frame", Panel)
SliderFrame.Size = UDim2.new(0, 250, 0, 8)
SliderFrame.Position = UDim2.new(0, 15, 0, 215)
SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SliderFrame.BorderSizePixel = 0

local SliderCorner = Instance.new("UICorner", SliderFrame)
SliderCorner.CornerRadius = UDim.new(0, 4)

local SliderFill = Instance.new("Frame", SliderFrame)
SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SliderFill.BorderSizePixel = 0

local SliderFillCorner = Instance.new("UICorner", SliderFill)
SliderFillCorner.CornerRadius = UDim.new(0, 4)

local SliderKnob = Instance.new("Frame", SliderFrame)
SliderKnob.Size = UDim2.new(0, 16, 0, 16)
SliderKnob.Position = UDim2.new(0, -8, 0.5, -8)
SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SliderKnob.BorderSizePixel = 0
SliderKnob.ZIndex = 2

local KnobCorner = Instance.new("UICorner", SliderKnob)
KnobCorner.CornerRadius = UDim.new(1, 0)

local dragging = false

-- Xử lý kéo thả slider
SliderKnob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
    end
end)

SliderKnob.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local mousePos = UserInputService:GetMouseLocation()
        local absX = SliderFrame.AbsolutePosition.X
        local absWidth = SliderFrame.AbsoluteSize.X
        local relativeX = math.clamp(mousePos.X - absX, 0, absWidth)
        
        SliderFill.Size = UDim2.new(0, relativeX, 1, 0)
        SliderKnob.Position = UDim2.new(0, relativeX - 8, 0.5, -8)
        
        local percent = relativeX / absWidth
        local radiusValue = math.floor(percent * 800)
        Config.Radius = radiusValue
        RadiusLabel.Text = "AIM RADIUS: " .. radiusValue
    end
end)

-- Click trực tiếp lên thanh slider
SliderFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = UserInputService:GetMouseLocation()
        local absX = SliderFrame.AbsolutePosition.X
        local absWidth = SliderFrame.AbsoluteSize.X
        local relativeX = math.clamp(mousePos.X - absX, 0, absWidth)
        
        SliderFill.Size = UDim2.new(0, relativeX, 1, 0)
        SliderKnob.Position = UDim2.new(0, relativeX - 8, 0.5, -8)
        
        local percent = relativeX / absWidth
        local radiusValue = math.floor(percent * 800)
        Config.Radius = radiusValue
        RadiusLabel.Text = "AIM RADIUS: " .. radiusValue
    end
end)

-- Player count display
local PlayerCount = Instance.new("TextLabel", ScreenGui)
PlayerCount.Size = UDim2.new(0, 200, 0, 30)
PlayerCount.AnchorPoint = Vector2.new(0.5, 0)
PlayerCount.Position = UDim2.new(0.5, 0, 0, 5)
PlayerCount.BackgroundTransparency = 1
PlayerCount.Text = "0"
PlayerCount.TextColor3 = Color3.fromRGB(0, 255, 0)
PlayerCount.Font = SELECTED_FONT
PlayerCount.TextSize = 35 

local PlayerCountStroke = Instance.new("UIStroke", PlayerCount)
PlayerCountStroke.Thickness = 2
PlayerCountStroke.Color = Color3.fromRGB(0, 0, 0)

-- Main loop
RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)
    FOVCircle.Radius = Config.Radius
    
    if Config.Aimbot then
        local target = GetClosestPlayer()
        if target then 
            Cam.CFrame = CFrame.new(Cam.CFrame.Position, target.Position) 
        end
    end
    
    local currentCount = 0 
    local anyEspOn = (Config.ShowLine or Config.ShowBox or Config.ShowHealth)
    
    for _, plr in pairs(Players:GetPlayers()) do
        local esp = GetESP(plr)
        if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") then
            local p_hrp = plr.Character.HumanoidRootPart
            local p_hum = plr.Character.Humanoid
            
            if Config.Hitbox then
                p_hrp.Size = Vector3.new(15, 15, 15)
                p_hrp.Transparency = 0.7
                p_hrp.Color = Color3.fromRGB(255, 0, 0)
                p_hrp.CanCollide = false
            else
                p_hrp.Size = Vector3.new(2, 2, 1)
                p_hrp.Transparency = 1
            end
            
            local pos, onScreen = Cam:WorldToViewportPoint(p_hrp.Position)
            if onScreen and p_hum.Health > 0 then
                if anyEspOn then 
                    currentCount = currentCount + 1 
                end
                
                local head = plr.Character:FindFirstChild("Head")
                if head then
                    local headP = Cam:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local legP = Cam:WorldToViewportPoint(p_hrp.Position - Vector3.new(0, 3, 0))
                    local h = legP.Y - headP.Y
                    local w = h / 2
                    
                    esp.Box.Visible = Config.ShowBox
                    esp.Box.Size = Vector2.new(w, h)
                    esp.Box.Position = Vector2.new(pos.X - w/2, headP.Y)
                    esp.Box.Color = Color3.new(1, 1, 1)
                    esp.Box.Thickness = 1
                    esp.Box.Filled = false
                    
                    esp.Line.Visible = Config.ShowLine
                    esp.Line.From = Vector2.new(Cam.ViewportSize.X / 2, 0)
                    esp.Line.To = Vector2.new(pos.X, headP.Y)
                    esp.Line.Color = Color3.new(1, 1, 1)
                    esp.Line.Thickness = 1
                    
                    esp.Health.Visible = Config.ShowHealth
                    esp.Health.Size = Vector2.new(2, h * (p_hum.Health/p_hum.MaxHealth))
                    esp.Health.Position = Vector2.new(pos.X - w/2 - 5, headP.Y + (h - esp.Health.Size.Y))
                    esp.Health.Color = Color3.fromRGB(0, 255, 0)
                    esp.Health.Filled = true
                end
            else 
                ClearESP(plr) 
            end
        else 
            ClearESP(plr) 
        end
    end
    
    PlayerCount.Text = tostring(currentCount)
end)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.Color = Color3.fromRGB(0, 255, 0)
FOVCircle.Transparency = 1
FOVCircle.Filled = false
FOVCircle.Visible = false

-- UI theo phong cách LÖVE (từ main.lua)
local Panel = Instance.new("Frame", ScreenGui)
Panel.Size = UDim2.new(0, 420, 0, 260)
Panel.Position = UDim2.new(0.5, -210, 0.5, -130)
Panel.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
Panel.BackgroundTransparency = 0.05
Panel.BorderSizePixel = 0
Panel.Active = true
Panel.Draggable = true
Panel.Visible = false

-- Bo góc panel
local PanelCorner = Instance.new("UICorner", Panel)
PanelCorner.CornerRadius = UDim.new(0, 12)

-- Viền panel
local PanelStroke = Instance.new("UIStroke", Panel)
PanelStroke.Color = Color3.fromRGB(77, 128, 255)
PanelStroke.Thickness = 2

-- Tạo menu icon (giống style cũ nhưng nhỏ hơn)
local MenuIcon = Instance.new("ImageButton", ScreenGui)
MenuIcon.BackgroundTransparency = 1
MenuIcon.Position = UDim2.new(0.02, 0, 0.5, -35)
MenuIcon.Size = UDim2.new(0, 50, 0, 50)
MenuIcon.Image = MainIconID
MenuIcon.Draggable = true
MenuIcon.BackgroundColor3 = Color3.fromRGB(77, 128, 255)
MenuIcon.BackgroundTransparency = 0.2

local IconCorner = Instance.new("UICorner", MenuIcon)
IconCorner.CornerRadius = UDim.new(1, 0)

MenuIcon.MouseButton1Click:Connect(function()
    Panel.Visible = not Panel.Visible
end)

-- Toggle grid (6 toggle buttons theo style main.lua)
local Toggles = {}
local ToggleFrames = {}
local ToggleStates = {false, false, false, false, false, false}
local ToggleLabels = {"AIMBOT", "HITBOX", "", "ESP LINE", "ESP BOX", "ESP HP"}

for i = 1, 6 do
    local row = math.floor((i - 1) / 3)
    local col = (i - 1) % 3
    
    local ToggleFrame = Instance.new("Frame", Panel)
    ToggleFrame.Size = UDim2.new(0, 90, 0, 30)
    ToggleFrame.Position = UDim2.new(0, 20 + col * 130, 0, 20 + row * 50)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(51, 51, 64)
    ToggleFrame.BackgroundTransparency = 0
    ToggleFrame.BorderSizePixel = 0
    
    local ToggleCorner = Instance.new("UICorner", ToggleFrame)
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    
    local Knob = Instance.new("Frame", ToggleFrame)
    Knob.Size = UDim2.new(0, 25, 0, 20)
    Knob.Position = UDim2.new(0, 5, 0.5, -10)
    Knob.BackgroundColor3 = Color3.fromRGB(38, 38, 46)
    Knob.BorderSizePixel = 0
    
    local KnobCorner = Instance.new("UICorner", Knob)
    KnobCorner.CornerRadius = UDim.new(0, 5)
    
    local KnobActive = Instance.new("Frame", ToggleFrame)
    KnobActive.Size = UDim2.new(0, 25, 0, 20)
    KnobActive.Position = UDim2.new(1, -30, 0.5, -10)
    KnobActive.BackgroundColor3 = Color3.fromRGB(77, 128, 255)
    KnobActive.BorderSizePixel = 0
    KnobActive.Visible = false
    
    local KnobActiveCorner = Instance.new("UICorner", KnobActive)
    KnobActiveCorner.CornerRadius = UDim.new(0, 5)
    
    ToggleFrames[i] = {Frame = ToggleFrame, Knob = Knob, KnobActive = KnobActive}
    
    -- Label cho toggle (ẩn vì main.lua không có label, nhưng thêm để biết chức năng)
    if ToggleLabels[i] ~= "" then
        local Label = Instance.new("TextLabel", ToggleFrame)
        Label.Size = UDim2.new(1, 0, 1, 0)
        Label.BackgroundTransparency = 1
        Label.Text = ToggleLabels[i]
        Label.TextColor3 = Color3.new(1, 1, 1)
        Label.Font = SELECTED_FONT
        Label.TextSize = 10
        Label.TextXAlignment = Enum.TextXAlignment.Center
    end
    
    ToggleFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            ToggleStates[i] = not ToggleStates[i]
            
            if ToggleStates[i] then
                Knob.Visible = false
                KnobActive.Visible = true
            else
                Knob.Visible = true
                KnobActive.Visible = false
            end
            
            -- Cập nhật config
            if i == 1 then Config.Aimbot = ToggleStates[i]; FOVCircle.Visible = ToggleStates[i]
            elseif i == 2 then Config.Hitbox = ToggleStates[i]
            elseif i == 4 then Config.ShowLine = ToggleStates[i]
            elseif i == 5 then Config.ShowBox = ToggleStates[i]
            elseif i == 6 then Config.ShowHealth = ToggleStates[i]
            end
        end
    end)
end

-- Slider (AIM RADIUS)
local SliderFrame = Instance.new("Frame", Panel)
SliderFrame.Size = UDim2.new(0, 380, 0, 8)
SliderFrame.Position = UDim2.new(0, 20, 0, 140)
SliderFrame.BackgroundColor3 = Color3.fromRGB(51, 51, 64)
SliderFrame.BorderSizePixel = 0

local SliderCorner = Instance.new("UICorner", SliderFrame)
SliderCorner.CornerRadius = UDim.new(0, 4)

local SliderFill = Instance.new("Frame", SliderFrame)
SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(77, 128, 255)
SliderFill.BorderSizePixel = 0

local SliderFillCorner = Instance.new("UICorner", SliderFill)
SliderFillCorner.CornerRadius = UDim.new(0, 4)

local SliderKnob = Instance.new("ImageButton", SliderFrame)
SliderKnob.Size = UDim2.new(0, 16, 0, 16)
SliderKnob.Position = UDim2.new(0, -8, 0.5, -8)
SliderKnob.BackgroundColor3 = Color3.fromRGB(77, 128, 255)
SliderKnob.BorderSizePixel = 0
SliderKnob.Image = "rbxassetid://0"
SliderKnob.AutoButtonColor = false

local SliderKnobCorner = Instance.new("UICorner", SliderKnob)
SliderKnobCorner.CornerRadius = UDim.new(1, 0)

-- Label cho slider
local SliderLabel = Instance.new("TextLabel", Panel)
SliderLabel.Size = UDim2.new(0, 200, 0, 20)
SliderLabel.Position = UDim2.new(0, 20, 0, 115)
SliderLabel.BackgroundTransparency = 1
SliderLabel.Text = "AIM RADIUS: 0"
SliderLabel.TextColor3 = Color3.new(1, 1, 1)
SliderLabel.Font = SELECTED_FONT
SliderLabel.TextSize = 12
SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

local dragging = false
SliderKnob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
    end
end)

SliderKnob.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local mousePos = UserInputService:GetMouseLocation()
        local absX = SliderFrame.AbsolutePosition.X
        local absWidth = SliderFrame.AbsoluteSize.X
        local relativeX = math.clamp(mousePos.X - absX, 0, absWidth)
        
        SliderFill.Size = UDim2.new(0, relativeX, 1, 0)
        SliderKnob.Position = UDim2.new(0, relativeX - 8, 0.5, -8)
        
        local percent = relativeX / absWidth
        local radiusValue = math.floor(percent * 800)
        Config.Radius = radiusValue
        SliderLabel.Text = "AIM RADIUS: " .. radiusValue
    end
end)

-- 3 Buttons dưới cùng (theo main.lua)
local ButtonFrames = {}
for i = 1, 3 do
    local Button = Instance.new("Frame", Panel)
    Button.Size = UDim2.new(0, 110, 0, 40)
    Button.Position = UDim2.new(0, 20 + (i - 1) * 130, 0, 190)
    Button.BackgroundColor3 = Color3.fromRGB(51, 51, 64)
    Button.BorderSizePixel = 0
    
    local ButtonCorner = Instance.new("UICorner", Button)
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    
    -- Thêm text mờ cho button (main.lua không có text nhưng thêm để dùng)
    local ButtonText = Instance.new("TextLabel", Button)
    ButtonText.Size = UDim2.new(1, 0, 1, 0)
    ButtonText.BackgroundTransparency = 1
    ButtonText.Text = "BUTTON " .. i
    ButtonText.TextColor3 = Color3.fromRGB(200, 200, 200)
    ButtonText.Font = SELECTED_FONT
    ButtonText.TextSize = 12
    
    ButtonFrames[i] = Button
end

-- Player count display (giữ từ bản gốc)
local PlayerCount = Instance.new("TextLabel", ScreenGui)
PlayerCount.Size = UDim2.new(0, 200, 0, 30)
PlayerCount.AnchorPoint = Vector2.new(0.5, 0)
PlayerCount.Position = UDim2.new(0.5, 0, 0, 5)
PlayerCount.BackgroundTransparency = 1
PlayerCount.Text = "0"
PlayerCount.TextColor3 = Color3.fromRGB(255, 0, 0)
PlayerCount.Font = SELECTED_FONT
PlayerCount.TextSize = 35 

local PlayerCountStroke = Instance.new("UIStroke", PlayerCount)
PlayerCountStroke.Thickness = 2

-- Main loop
RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)
    FOVCircle.Radius = Config.Radius
    
    if Config.Aimbot then
        local target = GetClosestPlayer()
        if target then 
            Cam.CFrame = CFrame.new(Cam.CFrame.Position, target.Position) 
        end
    end
    
    local currentCount = 0 
    local anyEspOn = (Config.ShowLine or Config.ShowBox or Config.ShowHealth)
    
    for _, plr in pairs(Players:GetPlayers()) do
        local esp = GetESP(plr)
        if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") then
            local p_hrp = plr.Character.HumanoidRootPart
            local p_hum = plr.Character.Humanoid
            
            if Config.Hitbox then
                p_hrp.Size = Vector3.new(15, 15, 15)
                p_hrp.Transparency = 0.7
                p_hrp.Color = Color3.fromRGB(255, 0, 0)
                p_hrp.CanCollide = false
            else
                p_hrp.Size = Vector3.new(2, 2, 1)
                p_hrp.Transparency = 1
            end
            
            local pos, onScreen = Cam:WorldToViewportPoint(p_hrp.Position)
            if onScreen and p_hum.Health > 0 then
                if anyEspOn then 
                    currentCount = currentCount + 1 
                end
                
                local head = plr.Character:FindFirstChild("Head")
                if head then
                    local headP = Cam:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local legP = Cam:WorldToViewportPoint(p_hrp.Position - Vector3.new(0, 3, 0))
                    local h = legP.Y - headP.Y
                    local w = h / 2
                    
                    esp.Box.Visible = Config.ShowBox
                    esp.Box.Size = Vector2.new(w, h)
                    esp.Box.Position = Vector2.new(pos.X - w/2, headP.Y)
                    esp.Box.Color = Color3.new(1, 1, 1)
                    esp.Box.Thickness = 1
                    esp.Box.Filled = false
                    
                    esp.Line.Visible = Config.ShowLine
                    esp.Line.From = Vector2.new(Cam.ViewportSize.X / 2, 0)
                    esp.Line.To = Vector2.new(pos.X, headP.Y)
                    esp.Line.Color = Color3.new(1, 1, 1)
                    esp.Line.Thickness = 1
                    
                    esp.Health.Visible = Config.ShowHealth
                    esp.Health.Size = Vector2.new(2, h * (p_hum.Health/p_hum.MaxHealth))
                    esp.Health.Position = Vector2.new(pos.X - w/2 - 5, headP.Y + (h - esp.Health.Size.Y))
                    esp.Health.Color = Color3.fromRGB(0, 255, 0)
                    esp.Health.Filled = true
                end
            else 
                ClearESP(plr) 
            end
        else 
            ClearESP(plr) 
        end
    end
    
    PlayerCount.Text = tostring(currentCount)
end)
