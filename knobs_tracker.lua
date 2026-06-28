local Config = {
    WaitTime = 1.1,
    WindowSize = 30,
    CheckInterval = 0.3,
    DefaultSize = UDim2.new(0, 240, 0, 110),
    MinSize = Vector2.new(180, 82.5), 
    MaxSize = Vector2.new(450, 206.25), 
    GuiPosition = UDim2.new(1, -260, 0, 140),
    BackgroundColor = Color3.fromRGB(18, 16, 15),
    BorderColor = Color3.fromRGB(55, 48, 40),
    TweenTime = 0.2
}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("KnobsTrackerGui") then
    PlayerGui.KnobsTrackerGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KnobsTrackerGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999999
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = Config.DefaultSize
MainFrame.Position = Config.GuiPosition
MainFrame.BackgroundColor3 = Config.BackgroundColor
MainFrame.BackgroundTransparency = 0.02
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 99999
MainFrame.Parent = ScreenGui

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Config.BorderColor
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = MainFrame

local HeaderLabel = Instance.new("TextLabel")
HeaderLabel.Size = UDim2.new(1, -35, 0, 22)
HeaderLabel.Position = UDim2.new(0, 8, 0, 0)
HeaderLabel.BackgroundTransparency = 1
HeaderLabel.Font = Enum.Font.GothamMedium
HeaderLabel.TextColor3 = Color3.fromRGB(140, 130, 120)
HeaderLabel.TextSize = 12
HeaderLabel.Text = "Doors Knobs Tracker"
HeaderLabel.TextXAlignment = Enum.TextXAlignment.Left
HeaderLabel.ZIndex = 100000
HeaderLabel.Parent = MainFrame

local Line = Instance.new("Frame")
Line.Size = UDim2.new(1, -16, 0, 1)
Line.Position = UDim2.new(0, 8, 0, 22)
Line.BackgroundColor3 = Color3.fromRGB(45, 40, 35)
Line.BorderSizePixel = 0
Line.ZIndex = 100000
Line.Parent = MainFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -24, 0, 1)
CloseButton.BackgroundTransparency = 1
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(150, 140, 130)
CloseButton.TextSize = 16
CloseButton.ZIndex = 100005
CloseButton.Parent = MainFrame

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(Config.TweenTime), {TextColor3 = Color3.fromRGB(230, 70, 70)}):Play()
end)
CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(Config.TweenTime), {TextColor3 = Color3.fromRGB(150, 140, 130)}):Play()
end)

CloseButton.MouseButton1Click:Connect(function()
    local fadeFrame = TweenService:Create(MainFrame, TweenInfo.new(Config.TweenTime), {BackgroundTransparency = 1})
    local fadeStroke = TweenService:Create(UIStroke, TweenInfo.new(Config.TweenTime), {Transparency = 1})
    
    fadeFrame:Play()
    fadeStroke:Play()
    
    for _, child in ipairs(MainFrame:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") then
            TweenService:Create(child, TweenInfo.new(Config.TweenTime), {TextTransparency = 1}):Play()
        elseif child:IsA("Frame") and child ~= MainFrame then
            TweenService:Create(child, TweenInfo.new(Config.TweenTime), {BackgroundTransparency = 1}):Play()
        end
    end
    
    fadeFrame.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
end)

local ResizeButton = Instance.new("ImageButton")
ResizeButton.Size = UDim2.new(0, 12, 0, 12)
ResizeButton.Position = UDim2.new(1, -12, 1, -12)
ResizeButton.BackgroundTransparency = 1
ResizeButton.Image = "rbxassetid://6031093113"
ResizeButton.ImageColor3 = Color3.fromRGB(80, 70, 60)
ResizeButton.ZIndex = 100010
ResizeButton.Parent = MainFrame

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, -16, 0, 24)
TextLabel.Position = UDim2.new(0, 8, 0, 28)
TextLabel.BackgroundTransparency = 1
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextColor3 = Color3.fromRGB(240, 180, 50)
TextLabel.TextSize = 22
TextLabel.TextScaled = true
TextLabel.Text = "Knobs: 0"
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.ZIndex = 100000
local UITX1 = Instance.new("UITextSizeConstraint", TextLabel)
UITX1.MaxTextSize = 26
UITX1.MinTextSize = 14
TextLabel.Parent = MainFrame

local IncomeLabel = Instance.new("TextLabel")
IncomeLabel.Size = UDim2.new(1, -16, 0, 20)
IncomeLabel.Position = UDim2.new(0, 8, 0, 56)
IncomeLabel.BackgroundTransparency = 1
IncomeLabel.Font = Enum.Font.GothamMedium
IncomeLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
IncomeLabel.TextSize = 14
IncomeLabel.TextScaled = true
IncomeLabel.Text = "Knobs/s: 0,00"
IncomeLabel.TextXAlignment = Enum.TextXAlignment.Left
IncomeLabel.ZIndex = 100000
local UITX2 = Instance.new("UITextSizeConstraint", IncomeLabel)
UITX2.MaxTextSize = 16
UITX2.MinTextSize = 10
IncomeLabel.Parent = MainFrame

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Size = UDim2.new(1, -16, 0, 20)
TimeLabel.Position = UDim2.new(0, 8, 0, 78)
TimeLabel.BackgroundTransparency = 1
TimeLabel.Font = Enum.Font.GothamMedium
TimeLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
TimeLabel.TextSize = 14
TimeLabel.TextScaled = true
TimeLabel.Text = "Time: 0,00"
TimeLabel.TextXAlignment = Enum.TextXAlignment.Left
TimeLabel.ZIndex = 100000
local UITX3 = Instance.new("UITextSizeConstraint", TimeLabel)
UITX3.MaxTextSize = 16
UITX3.MinTextSize = 10
TimeLabel.Parent = MainFrame

local dragging, dragInput, dragStart, startPos
local resizing = false
local resizeStartPos, resizeStartSize

MainFrame.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not UserInputService:GetFocusedTextBox() then
        if not resizing then
            local mousePos = input.Position
            if mousePos.X < CloseButton.AbsolutePosition.X or mousePos.Y > CloseButton.AbsolutePosition.Y + 20 then
                if mousePos.X < ResizeButton.AbsolutePosition.X or mousePos.Y < ResizeButton.AbsolutePosition.Y then
                    dragging = true
                    dragStart = input.Position
                    startPos = MainFrame.Position
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then dragging = false end
                    end)
                end
            end
        end
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging and not resizing then
        local delta = input.Position - dragStart
        TweenService:Create(MainFrame, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
            Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        }):Play()
    end
end)

ResizeButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true
        dragging = false
        resizeStartPos = input.Position
        resizeStartSize = MainFrame.AbsoluteSize
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then resizing = false end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - resizeStartPos
        
        local newX = math.clamp(resizeStartSize.X + delta.X, Config.MinSize.X, Config.MaxSize.X)
        local aspectRatio = 110 / 240
        local newY = math.clamp(newX * aspectRatio, Config.MinSize.Y, Config.MaxSize.Y)
        newX = newY / aspectRatio
        
        TweenService:Create(MainFrame, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
            Size = UDim2.new(0, newX, 0, newY)
        }):Play()
        
        TextLabel.Size = UDim2.new(1, -16, 0, newY * 0.22)
        TextLabel.Position = UDim2.new(0, 8, 0, newY * 0.25)
        
        IncomeLabel.Size = UDim2.new(1, -16, 0, newY * 0.18)
        IncomeLabel.Position = UDim2.new(0, 8, 0, newY * 0.51)
        
        TimeLabel.Size = UDim2.new(1, -16, 0, newY * 0.18)
        TimeLabel.Position = UDim2.new(0, 8, 0, newY * 0.71)
    end
end)

local topbarUI = PlayerGui:WaitForChild("TopbarUI", 10)
local topbar = topbarUI and topbarUI:WaitForChild("Topbar", 5)
local handler = topbar and topbar:WaitForChild("StatsTopbarHandler", 5)
local modules = handler and handler:WaitForChild("StatModules", 5)
local knobsFolder = modules and modules:WaitForChild("Knobs", 5)
local knobsVal = knobsFolder and knobsFolder:WaitForChild("KnobsVal", 5)

local function getNumericValue()
    if knobsVal then
        local cleanText = string.gsub(tostring(knobsVal.Value), "[^%d]", "")
        return tonumber(cleanText) or 0
    end
    return 0
end

local function formatComma(value)
    local str = string.format("%.2f", value)
    return string.gsub(str, "%.", ",")
end

local stableKnobs = getNumericValue()
local firstStartTime = nil
local lastGainTime = os.clock()
local earnHistory = {}
local lastChangeDetected = 0
local checkActive = false
local currentProfitText = ""

local function processChange()
    checkActive = true
    local startTimeOfGain = os.clock()
    local initialKnobs = stableKnobs
    
    if firstStartTime == nil then
        firstStartTime = startTimeOfGain
    end
    while os.clock() - lastChangeDetected < Config.WaitTime do
        task.wait(0.1)
    end
    local finalKnobs = getNumericValue()
    local duration = startTimeOfGain - lastGainTime
    local totalDifference = finalKnobs - initialKnobs
    if totalDifference > 0 then
        TimeLabel.Text = "Time: " .. formatComma(duration)
        currentProfitText = " (+" .. totalDifference .. ")"
        TextLabel.Text = "Knobs: " .. finalKnobs .. currentProfitText
        table.insert(earnHistory, {time = startTimeOfGain, amount = totalDifference})
        lastGainTime = startTimeOfGain
    end
    stableKnobs = finalKnobs
    checkActive = false
end

if knobsVal then
    TextLabel.Text = "Knobs: " .. stableKnobs
    knobsVal:GetPropertyChangedSignal("Value"):Connect(function()
        local current = getNumericValue()
        TextLabel.Text = "Knobs: " .. current .. currentProfitText
        if current ~= stableKnobs then
            lastChangeDetected = os.clock()
            if not checkActive then
                task.spawn(processChange)
            end
        end
    end)
end

task.spawn(function()
    while true do
        local now = os.clock()
        local totalEarnedInWindow = 0
        for i = #earnHistory, 1, -1 do
            local record = earnHistory[i]
            if now - record.time > Config.WindowSize then
                table.remove(earnHistory, i)
            else
                totalEarnedInWindow = totalEarnedInWindow + record.amount
            end
        end
        local knobsPerSecond = 0
        if firstStartTime ~= nil then
            local activeTime = now - firstStartTime
            local divisor = math.min(activeTime, Config.WindowSize)
            local rawKps = totalEarnedInWindow / divisor
            if rawKps > 0 then
                local expectedRoundIncome = 49
                local expectedRoundTime = 8.16
                local targetKps = expectedRoundIncome / expectedRoundTime
                if math.abs(rawKps - targetKps) < 0.9 then
                    knobsPerSecond = targetKps
                else
                    knobsPerSecond = rawKps
                end
            end
        end
        IncomeLabel.Text = "Knobs/s: " .. formatComma(knobsPerSecond)
        if ScreenGui.DisplayOrder ~= 999999999 then
            ScreenGui.DisplayOrder = 999999999
        end
        task.wait(Config.CheckInterval)
    end
end)
