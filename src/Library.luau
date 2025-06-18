local library = {}

function play(id)
    for _, v in next, workspace:GetChildren() do
        if v.Name == "BronxUISound" then
            v:Destroy()
        end
    end
    local Sound = Instance.new("Sound", workspace)
    Sound.Name = "BronxUISound"
    Sound.Volume = 0.5
    Sound.SoundId = id
    Sound:Play()
end

function library:CreateWindow(name, theme)
    local theme1, theme2, theme3
    local toolight = false
    
    -- Clean up existing windows
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == "BronxUI" then
            v:Destroy()
        end
    end

    -- Theme system
    if theme == "Dark" or theme == nil then
        theme1 = Color3.fromRGB(20, 20, 20)  -- Sidebar
        theme2 = Color3.fromRGB(25, 25, 25)  -- Main background
        theme3 = Color3.fromRGB(59, 130, 246) -- Blue accent
    elseif theme == "Blood" then
        theme1 = Color3.fromRGB(20, 20, 20)
        theme2 = Color3.fromRGB(25, 25, 25)
        theme3 = Color3.fromRGB(220, 38, 38)
    elseif theme == "Emerald" then
        theme1 = Color3.fromRGB(20, 20, 20)
        theme2 = Color3.fromRGB(25, 25, 25)
        theme3 = Color3.fromRGB(34, 197, 94)
    elseif theme == "Purple" then
        theme1 = Color3.fromRGB(20, 20, 20)
        theme2 = Color3.fromRGB(25, 25, 25)
        theme3 = Color3.fromRGB(147, 51, 234)
    end

    -- Create main GUI
    local Screen = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Sidebar = Instance.new("Frame")
    local SidebarCorner = Instance.new("UICorner")
    local Logo = Instance.new("TextLabel")
    local TabContainer = Instance.new("ScrollingFrame")
    local TabLayout = Instance.new("UIListLayout")
    local TabPadding = Instance.new("UIPadding")
    local ContentArea = Instance.new("Frame")
    local ContentCorner = Instance.new("UICorner")
    local Header = Instance.new("Frame")
    local HeaderTitle = Instance.new("TextLabel")
    local ItemsContainer = Instance.new("ScrollingFrame")
    local ItemsLayout = Instance.new("UIListLayout")
    local ItemsPadding = Instance.new("UIPadding")
    local Footer = Instance.new("Frame")
    local FooterLeft = Instance.new("TextLabel")
    local FooterRight = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")

    -- Properties
    Screen.Name = "BronxUI"
    Screen.Parent = game.CoreGui
    Screen.ResetOnSpawn = false

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Screen
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -415, 0.5, -262)
    MainFrame.Size = UDim2.new(0, 830, 0, 525)
    MainFrame.Active = true
    MainFrame.Draggable = true

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(40, 40, 40)
    MainStroke.Thickness = 1
    MainStroke.Parent = MainFrame

    -- Sidebar
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = MainFrame
    Sidebar.BackgroundColor3 = theme1
    Sidebar.BorderSizePixel = 0
    Sidebar.Size = UDim2.new(0, 200, 1, 0)

    SidebarCorner.CornerRadius = UDim.new(0, 8)
    SidebarCorner.Parent = Sidebar

    -- Logo
    Logo.Name = "Logo"
    Logo.Parent = Sidebar
    Logo.BackgroundTransparency = 1
    Logo.Position = UDim2.new(0, 0, 0, 0)
    Logo.Size = UDim2.new(1, 0, 0, 60)
    Logo.Font = Enum.Font.GothamBold
    Logo.Text = name or "bronx.lol"
    Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
    Logo.TextSize = 18
    Logo.RichText = true

    -- Tab Container
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = Sidebar
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 0, 0, 60)
    TabContainer.Size = UDim2.new(1, 0, 1, -120)
    TabContainer.ScrollBarThickness = 0
    TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)

    TabLayout.Parent = TabContainer
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 2)

    TabPadding.Parent = TabContainer
    TabPadding.PaddingLeft = UDim.new(0, 8)
    TabPadding.PaddingRight = UDim.new(0, 8)
    TabPadding.PaddingTop = UDim.new(0, 5)

    -- Content Area
    ContentArea.Name = "ContentArea"
    ContentArea.Parent = MainFrame
    ContentArea.BackgroundColor3 = theme2
    ContentArea.BorderSizePixel = 0
    ContentArea.Position = UDim2.new(0, 200, 0, 0)
    ContentArea.Size = UDim2.new(1, -200, 1, 0)

    ContentCorner.CornerRadius = UDim.new(0, 8)
    ContentCorner.Parent = ContentArea

    -- Header
    Header.Name = "Header"
    Header.Parent = ContentArea
    Header.BackgroundTransparency = 1
    Header.Size = UDim2.new(1, 0, 0, 50)

    HeaderTitle.Name = "HeaderTitle"
    HeaderTitle.Parent = Header
    HeaderTitle.BackgroundTransparency = 1
    HeaderTitle.Position = UDim2.new(0, 20, 0, 0)
    HeaderTitle.Size = UDim2.new(1, -40, 1, 0)
    HeaderTitle.Font = Enum.Font.GothamBold
    HeaderTitle.Text = "General Settings"
    HeaderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    HeaderTitle.TextSize = 20
    HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left

    -- Close Button
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = Header
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -30, 0, 10)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 16

    CloseButton.MouseButton1Click:Connect(function()
        Screen:Destroy()
    end)

    -- Items Container
    ItemsContainer.Name = "ItemsContainer"
    ItemsContainer.Parent = ContentArea
    ItemsContainer.BackgroundTransparency = 1
    ItemsContainer.BorderSizePixel = 0
    ItemsContainer.Position = UDim2.new(0, 0, 0, 50)
    ItemsContainer.Size = UDim2.new(1, 0, 1, -80)
    ItemsContainer.ScrollBarThickness = 3
    ItemsContainer.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    ItemsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)

    ItemsLayout.Parent = ItemsContainer
    ItemsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ItemsLayout.Padding = UDim.new(0, 10)

    ItemsPadding.Parent = ItemsContainer
    ItemsPadding.PaddingLeft = UDim.new(0, 20)
    ItemsPadding.PaddingRight = UDim.new(0, 20)
    ItemsPadding.PaddingTop = UDim2.new(0, 10)

    -- Footer
    Footer.Name = "Footer"
    Footer.Parent = ContentArea
    Footer.BackgroundTransparency = 1
    Footer.Position = UDim2.new(0, 0, 1, -30)
    Footer.Size = UDim2.new(1, 0, 0, 30)

    FooterLeft.Name = "FooterLeft"
    FooterLeft.Parent = Footer
    FooterLeft.BackgroundTransparency = 1
    FooterLeft.Position = UDim2.new(0, 20, 0, 0)
    FooterLeft.Size = UDim2.new(0.5, 0, 1, 0)
    FooterLeft.Font = Enum.Font.Gotham
    FooterLeft.Text = "bronx.lol • the bronx"
    FooterLeft.TextColor3 = Color3.fromRGB(120, 120, 120)
    FooterLeft.TextSize = 12
    FooterLeft.TextXAlignment = Enum.TextXAlignment.Left

    FooterRight.Name = "FooterRight"
    FooterRight.Parent = Footer
    FooterRight.BackgroundTransparency = 1
    FooterRight.Position = UDim2.new(0.5, 0, 0, 0)
    FooterRight.Size = UDim2.new(0.5, -20, 1, 0)
    FooterRight.Font = Enum.Font.Gotham
    FooterRight.Text = "lifetime, <font color='rgb(59,130,246)'>bronx.lol</font>"
    FooterRight.RichText = true
    FooterRight.TextColor3 = Color3.fromRGB(120, 120, 120)
    FooterRight.TextSize = 12
    FooterRight.TextXAlignment = Enum.TextXAlignment.Right

    -- Auto-resize canvas
    ItemsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ItemsContainer.CanvasSize = UDim2.new(0, 0, 0, ItemsLayout.AbsoluteContentSize.Y + 20)
    end)

    TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabContainer.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 10)
    end)

    local WindowLibrary = {}
    local currentTab = nil

    function WindowLibrary:CreateTab(name, icon)
        local TabButton = Instance.new("TextButton")
        local TabIcon = Instance.new("ImageLabel")
        local TabCorner = Instance.new("UICorner")
        local TabFrame = Instance.new("ScrollingFrame")
        local TabFrameLayout = Instance.new("UIListLayout")
        local TabFramePadding = Instance.new("UIPadding")

        -- Tab Button
        TabButton.Name = name .. "Tab"
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.BackgroundTransparency = 1
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = "  " .. name
        TabButton.TextColor3 = Color3.fromRGB(160, 160, 160)
        TabButton.TextSize = 14
        TabButton.TextXAlignment = Enum.TextXAlignment.Left

        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabButton

        -- Tab Icon (optional)
        if icon then
            TabIcon.Name = "Icon"
            TabIcon.Parent = TabButton
            TabIcon.BackgroundTransparency = 1
            TabIcon.Position = UDim2.new(0, 8, 0.5, -8)
            TabIcon.Size = UDim2.new(0, 16, 0, 16)
            TabIcon.Image = icon
            TabIcon.ImageColor3 = Color3.fromRGB(160, 160, 160)
            TabButton.Text = "    " .. name
        end

        -- Tab Content Frame
        TabFrame.Name = name .. "Frame"
        TabFrame.Parent = ItemsContainer
        TabFrame.BackgroundTransparency = 1
        TabFrame.BorderSizePixel = 0
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.ScrollBarThickness = 0
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabFrame.Visible = false

        TabFrameLayout.Parent = TabFrame
        TabFrameLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabFrameLayout.Padding = UDim.new(0, 8)

        TabFramePadding.Parent = TabFrame
        TabFramePadding.PaddingTop = UDim.new(0, 5)

        -- Auto-resize tab content
        TabFrameLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabFrameLayout.AbsoluteContentSize.Y + 10)
        end)

        -- Tab selection
        TabButton.MouseButton1Click:Connect(function()
            play("rbxassetid://6895079853")
            
            -- Hide all tabs
            for _, child in pairs(ItemsContainer:GetChildren()) do
                if child:IsA("ScrollingFrame") then
                    child.Visible = false
                end
            end
            
            -- Reset all tab colors
            for _, child in pairs(TabContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    child.TextColor3 = Color3.fromRGB(160, 160, 160)
                    child.BackgroundTransparency = 1
                    local icon = child:FindFirstChild("Icon")
                    if icon then
                        icon.ImageColor3 = Color3.fromRGB(160, 160, 160)
                    end
                end
            end
            
            -- Activate current tab
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabButton.BackgroundTransparency = 0.9
            TabButton.BackgroundColor3 = theme3
            if TabIcon then
                TabIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            end
            TabFrame.Visible = true
            currentTab = TabFrame
            HeaderTitle.Text = name .. " Settings"
        end)

        -- Hover effects
        TabButton.MouseEnter:Connect(function()
            if TabFrame ~= currentTab then
                TabButton.BackgroundTransparency = 0.95
                TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            end
        end)

        TabButton.MouseLeave:Connect(function()
            if TabFrame ~= currentTab then
                TabButton.BackgroundTransparency = 1
            end
        end)

        local TabLibrary = {}

        function TabLibrary:CreateSection(title)
            local SectionFrame = Instance.new("Frame")
            local SectionTitle = Instance.new("TextLabel")
            local SectionIcon = Instance.new("ImageLabel")
            local SectionDivider = Instance.new("Frame")
            local SectionContainer = Instance.new("Frame")
            local SectionLayout = Instance.new("UIListLayout")

            SectionFrame.Name = title .. "Section"
            SectionFrame.Parent = TabFrame
            SectionFrame.BackgroundTransparency = 1
            SectionFrame.Size = UDim2.new(1, 0, 0, 0)
            SectionFrame.AutomaticSize = Enum.AutomaticSize.Y

            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = SectionFrame
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Size = UDim2.new(1, 0, 0, 30)
            SectionTitle.Font = Enum.Font.GothamMedium
            SectionTitle.Text = "  " .. title
            SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.TextSize = 16
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

            SectionIcon.Name = "SectionIcon"
            SectionIcon.Parent = SectionTitle
            SectionIcon.BackgroundTransparency = 1
            SectionIcon.Position = UDim2.new(0, 8, 0.5, -8)
            SectionIcon.Size = UDim2.new(0, 16, 0, 16)
            SectionIcon.Image = "rbxassetid://7734053426" -- Settings icon
            SectionIcon.ImageColor3 = theme3

            SectionDivider.Name = "SectionDivider"
            SectionDivider.Parent = SectionFrame
            SectionDivider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SectionDivider.BorderSizePixel = 0
            SectionDivider.Position = UDim2.new(0, 0, 0, 30)
            SectionDivider.Size = UDim2.new(1, 0, 0, 1)

            SectionContainer.Name = "SectionContainer"
            SectionContainer.Parent = SectionFrame
            SectionContainer.BackgroundTransparency = 1
            SectionContainer.Position = UDim2.new(0, 0, 0, 35)
            SectionContainer.Size = UDim2.new(1, 0, 0, 0)
            SectionContainer.AutomaticSize = Enum.AutomaticSize.Y

            SectionLayout.Parent = SectionContainer
            SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionLayout.Padding = UDim.new(0, 5)

            local SectionLibrary = {}

            function SectionLibrary:CreateToggle(name, config)
                config = config or {}
                local callback = config.Callback or function() end
                local default = config.Default or false

                local ToggleFrame = Instance.new("Frame")
                local ToggleLabel = Instance.new("TextLabel")
                local ToggleButton = Instance.new("TextButton")
                local ToggleBack = Instance.new("Frame")
                local ToggleBackCorner = Instance.new("UICorner")
                local ToggleThumb = Instance.new("Frame")
                local ToggleThumbCorner = Instance.new("UICorner")

                ToggleFrame.Name = name .. "Toggle"
                ToggleFrame.Parent = SectionContainer
                ToggleFrame.BackgroundTransparency = 1
                ToggleFrame.Size = UDim2.new(1, 0, 0, 35)

                ToggleLabel.Name = "ToggleLabel"
                ToggleLabel.Parent = ToggleFrame
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Size = UDim2.new(1, -50, 1, 0)
                ToggleLabel.Font = Enum.Font.Gotham
                ToggleLabel.Text = config.Title or name
                ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleLabel.TextSize = 14
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

                ToggleButton.Name = "ToggleButton"
                ToggleButton.Parent = ToggleFrame
                ToggleButton.BackgroundTransparency = 1
                ToggleButton.Position = UDim2.new(1, -40, 0.5, -10)
                ToggleButton.Size = UDim2.new(0, 40, 0, 20)
                ToggleButton.Text = ""

                ToggleBack.Name = "ToggleBack"
                ToggleBack.Parent = ToggleButton
                ToggleBack.BackgroundColor3 = default and theme3 or Color3.fromRGB(100, 100, 100)
                ToggleBack.BorderSizePixel = 0
                ToggleBack.Size = UDim2.new(1, 0, 1, 0)

                ToggleBackCorner.CornerRadius = UDim.new(0, 10)
                ToggleBackCorner.Parent = ToggleBack

                ToggleThumb.Name = "ToggleThumb"
                ToggleThumb.Parent = ToggleBack
                ToggleThumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleThumb.BorderSizePixel = 0
                ToggleThumb.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                ToggleThumb.Size = UDim2.new(0, 16, 0, 16)

                ToggleThumbCorner.CornerRadius = UDim.new(0, 8)
                ToggleThumbCorner.Parent = ToggleThumb

                local enabled = default
                local TweenService = game:GetService("TweenService")

                ToggleButton.MouseButton1Click:Connect(function()
                    enabled = not enabled
                    play("rbxassetid://6895079853")

                    local backTween = TweenService:Create(ToggleBack, TweenInfo.new(0.2), {
                        BackgroundColor3 = enabled and theme3 or Color3.fromRGB(100, 100, 100)
                    })
                    local thumbTween = TweenService:Create(ToggleThumb, TweenInfo.new(0.2), {
                        Position = enabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                    })

                    backTween:Play()
                    thumbTween:Play()
                    callback(enabled)
                end)

                return {
                    SetValue = function(value)
                        enabled = value
                        ToggleBack.BackgroundColor3 = enabled and theme3 or Color3.fromRGB(100, 100, 100)
                        ToggleThumb.Position = enabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                    end
                }
            end

            function SectionLibrary:CreateSlider(name, config)
                config = config or {}
                local callback = config.Callback or function() end
                local min = config.Min or 0
                local max = config.Max or 100
                local default = config.Default or min

                local SliderFrame = Instance.new("Frame")
                local SliderLabel = Instance.new("TextLabel")
                local SliderValue = Instance.new("TextLabel")
                local SliderTrack = Instance.new("Frame")
                local SliderTrackCorner = Instance.new("UICorner")
                local SliderFill = Instance.new("Frame")
                local SliderFillCorner = Instance.new("UICorner")
                local SliderThumb = Instance.new("Frame")
                local SliderThumbCorner = Instance.new("UICorner")
                local SliderButton = Instance.new("TextButton")

                SliderFrame.Name = name .. "Slider"
                SliderFrame.Parent = SectionContainer
                SliderFrame.BackgroundTransparency = 1
                SliderFrame.Size = UDim2.new(1, 0, 0, 50)

                SliderLabel.Name = "SliderLabel"
                SliderLabel.Parent = SliderFrame
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Size = UDim2.new(1, -50, 0, 20)
                SliderLabel.Font = Enum.Font.Gotham
                SliderLabel.Text = config.Title or name
                SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderLabel.TextSize = 14
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

                SliderValue.Name = "SliderValue"
                SliderValue.Parent = SliderFrame
                SliderValue.BackgroundTransparency = 1
                SliderValue.Position = UDim2.new(1, -50, 0, 0)
                SliderValue.Size = UDim2.new(0, 50, 0, 20)
                SliderValue.Font = Enum.Font.Gotham
                SliderValue.Text = tostring(default)
                SliderValue.TextColor3 = Color3.fromRGB(200, 200, 200)
                SliderValue.TextSize = 12
                SliderValue.TextXAlignment = Enum.TextXAlignment.Right

                SliderTrack.Name = "SliderTrack"
                SliderTrack.Parent = SliderFrame
                SliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                SliderTrack.BorderSizePixel = 0
                SliderTrack.Position = UDim2.new(0, 0, 0, 30)
                SliderTrack.Size = UDim2.new(1, 0, 0, 4)

                SliderTrackCorner.CornerRadius = UDim.new(0, 2)
                SliderTrackCorner.Parent = SliderTrack

                local fillPercent = (default - min) / (max - min)
                SliderFill.Name = "SliderFill"
                SliderFill.Parent = SliderTrack
                SliderFill.BackgroundColor3 = theme3
                SliderFill.BorderSizePixel = 0
                SliderFill.Size = UDim2.new(fillPercent, 0, 1, 0)

                SliderFillCorner.CornerRadius = UDim.new(0, 2)
                SliderFillCorner.Parent = SliderFill

                SliderThumb.Name = "SliderThumb"
                SliderThumb.Parent = SliderTrack
                SliderThumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderThumb.BorderSizePixel = 0
                SliderThumb.Position = UDim2.new(fillPercent, -8, 0.5, -8)
                SliderThumb.Size = UDim2.new(0, 16, 0, 16)

                SliderThumbCorner.CornerRadius = UDim.new(0, 8)
                SliderThumbCorner.Parent = SliderThumb

                local ThumbStroke = Instance.new("UIStroke")
                ThumbStroke.Color = Color3.fromRGB(100, 100, 100)
                ThumbStroke.Thickness = 1
                ThumbStroke.Parent = SliderThumb

                SliderButton.Name = "SliderButton"
                SliderButton.Parent = SliderTrack
                SliderButton.BackgroundTransparency = 1
                SliderButton.Size = UDim2.new(1, 0, 1, 0)
                SliderButton.Text = ""

                local UserInputService = game:GetService("UserInputService")
                local TweenService = game:GetService("TweenService")
                local dragging = false
                local currentValue = default

                local function updateSlider(input)
                    local trackPos = SliderTrack.AbsolutePosition.X
                    local trackSize = SliderTrack.AbsoluteSize.X
                    local relativePos = math.clamp((input.Position.X - trackPos) / trackSize, 0, 1)
                    
                    currentValue = math.floor(min + (relativePos * (max - min)))
                    local percent = (currentValue - min) / (max - min)
                    
                    SliderValue.Text = tostring(currentValue)
                    
                    local fillTween = TweenService:Create(SliderFill, TweenInfo.new(0.1), {
                        Size = UDim2.new(percent, 0, 1, 0)
                    })
                    local thumbTween = TweenService:Create(SliderThumb, TweenInfo.new(0.1), {
                        Position = UDim2.new(percent, -8, 0.5, -8)
                    })
                    
                    fillTween:Play()
                    thumbTween:Play()
                    callback(currentValue)
                end

                SliderButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        updateSlider(input)
                    end
                end)

                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        updateSlider(input)
                    end
                end)

                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)

                return {
                    SetValue = function(value)
                        currentValue = math.clamp(value, min, max)
                        local percent = (currentValue - min) / (max - min)
                        SliderValue.Text = tostring(currentValue)
                        SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                        SliderThumb.Position = UDim2.new(percent, -8, 0.5, -8)
                    end
                }
            end

            function SectionLibrary:CreateButton(config)
                config = config or {}
                local callback = config.Callback or function() end

                local ButtonFrame = Instance.new("Frame")
                local Button = Instance.new("TextButton")
                local ButtonCorner = Instance.new("UICorner")

                ButtonFrame.Name = (config.Title or "Button") .. "Frame"
                ButtonFrame.Parent = SectionContainer
                ButtonFrame.BackgroundTransparency = 1
                ButtonFrame.Size = UDim2.new(1, 0, 0, 35)

                Button.Name = "Button"
                Button.Parent = ButtonFrame
                Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                Button.BorderSizePixel = 0
                Button.Size = UDim2.new(1, 0, 1, 0)
                Button.Font = Enum.Font.Gotham
                Button.Text = config.Title or "Button"
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.TextSize = 14

                ButtonCorner.CornerRadius = UDim.new(0, 6)
                ButtonCorner.Parent = Button

                Button.MouseButton1Click:Connect(function()
                    play("rbxassetid://6895079853")
                    callback()
                end)

                Button.MouseEnter:Connect(function()
                    Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                end)

                Button.MouseLeave:Connect(function()
                    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                end)
            end

            function SectionLibrary:CreateKeybind(name, config)
                config = config or {}
                local callback = config.Callback or function() end
                local default = config.Default or "NONE"

                local KeybindFrame = Instance.new("Frame")
                local KeybindLabel = Instance.new("TextLabel")
                local KeybindButton = Instance.new("TextButton")
                local KeybindCorner = Instance.new("UICorner")

                KeybindFrame.Name = name .. "Keybind"
                KeybindFrame.Parent = SectionContainer
                KeybindFrame.BackgroundTransparency = 1
                KeybindFrame.Size = UDim2.new(1, 0, 0, 35)

                KeybindLabel.Name = "KeybindLabel"
                KeybindLabel.Parent = KeybindFrame
                KeybindLabel.BackgroundTransparency = 1
                KeybindLabel.Size = UDim2.new(1, -80, 1, 0)
                KeybindLabel.Font = Enum.Font.Gotham
                KeybindLabel.Text = config.Title or name
                KeybindLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindLabel.TextSize = 14
                KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left

                KeybindButton.Name = "KeybindButton"
                KeybindButton.Parent = KeybindFrame
                KeybindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                KeybindButton.BorderSizePixel = 0
                KeybindButton.Position = UDim2.new(1, -70, 0.5, -12)
                KeybindButton.Size = UDim2.new(0, 70, 0, 24)
                KeybindButton.Font = Enum.Font.Gotham
                KeybindButton.Text = default
                KeybindButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                KeybindButton.TextSize = 12

                KeybindCorner.CornerRadius = UDim.new(0, 4)
                KeybindCorner.Parent = KeybindButton

                local listening = false
                local UserInputService = game:GetService("UserInputService")

                KeybindButton.MouseButton1Click:Connect(function()
                    if not listening then
                        listening = true
                        KeybindButton.Text = "..."
                        KeybindButton.BackgroundColor3 = theme3
                    end
                end)

                UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if listening and not gameProcessed then
                        local keyName = input.KeyCode.Name
                        if keyName ~= "Unknown" then
                            KeybindButton.Text = keyName
                            KeybindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                            listening = false
                            callback(keyName)
                        end
                    end
                end)

                return {
                    SetValue = function(key)
                        KeybindButton.Text = key
                    end
                }
            end

            return SectionLibrary
        end

        -- Auto-select first tab
        if not currentTab then
            TabButton.MouseButton1Click()
        end

        return TabLibrary
    end

    return WindowLibrary
end

return library
