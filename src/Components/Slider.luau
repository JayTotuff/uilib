-- Slider Component
local Root = script.Parent.Parent
local Creator = require(Root.Modules.Creator)
local New = Creator.New

local SliderModule = {}

function SliderModule:New(Name, Config, Parent)
    local Slider = {
        Name = Name,
        Value = Config.Default or 0,
        Min = Config.Min or 0,
        Max = Config.Max or 100,
        Callback = Config.Callback or function() end,
        Type = "Slider",
    }

    -- Create slider frame
    Slider.Frame = New("Frame", {
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundTransparency = 1,
        Parent = Parent,
    })

    -- Create label
    Slider.Label = New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = Config.Title or Name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Slider.Frame,
    })

    -- Create value label
    Slider.ValueLabel = New("TextLabel", {
        Size = UDim2.new(0, 50, 0, 20),
        Position = UDim2.new(1, -50, 0, 0),
        BackgroundTransparency = 1,
        Text = tostring(Slider.Value),
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = Slider.Frame,
    })

    -- Create slider track
    Slider.Track = New("Frame", {
        Size = UDim2.new(1, 0, 0, 4),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        BorderSizePixel = 0,
        Parent = Slider.Frame,
    }, {
        New("UICorner", {
            CornerRadius = UDim.new(0, 2),
        }),
    })

    -- Create slider fill
    local fillPercent = (Slider.Value - Slider.Min) / (Slider.Max - Slider.Min)
    Slider.Fill = New("Frame", {
        Size = UDim2.new(fillPercent, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(59, 130, 246),
        BorderSizePixel = 0,
        Parent = Slider.Track,
    }, {
        New("UICorner", {
            CornerRadius = UDim.new(0, 2),
        }),
    })

    -- Create slider thumb
    Slider.Thumb = New("Frame", {
        Size = UDim2.fromOffset(16, 16),
        Position = UDim2.new(fillPercent, -8, 0.5, -8),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Parent = Slider.Track,
    }, {
        New("UICorner", {
            CornerRadius = UDim.new(0, 8),
        }),
        New("UIStroke", {
            Color = Color3.fromRGB(100, 100, 100),
            Thickness = 1,
        }),
    })

    -- Handle dragging
    local UserInputService = game:GetService("UserInputService")
    local dragging = false

    Creator.AddSignal(Slider.Thumb.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    Creator.AddSignal(UserInputService.InputChanged, function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mouse = game.Players.LocalPlayer:GetMouse()
            local trackPos = Slider.Track.AbsolutePosition.X
            local trackSize = Slider.Track.AbsoluteSize.X
            local relativePos = math.clamp((mouse.X - trackPos) / trackSize, 0, 1)
            
            local newValue = Slider.Min + (relativePos * (Slider.Max - Slider.Min))
            Slider:SetValue(newValue)
        end
    end)

    Creator.AddSignal(UserInputService.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    function Slider:SetValue(Value)
        self.Value = math.clamp(Value, self.Min, self.Max)
        local percent = (self.Value - self.Min) / (self.Max - self.Min)
        
        self.ValueLabel.Text = tostring(math.floor(self.Value))
        
        local TweenService = game:GetService("TweenService")
        local FillTween = TweenService:Create(
            self.Fill,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad),
            {Size = UDim2.new(percent, 0, 1, 0)}
        )
        local ThumbTween = TweenService:Create(
            self.Thumb,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad),
            {Position = UDim2.new(percent, -8, 0.5, -8)}
        )
        
        FillTween:Play()
        ThumbTween:Play()
        
        self.Callback(self.Value)
    end

    return Slider
end

return SliderModule
