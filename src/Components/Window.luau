-- Window Component
local Root = script.Parent.Parent
local Flipper = require(Root.Packages.Flipper)
local Creator = require(Root.Modules.Creator)
local TabModule = require(script.Parent.Tab)

local New = Creator.New
local Spring = Flipper.Spring.new

local WindowModule = {}

function WindowModule:New(Config)
    local Window = {
        Title = Config.Title or "bronx.lol",
        SubTitle = Config.SubTitle or "the bronx",
        Size = Config.Size or UDim2.fromOffset(830, 525),
        Theme = Config.Theme or "Dark",
        Tabs = {},
        TabCount = 0,
    }

    -- Create main window frame
    Window.Frame = New("Frame", {
        Size = Window.Size,
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderSizePixel = 0,
        Parent = game.Players.LocalPlayer.PlayerGui,
    }, {
        New("UICorner", {
            CornerRadius = UDim.new(0, 8),
        }),
        New("UIStroke", {
            Color = Color3.fromRGB(40, 40, 40),
            Thickness = 1,
        }),
    })

    -- Create sidebar
    Window.Sidebar = New("Frame", {
        Size = UDim2.new(0, 200, 1, 0),
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        BorderSizePixel = 0,
        Parent = Window.Frame,
    }, {
        New("UICorner", {
            CornerRadius = UDim.new(0, 8),
        }),
    })

    -- Create logo section
    Window.LogoFrame = New("Frame", {
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundTransparency = 1,
        Parent = Window.Sidebar,
    }, {
        New("TextLabel", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Text = Window.Title,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 18,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Center,
        }),
    })

    -- Create tab holder
    Window.TabHolder = New("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, -120),
        Position = UDim2.new(0, 0, 0, 60),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        Parent = Window.Sidebar,
    }, {
        New("UIListLayout", {
            Padding = UDim.new(0, 2),
            SortOrder = Enum.SortOrder.LayoutOrder,
        }),
        New("UIPadding", {
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8),
        }),
    })

    -- Create content area
    Window.ContentFrame = New("Frame", {
        Size = UDim2.new(1, -200, 1, 0),
        Position = UDim2.new(0, 200, 0, 0),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderSizePixel = 0,
        Parent = Window.Frame,
    }, {
        New("UICorner", {
            CornerRadius = UDim.new(0, 8),
        }),
    })

    -- Create header
    Window.Header = New("Frame", {
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundTransparency = 1,
        Parent = Window.ContentFrame,
    }, {
        New("TextLabel", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Text = "General Settings",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 20,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            Position = UDim2.new(0, 20, 0, 0),
        }),
    })

    -- Create container holder
    Window.ContainerHolder = New("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, -50),
        Position = UDim2.new(0, 0, 0, 50),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100),
        Parent = Window.ContentFrame,
    }, {
        New("UIListLayout", {
            Padding = UDim.new(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder,
        }),
        New("UIPadding", {
            PaddingLeft = UDim.new(0, 20),
            PaddingRight = UDim.new(0, 20),
            PaddingTop = UDim.new(0, 10),
        }),
    })

    -- Initialize tab system
    TabModule:Init(Window)

    function Window:CreateTab(Config)
        return TabModule:New(Config.Title, Config.Icon, self.TabHolder)
    end

    return Window
end

return WindowModule
