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

if CoreGui:FindFirstChild("NgHuy_RBL") then CoreGui.VanNghiaa_FF_V3:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui; ScreenGui.Name = "NgHuy_RBL"; ScreenGui.IgnoreGuiInset = true 

local SELECTED_FONT = Enum.Font.GothamBold
local MainIconID = "rbxassetid://123745846047688" 

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1; FOVCircle.Color = Color3.fromRGB(0, 255, 0); FOVCircle.Transparency = 1; FOVCircle.Filled = false; FOVCircle.Visible = false

local VanNghiaaTag = Instance.new("TextLabel", ScreenGui)
VanNghiaaTag.Size = UDim2.new(0, 200, 0, 30); VanNghiaaTag.AnchorPoint = Vector2.new(0.5, 0); VanNghiaaTag.Position = UDim2.new(0.5, 0, 0, 5); VanNghiaaTag.BackgroundTransparency = 1
VanNghiaaTag.Text = "0"; VanNghiaaTag.TextColor3 = Color3.fromRGB(255, 0, 0); VanNghiaaTag.Font = SELECTED_FONT; VanNghiaaTag.TextSize = 35 
Instance.new("UIStroke", VanNghiaaTag).Thickness = 2

local MenuIcon = Instance.new("ImageButton", ScreenGui)
MenuIcon.BackgroundTransparency = 1; MenuIcon.Position = UDim2.new(0.05, 0, 0.2, 0); MenuIcon.Size = UDim2.new(0, 70, 0, 70); MenuIcon.Image = MainIconID; MenuIcon.Draggable = true; Instance.new("UICorner", MenuIcon).CornerRadius = UDim.new(1, 0)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundTransparency = 1; MainFrame.Position = UDim2.new(0.5, -140, 0.4, -165); MainFrame.Size = UDim2.new(0, 280, 0, 340); MainFrame.Draggable = true; MainFrame.Active = true; MainFrame.Visible = false
MenuIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local Header = Instance.new("Frame", MainFrame)
Header.BackgroundColor3 = Color3.fromRGB(220, 40, 30); Header.Size = UDim2.new(1, 0, 0, 55); Header.BorderSizePixel = 0; Header.ZIndex = 2
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)
local HeaderFlat = Instance.new("Frame", Header)
HeaderFlat.Size = UDim2.new(1, 0, 0.5, 0); HeaderFlat.Position = UDim2.new(0, 0, 0.5, 0); HeaderFlat.BackgroundColor3 = Header.BackgroundColor3; HeaderFlat.BorderSizePixel = 0; HeaderFlat.ZIndex = 1
local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, 0, 1, 0); Title.BackgroundTransparency = 1; Title.Text = "NgHuy RBL"; Title.TextColor3 = Color3.new(1,1,1); Title.Font = SELECTED_FONT; Title.TextSize = 20; Title.ZIndex = 3

local Container = Instance.new("Frame", MainFrame)
Container.Position = UDim2.new(0, 0, 0, 55); Container.Size = UDim2.new(1, 0, 0, 275); Container.BackgroundTransparency = 1; Container.BorderSizePixel = 0
local Layout = Instance.new("UIListLayout", Container); Layout.SortOrder = Enum.SortOrder.LayoutOrder

local Footer = Instance.new("Frame", MainFrame)
Footer.BackgroundColor3 = Color3.fromRGB(220, 40, 30); Footer.Size = UDim2.new(1, 0, 0, 10); Footer.Position = UDim2.new(0, 0, 1, -10); Footer.BorderSizePixel = 0; Footer.ZIndex = 2
Instance.new("UICorner", Footer).CornerRadius = UDim.new(0, 10)
local FooterFlat = Instance.new("Frame", Footer)
FooterFlat.Size = UDim2.new(1, 0, 0.5, 0); FooterFlat.Position = UDim2.new(0, 0, 0, 0); FooterFlat.BackgroundColor3 = Footer.BackgroundColor3; FooterFlat.BorderSizePixel = 0; FooterFlat.ZIndex = 1

local function CreateFFRow(text, order)
    local isOn = false
    local Row = Instance.new("TextButton", Container); Row.Size = UDim2.new(1, 0, 0, 45); Row.BackgroundColor3 = Color3.fromRGB(80, 80, 80); Row.BorderSizePixel = 0; Row.AutoButtonColor = false; Row.LayoutOrder = order
    local Label = Instance.new("TextLabel", Row); Label.Size = UDim2.new(1, 0, 1, 0); Label.BackgroundTransparency = 1; Label.Text = text:upper(); Label.TextColor3 = Color3.new(1, 1, 1); Label.Font = SELECTED_FONT; Label.TextSize = 14
    local Line = Instance.new("Frame", Row); Line.Size = UDim2.new(1, 0, 0, 1); Line.Position = UDim2.new(0, 0, 1, -1); Line.BackgroundColor3 = Color3.new(1, 1, 1); Line.BackgroundTransparency = 0.5; Line.BorderSizePixel = 0
    Row.MouseButton1Click:Connect(function()
        isOn = not isOn
        Row.BackgroundColor3 = isOn and Color3.fromRGB(0, 0, 255) or Color3.fromRGB(80, 80, 80)
        local t = text:upper()
        if t == "AIMBOT" then Config.Aimbot = isOn; FOVCircle.Visible = isOn
        elseif t == "HITBOX" then Config.Hitbox = isOn
        elseif t == "ESP LINE" then Config.ShowLine = isOn
        elseif t == "ESP BOX" then Config.ShowBox = isOn
        elseif t == "ESP HP" then Config.ShowHealth = isOn
        end
    end)
    return Row
end

local function CreateFFSlider(title, defaultVal, maxVal, order)
    local Row = Instance.new("Frame", Container); Row.Size = UDim2.new(1, 0, 0, 55); Row.BackgroundColor3 = Color3.fromRGB(0, 0, 255); Row.BorderSizePixel = 0; Row.LayoutOrder = order
    local currentValue = defaultVal
    local Label = Instance.new("TextLabel", Row); Label.Text = title:upper() .. " " .. currentValue; Label.Size = UDim2.new(1, 0, 0, 25); Label.TextColor3 = Color3.new(1, 1, 1); Label.Font = SELECTED_FONT; Label.TextSize = 12; Label.BackgroundTransparency = 1; Label.Position = UDim2.new(0, 10, 0, 5); Label.TextXAlignment = Enum.TextXAlignment.Left
    local Bar = Instance.new("Frame", Row); Bar.Size = UDim2.new(0.55, 0, 0, 3); Bar.Position = UDim2.new(0.22, 0, 0.7, 0); Bar.BackgroundColor3 = Color3.new(1, 1, 1); Bar.BorderSizePixel = 0
    local Ball = Instance.new("ImageButton", Bar); Ball.Size = UDim2.new(0, 18, 0, 18); Ball.Position = UDim2.new(currentValue/maxVal, -9, 0.5, -9); Ball.BackgroundColor3 = Color3.fromRGB(100, 255, 100); Ball.BorderSizePixel = 0; Instance.new("UICorner", Ball).CornerRadius = UDim.new(1, 0)
    local function updateVisuals()
        currentValue = math.clamp(currentValue, 0, maxVal)
        Label.Text = title:upper() .. " " .. string.format("%.2f", currentValue)
        Ball.Position = UDim2.new(currentValue/maxVal, -9, 0.5, -9)
        if title:upper() == "AIM RADIUS" then Config.Radius = currentValue end
    end
    Ball.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                currentValue = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1) * maxVal
                updateVisuals()
            end
        end
    end)
    return Row
end

CreateFFRow("AIMBOT", 1); CreateFFRow("HITBOX", 2); CreateFFSlider("AIM RADIUS", 0, 800, 3); CreateFFRow("ESP LINE", 4); CreateFFRow("ESP BOX", 5); CreateFFRow("ESP HP", 6)

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)
    FOVCircle.Radius = Config.Radius
    if Config.Aimbot then
        local target = GetClosestPlayer()
        if target then Cam.CFrame = CFrame.new(Cam.CFrame.Position, target.Position) end
    end
    local currentCount = 0 
    local anyEspOn = (Config.ShowLine or Config.ShowBox or Config.ShowHealth)
    for _, plr in pairs(Players:GetPlayers()) do
        local esp = GetESP(plr)
        if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") then
            local p_hrp = plr.Character.HumanoidRootPart
            local p_hum = plr.Character.Humanoid
            if Config.Hitbox then
                p_hrp.Size = Vector3.new(15, 15, 15); p_hrp.Transparency = 0.7; p_hrp.Color = Color3.fromRGB(255, 0, 0); p_hrp.CanCollide = false
            else
                p_hrp.Size = Vector3.new(2, 2, 1); p_hrp.Transparency = 1
            end
            local pos, onScreen = Cam:WorldToViewportPoint(p_hrp.Position)
            if onScreen and p_hum.Health > 0 then
                if anyEspOn then currentCount = currentCount + 1 end
                local head = plr.Character:FindFirstChild("Head")
                if head then
                    local headP = Cam:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local legP = Cam:WorldToViewportPoint(p_hrp.Position - Vector3.new(0, 3, 0))
                    local h = legP.Y - headP.Y; local w = h / 2
                    esp.Box.Visible = Config.ShowBox; esp.Box.Size = Vector2.new(w, h); esp.Box.Position = Vector2.new(pos.X - w/2, headP.Y); esp.Box.Color = Color3.new(1, 1, 1); esp.Box.Thickness = 1; esp.Box.Filled = false
                    esp.Line.Visible = Config.ShowLine; esp.Line.From = Vector2.new(Cam.ViewportSize.X / 2, 0); esp.Line.To = Vector2.new(pos.X, headP.Y); esp.Line.Color = Color3.new(1, 1, 1); esp.Line.Thickness = 1
                    esp.Health.Visible = Config.ShowHealth; esp.Health.Size = Vector2.new(2, h * (p_hum.Health/p_hum.MaxHealth)); esp.Health.Position = Vector2.new(pos.X - w/2 - 5, headP.Y + (h - esp.Health.Size.Y)); esp.Health.Color = Color3.fromRGB(0, 255, 0); esp.Health.Filled = true
                end
            else ClearESP(plr) end
        else ClearESP(plr) end
    end
    VanNghiaaTag.Text = tostring(currentCount)
end)
