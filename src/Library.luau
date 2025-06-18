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
    
    -- Clean up existing windows
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == "BronxUI" then
            v:Destroy()
        end
    end

    -- Fixed theme system
    if theme == "Dark" or theme == nil then
        theme1 = Color3.fromRGB(20, 20, 20)
        theme2 = Color3.fromRGB(25, 25, 25)
        theme3 = Color3.fromRGB(59, 130, 246)
    elseif theme == "Crimson" then
        theme1 = Color3.fromRGB(20, 20, 20)
        theme2 = Color3.fromRGB(25, 25, 25)
        theme3 = Color3.fromRGB(220, 38, 38)
    elseif theme == "Blood" then
        theme1 = Color3.fromRGB(20, 20, 20)
        theme2 = Color3.fromRGB(25, 25, 25)
        theme3 = Color3.fromRGB(138, 3, 3)
    elseif theme == "Emerald" then
        theme1 = Color3.fromRGB(20, 20, 20)
        theme2 = Color3.fromRGB(25, 25, 25)
        theme3 = Color3.fromRGB(34, 197, 94)
    elseif theme == "Purple" then
        theme1 = Color3.fromRGB(20, 20, 20)
        theme2 = Color3.fromRGB(25, 25, 25)
        theme3 = Color3.fromRGB(147, 51, 234)
    else
        -- Default fallback
        theme1 = Color3.fromRGB(20, 20, 20)
        theme2 = Color3.fromRGB(25, 25, 25)
        theme3 = Color3.fromRGB(59, 130, 246)
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
    local ItemsContainer = Instance.new("Frame")
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
    MainFrame.BackgroundColor3 = theme2
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
    FooterRight.Text = "lifetime, bronx.lol"
    FooterRight.TextColor3 = theme3
    FooterRight.TextSize = 12
    FooterRight.TextXAlignment = Enum.TextXAlignment.Right

    local WindowLibrary = {}
    local currentTab = nil
    local tabFrames = {}

    function WindowLibrary:CreateTab(name, icon)
        local TabButton = Instance.new("TextButton")
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

        -- Tab Content Frame
        TabFrame.Name = name .. "Frame"
        TabFrame.Parent = ItemsContainer
        TabFrame.BackgroundTransparency = 1
        TabFrame.BorderSizePixel = 0
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.ScrollBarThickness = 3
        TabFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabFrame.Visible = false

        TabFrameLayout.Parent = TabFrame
        TabFrameLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabFrameLayout.Padding = UDim.new(0, 8)

        TabFramePadding.Parent = TabFrame
        TabFramePadding.PaddingLeft = UDim.new(0, 20)
        TabFramePadding.PaddingRight = UDim.new(0, 20)
        TabFramePadding.PaddingTop = UDim.new(0, 10)

        -- Auto-resize tab content
        TabFrameLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabFrameLayout.AbsoluteContentSize.Y + 20)
        end)

        -- Store tab frame
        tabFrames[name] = TabFrame

        -- Tab selection
        TabButton.MouseButton1Click:Connect(function()
            -- Hide all tabs
            for _, frame in pairs(tabFrames) do
                frame.Visible = false
            end
            
            -- Reset all tab colors
            for _, child in pairs(TabContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    child.TextColor3 = Color3.fromRGB(160, 160, 160)
                    child.BackgroundTransparency = 1
                end
            end
            
            -- Activate current tab
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabButton.BackgroundTransparency = 0.9
            TabButton.BackgroundColor3 = theme3
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

        function TabLibrary:CreateButton(text, callback)
            callback = callback or function() end
            
            local ButtonFrame = Instance.new("Frame")
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")

            ButtonFrame.Name = text .. "ButtonFrame"
            ButtonFrame.Parent = TabFrame
            ButtonFrame.BackgroundTransparency = 1
            ButtonFrame.Size = UDim2.new(1, 0, 0, 35)

            Button.Name = "Button"
            Button.Parent = ButtonFrame
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Button.BorderSizePixel = 0
            Button.Size = UDim2.new(1, 0, 1, 0)
            Button.Font = Enum.Font.Gotham
            Button.Text = text
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 14

            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = Button

            Button.MouseButton1Click:Connect(function()
                callback()
            end)

            Button.MouseEnter:Connect(function()
                Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            end)

            Button.MouseLeave:Connect(function()
                Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            end)
        end

        function TabLibrary:CreateToggle(text, callback)
            callback = callback or function() end
            
            local ToggleFrame = Instance.new("Frame")
            local ToggleLabel = Instance.new("TextLabel")
            local ToggleButton = Instance.new("TextButton")
            local ToggleBack = Instance.new("Frame")
            local ToggleBackCorner = Instance.new("UICorner")
            local ToggleThumb = Instance.new("Frame")
            local ToggleThumbCorner = Instance.new("UICorner")

            ToggleFrame.Name = text .. "Toggle"
            ToggleFrame.Parent = TabFrame
            ToggleFrame.BackgroundTransparency = 1
            ToggleFrame.Size = UDim2.new(1, 0, 0, 35)

            ToggleLabel.Name = "ToggleLabel"
            ToggleLabel.Parent = ToggleFrame
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Size = UDim2.new(1, -50, 1, 0)
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.Text = text
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
            ToggleBack.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            ToggleBack.BorderSizePixel = 0
            ToggleBack.Size = UDim2.new(1, 0, 1, 0)

            ToggleBackCorner.CornerRadius = UDim.new(0, 10)
            ToggleBackCorner.Parent = ToggleBack

            ToggleThumb.Name = "ToggleThumb"
            ToggleThumb.Parent = ToggleBack
            ToggleThumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleThumb.BorderSizePixel = 0
            ToggleThumb.Position = UDim2.new(0, 2, 0.5, -8)
            ToggleThumb.Size = UDim2.new(0, 16, 0, 16)

            ToggleThumbCorner.CornerRadius = UDim.new(0, 8)
            ToggleThumbCorner.Parent = ToggleThumb

            local enabled = false
            local TweenService = game:GetService("TweenService")

            ToggleButton.MouseButton1Click:Connect(function()
                enabled = not enabled

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
        end

        function TabLibrary:CreateSlider(text, min, max, callback)
            callback = callback or function() end
            min = min or 0
            max = max or 100
            
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

            SliderFrame.Name = text .. "Slider"
            SliderFrame.Parent = TabFrame
            SliderFrame.BackgroundTransparency = 1
            SliderFrame.Size = UDim2.new(1, 0, 0, 50)

            SliderLabel.Name = "SliderLabel"
            SliderLabel.Parent = SliderFrame
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Size = UDim2.new(1, -50, 0, 20)
            SliderLabel.Font = Enum.Font.Gotham
            SliderLabel.Text = text
            SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderLabel.TextSize = 14
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

            SliderValue.Name = "SliderValue"
            SliderValue.Parent = SliderFrame
            SliderValue.BackgroundTransparency = 1
            SliderValue.Position = UDim2.new(1, -50, 0, 0)
            SliderValue.Size = UDim2.new(0, 50, 0, 20)
            SliderValue.Font = Enum.Font.Gotham
            SliderValue.Text = tostring(min)
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

            SliderFill.Name = "SliderFill"
            SliderFill.Parent = SliderTrack
            SliderFill.BackgroundColor3 = theme3
            SliderFill.BorderSizePixel = 0
            SliderFill.Size = UDim2.new(0, 0, 1, 0)

            SliderFillCorner.CornerRadius = UDim.new(0, 2)
            SliderFillCorner.Parent = SliderFill

            SliderThumb.Name = "SliderThumb"
            SliderThumb.Parent = SliderTrack
            SliderThumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderThumb.BorderSizePixel = 0
            SliderThumb.Position = UDim2.new(0, -8, 0.5, -8)
            SliderThumb.Size = UDim2.new(0, 16, 0, 16)

            SliderThumbCorner.CornerRadius = UDim.new(0, 8)
            SliderThumbCorner.Parent = SliderThumb

            SliderButton.Name = "SliderButton"
            SliderButton.Parent = SliderTrack
            SliderButton.BackgroundTransparency = 1
            SliderButton.Size = UDim2.new(1, 0, 1, 0)
            SliderButton.Text = ""

            local UserInputService = game:GetService("UserInputService")
            local TweenService = game:GetService("TweenService")
            local dragging = false
            local currentValue = min

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
        end

        function TabLibrary:CreateCheckbox(text, callback)
            callback = callback or function() end
            
            local CheckboxFrame = Instance.new("Frame")
            local CheckboxLabel = Instance.new("TextLabel")
            local CheckboxButton = Instance.new("TextButton")
            local CheckboxBack = Instance.new("Frame")
            local CheckboxBackCorner = Instance.new("UICorner")
            local CheckboxCheck = Instance.new("TextLabel")

            CheckboxFrame.Name = text .. "Checkbox"
            CheckboxFrame.Parent = TabFrame
            CheckboxFrame.BackgroundTransparency = 1
            CheckboxFrame.Size = UDim2.new(1, 0, 0, 35)

            CheckboxLabel.Name = "CheckboxLabel"
            CheckboxLabel.Parent = CheckboxFrame
            CheckboxLabel.BackgroundTransparency = 1
            CheckboxLabel.Size = UDim2.new(1, -30, 1, 0)
            CheckboxLabel.Font = Enum.Font.Gotham
            CheckboxLabel.Text = text
            CheckboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            CheckboxLabel.TextSize = 14
            CheckboxLabel.TextXAlignment = Enum.TextXAlignment.Left

            CheckboxButton.Name = "CheckboxButton"
            CheckboxButton.Parent = CheckboxFrame
            CheckboxButton.BackgroundTransparency = 1
            CheckboxButton.Position = UDim2.new(1, -20, 0.5, -10)
            CheckboxButton.Size = UDim2.new(0, 20, 0, 20)
            CheckboxButton.Text = ""

            CheckboxBack.Name = "CheckboxBack"
            CheckboxBack.Parent = CheckboxButton
            CheckboxBack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            CheckboxBack.BorderSizePixel = 0
            CheckboxBack.Size = UDim2.new(1, 0, 1, 0)

            CheckboxBackCorner.CornerRadius = UDim.new(0, 4)
            CheckboxBackCorner.Parent = CheckboxBack

            CheckboxCheck.Name = "CheckboxCheck"
            CheckboxCheck.Parent = CheckboxBack
            CheckboxCheck.BackgroundTransparency = 1
            CheckboxCheck.Size = UDim2.new(1, 0, 1, 0)
            CheckboxCheck.Font = Enum.Font.GothamBold
            CheckboxCheck.Text = ""
            CheckboxCheck.TextColor3 = Color3.fromRGB(255, 255, 255)
            CheckboxCheck.TextSize = 14

            local checked = false

            CheckboxButton.MouseButton1Click:Connect(function()
                checked = not checked
                CheckboxBack.BackgroundColor3 = checked and theme3 or Color3.fromRGB(60, 60, 60)
                CheckboxCheck.Text = checked and "✓" or ""
                callback(checked)
            end)
        end

        function TabLibrary:CreateDropdown(text, options, callback)
            callback = callback or function() end
            options = options or {}
            
            local DropdownFrame = Instance.new("Frame")
            local DropdownLabel = Instance.new("TextLabel")
            local DropdownButton = Instance.new("TextButton")
            local DropdownButtonCorner = Instance.new("UICorner")
            local DropdownArrow = Instance.new("TextLabel")
            local DropdownList = Instance.new("Frame")
            local DropdownListCorner = Instance.new("UICorner")
            local DropdownScroll = Instance.new("ScrollingFrame")
            local DropdownLayout = Instance.new("UIListLayout")

            DropdownFrame.Name = text .. "Dropdown"
            DropdownFrame.Parent = TabFrame
            DropdownFrame.BackgroundTransparency = 1
            DropdownFrame.Size = UDim2.new(1, 0, 0, 35)

            DropdownLabel.Name = "DropdownLabel"
            DropdownLabel.Parent = DropdownFrame
            DropdownLabel.BackgroundTransparency = 1
            DropdownLabel.Size = UDim2.new(1, -120, 1, 0)
            DropdownLabel.Font = Enum.Font.Gotham
            DropdownLabel.Text = text
            DropdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownLabel.TextSize = 14
            DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left

            DropdownButton.Name = "DropdownButton"
            DropdownButton.Parent = DropdownFrame
            DropdownButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            DropdownButton.BorderSizePixel = 0
            DropdownButton.Position = UDim2.new(1, -110, 0.5, -12)
            DropdownButton.Size = UDim2.new(0, 110, 0, 24)
            DropdownButton.Font = Enum.Font.Gotham
            DropdownButton.Text = "Select..."
            DropdownButton.TextColor3 = Color3.fromRGB(200, 200, 200)
            DropdownButton.TextSize = 12
            DropdownButton.TextXAlignment = Enum.TextXAlignment.Left

            DropdownButtonCorner.CornerRadius = UDim.new(0, 4)
            DropdownButtonCorner.Parent = DropdownButton

            DropdownArrow.Name = "DropdownArrow"
            DropdownArrow.Parent = DropdownButton
            DropdownArrow.BackgroundTransparency = 1
            DropdownArrow.Position = UDim2.new(1, -20, 0, 0)
            DropdownArrow.Size = UDim2.new(0, 20, 1, 0)
            DropdownArrow.Font = Enum.Font.Gotham
            DropdownArrow.Text = "▼"
            DropdownArrow.TextColor3 = Color3.fromRGB(200, 200, 200)
            DropdownArrow.TextSize = 10

            DropdownList.Name = "DropdownList"
            DropdownList.Parent = DropdownFrame
            DropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            DropdownList.BorderSizePixel = 0
            DropdownList.Position = UDim2.new(1, -110, 1, 5)
            DropdownList.Size = UDim2.new(0, 110, 0, math.min(#options * 25, 100))
            DropdownList.Visible = false
            DropdownList.ZIndex = 10

            DropdownListCorner.CornerRadius = UDim.new(0, 4)
            DropdownListCorner.Parent = DropdownList

            DropdownScroll.Name = "DropdownScroll"
            DropdownScroll.Parent = DropdownList
            DropdownScroll.BackgroundTransparency = 1
            DropdownScroll.BorderSizePixel = 0
            DropdownScroll.Size = UDim2.new(1, 0, 1, 0)
            DropdownScroll.ScrollBarThickness = 2
            DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, #options * 25)

            DropdownLayout.Parent = DropdownScroll
            DropdownLayout.SortOrder = Enum.SortOrder.LayoutOrder

            local isOpen = false

            DropdownButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                DropdownList.Visible = isOpen
                DropdownArrow.Text = isOpen and "▲" or "▼"
            end)

            for i, option in pairs(options) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Name = "Option" .. i
                OptionButton.Parent = DropdownScroll
                OptionButton.BackgroundTransparency = 1
                OptionButton.Size = UDim2.new(1, 0, 0, 25)
                OptionButton.Font = Enum.Font.Gotham
                OptionButton.Text = "  " .. option
                OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                OptionButton.TextSize = 12
                OptionButton.TextXAlignment = Enum.TextXAlignment.Left

                OptionButton.MouseButton1Click:Connect(function()
                    DropdownButton.Text = "  " .. option
                    DropdownList.Visible = false
                    isOpen = false
                    DropdownArrow.Text = "▼"
                    callback(option)
                end)

                OptionButton.MouseEnter:Connect(function()
                    OptionButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    OptionButton.BackgroundTransparency = 0
                end)

                OptionButton.MouseLeave:Connect(function()
                    OptionButton.BackgroundTransparency = 1
                end)
            end
        end

        function TabLibrary:Show()
            -- Hide all tabs
            for _, frame in pairs(tabFrames) do
                frame.Visible = false
            end
            
            -- Reset all tab colors
            for _, child in pairs(TabContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    child.TextColor3 = Color3.fromRGB(160, 160, 160)
                    child.BackgroundTransparency = 1
                end
            end
            
            -- Show this tab
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabButton.BackgroundTransparency = 0.9
            TabButton.BackgroundColor3 = theme3
            TabFrame.Visible = true
            currentTab = TabFrame
            HeaderTitle.Text = name .. " Settings"
        end

        -- Auto-select first tab if none selected
        if not currentTab then
            TabButton.MouseButton1Click()
        end

        return TabLibrary
    end

    return WindowLibrary
end

return library
