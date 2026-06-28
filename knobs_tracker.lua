local Config = {
    WaitTime = 1.1,
    WindowSize = 50,
    CheckInterval = 1.5,
    DefaultSize = UDim2.new(0, 240, 0, 150),
    MinSize = Vector2.new(180, 112.5), 
    MaxSize = Vector2.new(450, 281.25), 
    GuiPosition = UDim2.new(1, -260, 0, 140),
    BackgroundColor = Color3.fromRGB(18, 16, 15),
    BorderColor = Color3.fromRGB(55, 48, 40),
    TweenTime = 0.2,
    AutoKey = "DOORSJAYOMGKEY"
}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
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
Line.BackgroundColor3 = Config.BorderColor
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
TextLabel.Size = UDim2.new(1, -16, 0, 20)
TextLabel.Position = UDim2.new(0, 8, 0, 26)
TextLabel.BackgroundTransparency = 1
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextColor3 = Color3.fromRGB(240, 180, 50)
TextLabel.TextSize = 20
TextLabel.TextScaled = true
TextLabel.Text = "Knobs: 0"
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.ZIndex = 100000
local UITX1 = Instance.new("UITextSizeConstraint", TextLabel)
UITX1.MaxTextSize = 22
UITX1.MinTextSize = 12
TextLabel.Parent = MainFrame

local TotalEarnedLabel = Instance.new("TextLabel")
TotalEarnedLabel.Size = UDim2.new(1, -16, 0, 14)
TotalEarnedLabel.Position = UDim2.new(0, 8, 0, 48)
TotalEarnedLabel.BackgroundTransparency = 1
TotalEarnedLabel.Font = Enum.Font.GothamMedium
TotalEarnedLabel.TextColor3 = Color3.fromRGB(210, 160, 40)
TotalEarnedLabel.TextSize = 13
TotalEarnedLabel.TextScaled = true
TotalEarnedLabel.Text = "Total Earned: 0"
TotalEarnedLabel.TextXAlignment = Enum.TextXAlignment.Left
TotalEarnedLabel.ZIndex = 100000
local UITXTotal = Instance.new("UITextSizeConstraint", TotalEarnedLabel)
UITXTotal.MaxTextSize = 14
UITXTotal.MinTextSize = 10
TotalEarnedLabel.Parent = MainFrame

local IncomeLabel = Instance.new("TextLabel")
IncomeLabel.Size = UDim2.new(1, -16, 0, 14)
IncomeLabel.Position = UDim2.new(0, 8, 0, 64)
IncomeLabel.BackgroundTransparency = 1
IncomeLabel.Font = Enum.Font.GothamMedium
IncomeLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
IncomeLabel.TextSize = 13
IncomeLabel.TextScaled = true
IncomeLabel.Text = "Knobs/s: 0"
IncomeLabel.TextXAlignment = Enum.TextXAlignment.Left
IncomeLabel.ZIndex = 100000
local UITX2 = Instance.new("UITextSizeConstraint", IncomeLabel)
UITX2.MaxTextSize = 14
UITX2.MinTextSize = 10
IncomeLabel.Parent = MainFrame

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Size = UDim2.new(1, -16, 0, 14)
TimeLabel.Position = UDim2.new(0, 8, 0, 80)
TimeLabel.BackgroundTransparency = 1
TimeLabel.Font = Enum.Font.GothamMedium
TimeLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
TimeLabel.TextSize = 13
TimeLabel.TextScaled = true
TimeLabel.Text = "Time: 0,00"
TimeLabel.TextXAlignment = Enum.TextXAlignment.Left
TimeLabel.ZIndex = 100000
local UITX3 = Instance.new("UITextSizeConstraint", TimeLabel)
UITX3.MaxTextSize = 14
UITX3.MinTextSize = 10
TimeLabel.Parent = MainFrame

local KeyLabel = Instance.new("TextLabel")
KeyLabel.Size = UDim2.new(0, 80, 0, 20)
KeyLabel.Position = UDim2.new(0, 8, 0, 102)
KeyLabel.BackgroundTransparency = 1
KeyLabel.Font = Enum.Font.GothamMedium
KeyLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
KeyLabel.TextSize = 13
KeyLabel.Text = "Auto Key"
KeyLabel.TextXAlignment = Enum.TextXAlignment.Left
KeyLabel.ZIndex = 100000
KeyLabel.Parent = MainFrame

local KeyToggleBG = Instance.new("TextButton")
KeyToggleBG.Size = UDim2.new(0, 36, 0, 18)
KeyToggleBG.Position = UDim2.new(0, 95, 0, 103)
KeyToggleBG.BackgroundColor3 = Color3.fromRGB(30, 25, 22)
KeyToggleBG.Text = ""
KeyToggleBG.ZIndex = 100000
KeyToggleBG.Parent = MainFrame

local KeyToggleStroke = Instance.new("UIStroke")
KeyToggleStroke.Color = Color3.fromRGB(55, 48, 40)
KeyToggleStroke.Thickness = 1
KeyToggleStroke.Parent = KeyToggleBG

local KeyToggleCorner = Instance.new("UICorner")
KeyToggleCorner.CornerRadius = UDim.new(0, 9)
KeyToggleCorner.Parent = KeyToggleBG

local KeyToggleSlider = Instance.new("Frame")
KeyToggleSlider.Size = UDim2.new(0, 14, 0, 14)
KeyToggleSlider.Position = UDim2.new(0, 2, 0, 2)
KeyToggleSlider.BackgroundColor3 = Color3.fromRGB(120, 110, 100)
KeyToggleSlider.BorderSizePixel = 0
KeyToggleSlider.ZIndex = 100005
KeyToggleSlider.Parent = KeyToggleBG

local KeySliderCorner = Instance.new("UICorner")
KeySliderCorner.CornerRadius = UDim.new(0, 7)
KeySliderCorner.Parent = KeyToggleSlider

local AfkLabel = Instance.new("TextLabel")
AfkLabel.Size = UDim2.new(0, 80, 0, 20)
AfkLabel.Position = UDim2.new(0, 8, 0, 124)
AfkLabel.BackgroundTransparency = 1
AfkLabel.Font = Enum.Font.GothamMedium
AfkLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
AfkLabel.TextSize = 13
AfkLabel.Text = "Anti-AFK"
AfkLabel.TextXAlignment = Enum.TextXAlignment.Left
AfkLabel.ZIndex = 100000
AfkLabel.Parent = MainFrame

local ToggleBG = Instance.new("TextButton")
ToggleBG.Size = UDim2.new(0, 36, 0, 18)
ToggleBG.Position = UDim2.new(0, 95, 0, 125)
ToggleBG.BackgroundColor3 = Color3.fromRGB(30, 25, 22)
ToggleBG.Text = ""
ToggleBG.ZIndex = 100000
ToggleBG.Parent = MainFrame

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(55, 48, 40)
ToggleStroke.Thickness = 1
ToggleStroke.Parent = ToggleBG

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 9)
ToggleCorner.Parent = ToggleBG

local ToggleSlider = Instance.new("Frame")
ToggleSlider.Size = UDim2.new(0, 14, 0, 14)
ToggleSlider.Position = UDim2.new(0, 2, 0, 2)
ToggleSlider.BackgroundColor3 = Color3.fromRGB(120, 110, 100)
ToggleSlider.BorderSizePixel = 0
ToggleSlider.ZIndex = 100005
ToggleSlider.Parent = ToggleBG

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(0, 7)
SliderCorner.Parent = ToggleSlider

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
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end)
                end
            end
        end
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
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
            if input.UserInputState == Enum.UserInputState.End then
                resizing = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - resizeStartPos
        local newX = math.clamp(resizeStartSize.X + delta.X, Config.MinSize.X, Config.MaxSize.X)
        local aspectRatio = 150 / 240
        local newY = math.clamp(newX * aspectRatio, Config.MinSize.Y, Config.MaxSize.Y)
        newX = newY / aspectRatio
        TweenService:Create(MainFrame, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
            Size = UDim2.new(0, newX, 0, newY)
        }):Play()
        TextLabel.Size = UDim2.new(1, -16, 0, newY * 0.13)
        TextLabel.Position = UDim2.new(0, 8, 0, newY * 0.17)
        TotalEarnedLabel.Size = UDim2.new(1, -16, 0, newY * 0.09)
        TotalEarnedLabel.Position = UDim2.new(0, 8, 0, newY * 0.32)
        IncomeLabel.Size = UDim2.new(1, -16, 0, newY * 0.09)
        IncomeLabel.Position = UDim2.new(0, 8, 0, newY * 0.42)
        TimeLabel.Size = UDim2.new(1, -16, 0, newY * 0.09)
        TimeLabel.Position = UDim2.new(0, 8, 0, newY * 0.53)
        KeyLabel.Size = UDim2.new(0, newX * 0.33, 0, newY * 0.13)
        KeyLabel.Position = UDim2.new(0, 8, 0, newY * 0.68)
        KeyToggleBG.Size = UDim2.new(0, newX * 0.15, 0, newY * 0.12)
        KeyToggleBG.Position = UDim2.new(0, 8 + (newX * 0.36), 0, newY * 0.68)
        KeyToggleSlider.Size = UDim2.new(0, (newY * 0.12) - 4, 0, (newY * 0.12) - 4)
        AfkLabel.Size = UDim2.new(0, newX * 0.33, 0, newY * 0.13)
        AfkLabel.Position = UDim2.new(0, 8, 0, newY * 0.82)
        ToggleBG.Size = UDim2.new(0, newX * 0.15, 0, newY * 0.12)
        ToggleBG.Position = UDim2.new(0, 8 + (newX * 0.36), 0, newY * 0.83)
        ToggleSlider.Size = UDim2.new(0, (newY * 0.12) - 4, 0, (newY * 0.12) - 4)
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

local startSessionKnobs = getNumericValue()
local stableKnobs = startSessionKnobs
local firstStartTime = nil
local lastGainTime = os.clock()
local earnHistory = {}
local recentKpsList = {}
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
    if startSessionKnobs == 0 then
        startSessionKnobs = getNumericValue()
        stableKnobs = startSessionKnobs
    end
    TextLabel.Text = "Knobs: " .. stableKnobs
    knobsVal:GetPropertyChangedSignal("Value"):Connect(function()
        local current = getNumericValue()
        TextLabel.Text = "Knobs: " .. current .. currentProfitText
        local sessionTotal = current - startSessionKnobs
        if sessionTotal >= 0 then
            TotalEarnedLabel.Text = "Total Earned: " .. sessionTotal
        end
        if current ~= stableKnobs then
            lastChangeDetected = os.clock()
            if not checkActive then
                task.spawn(processChange)
            end
        end
    end)
end

local autoKeyEnabled = false
KeyToggleBG.MouseButton1Click:Connect(function()
    autoKeyEnabled = not autoKeyEnabled
    if autoKeyEnabled then
        TweenService:Create(KeyToggleBG, TweenInfo.new(Config.TweenTime), {BackgroundColor3 = Color3.fromRGB(45, 38, 33)}):Play()
        TweenService:Create(KeyToggleStroke, TweenInfo.new(Config.TweenTime), {Color = Color3.fromRGB(240, 180, 50)}):Play()
        TweenService:Create(KeyToggleSlider, TweenInfo.new(Config.TweenTime), {Position = UDim2.new(1, -KeyToggleSlider.Size.X.Offset - 2, 0, 2), BackgroundColor3 = Color3.fromRGB(240, 180, 50)}):Play()
    else
        TweenService:Create(KeyToggleBG, TweenInfo.new(Config.TweenTime), {BackgroundColor3 = Color3.fromRGB(30, 25, 22)}):Play()
        TweenService:Create(KeyToggleStroke, TweenInfo.new(Config.TweenTime), {Color = Color3.fromRGB(55, 48, 40)}):Play()
        TweenService:Create(KeyToggleSlider, TweenInfo.new(Config.TweenTime), {Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Color3.fromRGB(120, 110, 100)}):Play()
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if autoKeyEnabled then
            for _, gui in ipairs(PlayerGui:GetChildren()) do
                if gui:IsA("ScreenGui") and gui.Name ~= "KnobsTrackerGui" then
                    local hasTitle = false
                    local hasCopyLink = false
                    local targetBox = nil
                    local submitBtn = nil
                    for _, desc in ipairs(gui:GetDescendants()) do
                        if desc:IsA("TextLabel") and desc.Text == "KEY REQUIRED" then
                            hasTitle = true
                        end
                        if desc:IsA("TextButton") and string.find(desc.Text, "COPY KEY LINK") then
                            hasCopyLink = true
                        end
                        if desc:IsA("TextBox") and desc.PlaceholderText == "Enter key..." then
                            targetBox = desc
                        end
                        if desc:IsA("TextButton") and desc.Text == "SUBMIT" then
                            submitBtn = desc
                        end
                    end
                    if hasTitle and hasCopyLink and targetBox and submitBtn then
                        targetBox.Text = Config.AutoKey
                        task.wait(0.1)
                        submitBtn:Activate()
                        break
                    end
                end
            end
        end
    end
end)

local antiAfkEnabled = false
ToggleBG.MouseButton1Click:Connect(function()
    antiAfkEnabled = not antiAfkEnabled
    if antiAfkEnabled then
        TweenService:Create(ToggleBG, TweenInfo.new(Config.TweenTime), {BackgroundColor3 = Color3.fromRGB(45, 38, 33)}):Play()
        TweenService:Create(ToggleStroke, TweenInfo.new(Config.TweenTime), {Color = Color3.fromRGB(240, 180, 50)}):Play()
        TweenService:Create(ToggleSlider, TweenInfo.new(Config.TweenTime), {Position = UDim2.new(1, -ToggleSlider.Size.X.Offset - 2, 0, 2), BackgroundColor3 = Color3.fromRGB(240, 180, 50)}):Play()
    else
        TweenService:Create(ToggleBG, TweenInfo.new(Config.TweenTime), {BackgroundColor3 = Color3.fromRGB(30, 25, 22)}):Play()
        TweenService:Create(ToggleStroke, TweenInfo.new(Config.TweenTime), {Color = Color3.fromRGB(55, 48, 40)}):Play()
        TweenService:Create(ToggleSlider, TweenInfo.new(Config.TweenTime), {Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Color3.fromRGB(120, 110, 100)}):Play()
    end
end)

task.spawn(function()
    while true do
        task.wait(5)
        if antiAfkEnabled then
            pcall(function()
                VirtualUser:ClickButton1(Vector2.new(10, 10))
            end)
        end
    end
end)

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
        local displayKps = 0
        local useTilde = false
        if firstStartTime ~= nil then
            local activeTime = now - firstStartTime
            local divisor = math.min(activeTime, Config.WindowSize)
            local rawKps = totalEarnedInWindow / divisor
            if rawKps > 0 then
                table.insert(recentKpsList, rawKps)
                if #recentKpsList > 15 then
                    table.remove(recentKpsList, 1)
                end
                local sortedList = {}
                for _, v in ipairs(recentKpsList) do
                    table.insert(sortedList, v)
                end
                table.sort(sortedList)
                local medianKps = sortedList[math.ceil(#sortedList / 2)] or rawKps
                displayKps = math.round(medianKps)
                if displayKps > 0 then
                    useTilde = true
                end
            end
        end
        if useTilde then
            IncomeLabel.Text = "Knobs/s: ~" .. tostring(displayKps)
        else
            IncomeLabel.Text = "Knobs/s: " .. tostring(displayKps)
        end
        if ScreenGui.DisplayOrder ~= 999999999 then
            ScreenGui.DisplayOrder = 999999999
        end
        task.wait(Config.CheckInterval)
    end
end)
