local Config = {
    WaitTime = 1.1,
    WindowSize = 30,
    CheckInterval = 0.3,
    GuiSize = UDim2.new(0, 240, 0, 110),
    GuiPosition = UDim2.new(1, -260, 0, 140)
}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
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
MainFrame.Size = Config.GuiSize
MainFrame.Position = Config.GuiPosition
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ZIndex = 99999
MainFrame.Parent = ScreenGui

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(45, 40, 35)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = MainFrame

local HeaderLabel = Instance.new("TextLabel")
HeaderLabel.Size = UDim2.new(1, 0, 0, 22)
HeaderLabel.BackgroundTransparency = 1
HeaderLabel.Font = Enum.Font.GothamMedium
HeaderLabel.TextColor3 = Color3.fromRGB(140, 130, 120)
HeaderLabel.TextSize = 12
HeaderLabel.Text = "  Doors Knobs Tracker"
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

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, -16, 0, 24)
TextLabel.Position = UDim2.new(0, 8, 0, 28)
TextLabel.BackgroundTransparency = 1
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextColor3 = Color3.fromRGB(240, 180, 50)
TextLabel.TextSize = 22
TextLabel.Text = "Knobs: 0"
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.ZIndex = 100000
TextLabel.Parent = MainFrame

local IncomeLabel = Instance.new("TextLabel")
IncomeLabel.Size = UDim2.new(1, -16, 0, 20)
IncomeLabel.Position = UDim2.new(0, 8, 0, 56)
IncomeLabel.BackgroundTransparency = 1
IncomeLabel.Font = Enum.Font.GothamMedium
IncomeLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
IncomeLabel.TextSize = 14
IncomeLabel.Text = "Knobs/s: 0,00"
IncomeLabel.TextXAlignment = Enum.TextXAlignment.Left
IncomeLabel.ZIndex = 100000
IncomeLabel.Parent = MainFrame

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Size = UDim2.new(1, -16, 0, 20)
TimeLabel.Position = UDim2.new(0, 8, 0, 78)
TimeLabel.BackgroundTransparency = 1
TimeLabel.Font = Enum.Font.GothamMedium
TimeLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
TimeLabel.TextSize = 14
TimeLabel.Text = "Time: 0,00"
TimeLabel.TextXAlignment = Enum.TextXAlignment.Left
TimeLabel.ZIndex = 100000
PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
TimeLabel.Parent = MainFrame

local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
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
local lastGainTime = os.clock()
local earnHistory = {}
local lastChangeDetected = 0
local checkActive = false

local function processChange()
    checkActive = true
    local startTimeOfGain = os.clock()
    local initialKnobs = stableKnobs
    
    while os.clock() - lastChangeDetected < Config.WaitTime do
        task.wait(0.1)
    end
    
    local finalKnobs = getNumericValue()
    local duration = startTimeOfGain - lastGainTime
    local totalDifference = finalKnobs - initialKnobs
    
    if totalDifference > 0 then
        TimeLabel.Text = "Time: " .. formatComma(duration) .. " (+" .. totalDifference .. ")"
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
        TextLabel.Text = "Knobs: " .. current
        
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
        
        local knobsPerSecond = totalEarnedInWindow / Config.WindowSize
        IncomeLabel.Text = "Knobs/s: " .. formatComma(knobsPerSecond)
        
        if ScreenGui.DisplayOrder ~= 999999999 then
            ScreenGui.DisplayOrder = 999999999
        end
        
        task.wait(Config.CheckInterval)
    end
end)
