-- Toggle Component
local Root = script.Parent.Parent
local Creator = require(Root.Modules.Creator)
local New = Creator.New

local ToggleModule = {}

function ToggleModule:New(Name, Config, Parent)
    local Toggle = {
        Name = Name,
        Value = Config.Default or false,
        Callback = Config.Callback or function() end,
        Type = "Toggle",
    }

    -- Create toggle frame
    Toggle.Frame = New("Frame", {
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundTransparency = 1,
        Parent = Parent,
    })

    -- Create label
    Toggle.Label = New("TextLabel", {
        Size = UDim2.new(1, -50, 1, 0),
        BackgroundTransparency = 1,
        Text = Config.Title or Name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Toggle.Frame,
    })

    -- Create toggle button
    Toggle.Button = New("TextButton", {
        Size = UDim2.fromOffset(40, 20),
        Position = UDim2.new(1, -40, 0.5, -10),
        BackgroundColor3 = Toggle.Value and Color3.fromRGB(59, 130, 246) or Color3.fromRGB(100, 100, 100),
        BorderSizePixel = 0,
        Text = "",
        Parent = Toggle.Frame,
    }, {
        New("UICorner", {
            CornerRadius = UDim.new(0, 10),
        }),
    })

    -- Create toggle thumb
    Toggle.Thumb = New("Frame", {
        Size = UDim2.fromOffset(16, 16),
        Position = Toggle.Value and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Parent = Toggle.Button,
    }, {
        New("UICorner", {
            CornerRadius = UDim.new(0, 8),
        }),
    })

    -- Handle click
    Creator.AddSignal(Toggle.Button.MouseButton1Click, function()
        Toggle:SetValue(not Toggle.Value)
    end)

    function Toggle:SetValue(Value)
        self.Value = Value
        
        -- Animate toggle
        local TweenService = game:GetService("TweenService")
        local ButtonTween = TweenService:Create(
            self.Button,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {BackgroundColor3 = Value and Color3.fromRGB(59, 130, 246) or Color3.fromRGB(100, 100, 100)}
        )
        local ThumbTween = TweenService:Create(
            self.Thumb,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {Position = Value and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}
        )
        
        ButtonTween:Play()
        ThumbTween:Play()
        
        self.Callback(Value)
    end

    return Toggle
end

return ToggleModule
