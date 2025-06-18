-- // Mobile-Friendly Roblox UI Library
-- // Enhanced for both PC and Mobile support

-- // variables
local library = {}
local pages = {}
local sections = {}
local multisections = {}
local mssections = {}
local toggles = {}
local buttons = {}
local sliders = {}
local dropdowns = {}
local multiboxs = {}
local buttonboxs = {}
local textboxs = {}
local keybinds = {}
local colorpickers = {}
local configloaders = {}
local watermarks = {}
local loaders = {}
--
local utility = {}
--
local check_exploit = (syn and "Synapse") or (KRNL_LOADED and "Krnl") or (isourclosure and "ScriptWare") or nil
local plrs = game:GetService("Players")
local cre = game:GetService("CoreGui")
local rs = game:GetService("RunService")
local ts = game:GetService("TweenService") 
local uis = game:GetService("UserInputService") 
local hs = game:GetService("HttpService")
local ws = game:GetService("Workspace")
local plr = plrs.LocalPlayer
local cam = ws.CurrentCamera

-- // Mobile detection
local isMobile = uis.TouchEnabled and not uis.KeyboardEnabled
local screenSize = cam.ViewportSize

-- // Mobile scaling factors
local mobileScale = isMobile and math.min(screenSize.X / 1920, screenSize.Y / 1080) or 1
local minScale = 0.7
local maxScale = 1.2
mobileScale = math.clamp(mobileScale, minScale, maxScale)

-- // indexes
library.__index = library
pages.__index = pages
sections.__index = sections
multisections.__index = multisections
mssections.__index = mssections
toggles.__index = toggles
buttons.__index = buttons
sliders.__index = sliders
dropdowns.__index = dropdowns
multiboxs.__index = multiboxs
buttonboxs.__index = buttonboxs
textboxs.__index = textboxs
keybinds.__index = keybinds
colorpickers.__index = colorpickers
configloaders.__index = configloaders
watermarks.__index = watermarks
loaders.__index = loaders

-- // utility functions
utility.new = function(instance,properties) 
	local ins = Instance.new(instance)
	for property,value in pairs(properties) do
		ins[property] = value
	end
	return ins
end

-- // Enhanced dragify function with mobile support
utility.dragify = function(ins,touse)
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		touse:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.1,true)
	end
	
	ins.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = touse.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	ins.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	uis.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

-- // Mobile-friendly input detection
utility.isValidInput = function(inputType)
	return inputType == Enum.UserInputType.MouseButton1 or 
		   inputType == Enum.UserInputType.Touch or
		   inputType == Enum.UserInputType.MouseMovement
end

-- // Get touch/mouse position
utility.getInputPosition = function()
	if isMobile then
		local touches = uis:GetTouchInputs()
		if #touches > 0 then
			return touches[1].Position
		end
	end
	return plr:GetMouse().Hit.Position
end

-- // Responsive sizing
utility.getResponsiveSize = function(baseSize)
	if isMobile then
		return UDim2.new(baseSize.X.Scale, baseSize.X.Offset * mobileScale, baseSize.Y.Scale, baseSize.Y.Offset * mobileScale)
	end
	return baseSize
end

-- // Mobile-friendly text size
utility.getResponsiveTextSize = function(baseSize)
	if isMobile then
		return math.max(10, baseSize * mobileScale)
	end
	return baseSize
end

utility.round = function(n,d)
	return tonumber(string.format("%."..(d or 0).."f",n))
end

utility.zigzag = function(X)
	return math.acos(math.cos(X*math.pi))/math.pi
end

utility.capatalize = function(s)
	local l = ""
	for v in s:gmatch('%u') do
		l = l..v
	end
	return l
end

utility.splitenum = function(enum)
	local s = tostring(enum):split(".")
	return s[#s]
end

utility.from_hex = function(h)
	local r,g,b = string.match(h,"^#?(%w%w)(%w%w)(%w%w)$")
	return Color3.fromRGB(tonumber(r,16), tonumber(g,16), tonumber(b,16))
end

utility.to_hex = function(c)
	return string.format("#%02X%02X%02X",c.R *255,c.G *255,c.B *255)
end

utility.removespaces = function(s)
   return s:gsub(" ","")
end

-- // main library function
function library:new(props)
	-- // properties with mobile-friendly defaults
	local textsize = utility.getResponsiveTextSize(props.textsize or props.TextSize or props.textSize or props.Textsize or 12)
	local font = props.font or props.Font or "RobotoMono"
	local name = props.name or props.Name or props.UiName or props.Uiname or props.uiName or props.username or props.Username or props.UserName or props.userName or "new ui"
	local color = props.color or props.Color or props.mainColor or props.maincolor or props.MainColor or props.Maincolor or props.Accent or props.accent or Color3.fromRGB(225, 58, 81)
	
	-- // variables
	local window = {}
	
	-- // Mobile-responsive window sizing
	local windowWidth = isMobile and math.min(screenSize.X * 0.95, 400) or 500
	local windowHeight = isMobile and math.min(screenSize.Y * 0.8, 500) or 606
	
	-- // main
	local screen = utility.new(
		"ScreenGui",
		{
			Name = tostring(math.random(0,999999))..tostring(math.random(0,999999)),
			DisplayOrder = 9999,
			ResetOnSpawn = false,
			ZIndexBehavior = "Global",
			Parent = cre
		}
	)
	
	if (check_exploit == "Synapse" and syn.request) then
		syn.protect_gui(screen)
	end
	
	-- 1
	local outline = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5,0.5),
			BackgroundColor3 = color,
			BorderColor3 = Color3.fromRGB(12, 12, 12),
			BorderSizePixel = 1,
			Size = UDim2.new(0,windowWidth,0,windowHeight),
			Position = UDim2.new(0.5,0,0.5,0),
			Parent = screen
		}
	)
	
	-- 2
	local outline2 = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5,0.5),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BorderColor3 = Color3.fromRGB(12, 12, 12),
			BorderSizePixel = 1,
			Size = UDim2.new(1,-4,1,-4),
			Position = UDim2.new(0.5,0,0.5,0),
			Parent = outline
		}
	)
	
	-- 3
	local indent = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5,0.5),
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			BorderColor3 = Color3.fromRGB(56, 56, 56),
			BorderMode = "Inset",
			BorderSizePixel = 1,
			Size = UDim2.new(1,0,1,0),
			Position = UDim2.new(0.5,0,0.5,0),
			Parent = outline2
		}
	)
	
	-- 4
	local main = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5,1),
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			BorderColor3 = Color3.fromRGB(56, 56, 56),
			BorderMode = "Inset",
			BorderSizePixel = 1,
			Size = UDim2.new(1,-10,1,-25),
			Position = UDim2.new(0.5,0,1,-5),
			Parent = outline2
		}
	)
	
	local title = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5,0),
			BackgroundTransparency = 1,
			Size = UDim2.new(1,0,0,isMobile and 25 or 20),
			Position = UDim2.new(0.5,0,0,0),
			Parent = outline2
		}
	)
	
	-- 5
	local outline3 = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5,0.5),
			BackgroundColor3 = Color3.fromRGB(24, 24, 24),
			BorderColor3 = Color3.fromRGB(12, 12, 12),
			BorderMode = "Inset",
			BorderSizePixel = 1,
			Size = UDim2.new(1,0,1,0),
			Position = UDim2.new(0.5,0,0.5,0),
			Parent = main
		}
	)
	
	local titletext = utility.new(
		"TextLabel",
		{
			AnchorPoint = Vector2.new(0.5,0),
			BackgroundTransparency = 1,
			Size = UDim2.new(1,-10,1,0),
			Position = UDim2.new(0.5,0,0,0),
			Font = font,
			Text = name,
			TextColor3 = Color3.fromRGB(255,255,255),
			TextXAlignment = "Left",
			TextSize = textsize,
			TextStrokeTransparency = 0,
			Parent = title
		}
	)
	
	-- 6
	local holder = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5,0.5),
			BackgroundTransparency = 1,
			Size = UDim2.new(1,-6,1,-6),
			Position = UDim2.new(0.5,0,0.5,0),
			Parent = main
		}
	)
	
	-- 8
	local tabs = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5,1),
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			BorderColor3 = Color3.fromRGB(12, 12, 12),
			BorderMode = "Inset",
			BorderSizePixel = 1,
			Size = UDim2.new(1,0,1,isMobile and -25 or -20),
			Position = UDim2.new(0.5,0,1,0),
			Parent = holder
		}
	)
	
	local tabsbuttons = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5,0),
			BackgroundTransparency = 1,
			Size = UDim2.new(1,0,0,isMobile and 25 or 21),
			Position = UDim2.new(0.5,0,0,0),
			ZIndex = 2,
			Parent = holder
		}
	)
	
	-- 9
	local outline4 = utility.new(
		"Frame",
		{
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			BorderColor3 = Color3.fromRGB(56, 56, 56),
			BorderMode = "Inset",
			BorderSizePixel = 1,
			Size = UDim2.new(1,0,1,0),
			Position = UDim2.new(0,0,0,0),
			Parent = tabs
		}
	)
	
	utility.new(
		"UIListLayout",
		{
			FillDirection = "Horizontal",
			Padding = UDim.new(0,2),
			Parent = tabsbuttons
		}
	)
	
	utility.dragify(title,outline)
	
	-- // window tbl
	window = {
		["screen"] = screen,
		["holder"] = holder,
		["labels"] = {},
		["tabs"] = outline4,
		["tabsbuttons"] = tabsbuttons,
		["outline"] = outline,
		["pages"] = {},
		["pointers"] = {},
		["dropdowns"] = {},
		["multiboxes"] = {},
		["buttonboxs"] = {},
		["colorpickers"] = {},
		["x"] = true,
		["y"] = true,
		["key"] = Enum.KeyCode.RightShift,
		["textsize"] = textsize,
		["font"] = font,
		["theme"] = {
			["accent"] = color
		},
		["themeitems"] = {
			["accent"] = {
				["BackgroundColor3"] = {},
				["BorderColor3"] = {},
				["TextColor3"] = {}
			}
		}
	}
	
	table.insert(window.themeitems["accent"]["BackgroundColor3"],outline)
	
	local toggled = true
	local cooldown = false
	local saved = UDim2.new(0,0,0,0)
	
	-- Enhanced input handling for mobile
	uis.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.Keyboard then
			if Input.KeyCode == window.key then
				if cooldown == false then
					if toggled then
						cooldown = true
						toggled = not toggled
						saved = outline.Position
						local xx,yy = 0,0
						local xxx,yyy = 0,0
						
						if (outline.AbsolutePosition.X+(outline.AbsoluteSize.X/2)) < (cam.ViewportSize.X/2) then
							xx = -3
						else
							xx = 3
						end
						
						if window.y then
							if (outline.AbsolutePosition.Y+(outline.AbsoluteSize.Y/2)) < (cam.ViewportSize.Y/2) then
								yy = -3
							else
								yy = 3
							end
						else
							yy = saved.Y.Scale
							yyy = saved.Y.Offset
						end
						
						if window.x == false and window.y == false then
							screen.Enabled = false
						else
							ts:Create(outline, TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.In), {Position = UDim2.new(xx,xxx,yy,yyy)}):Play()
						end
						wait(0.5)
						cooldown = false
					else
						cooldown = true
						toggled = not toggled
						if window.x == false and window.y == false then
							screen.Enabled = true
						else
							ts:Create(outline, TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {Position = saved}):Play()
						end
						wait(0.5)
						cooldown = false
					end
				end
			end
		end
	end)
	
	window.labels[#window.labels+1] = titletext
	setmetatable(window, library)
	return window
end

-- // Enhanced watermark with mobile support
function library:watermark()
	local watermark = {}
	
	local outline = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(1,0),
			BackgroundColor3 = self.theme.accent,
			BorderColor3 = Color3.fromRGB(12, 12, 12),
			BorderSizePixel = 1,
			Size = UDim2.new(0,isMobile and 250 or 300,0,isMobile and 30 or 26),
			Position = UDim2.new(1,-10,0,10),
			ZIndex = 9900,
			Visible = false,
			Parent = self.screen
		}
	)
	
	table.insert(self.themeitems["accent"]["BackgroundColor3"],outline)
	
	local outline2 = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5,0.5),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BorderColor3 = Color3.fromRGB(12, 12, 12),
			BorderSizePixel = 1,
			Size = UDim2.new(1,-4,1,-4),
			Position = UDim2.new(0.5,0,0.5,0),
			ZIndex = 9901,
			Parent = outline
		}
	)
	
	local indent = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5,0.5),
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			BorderColor3 = Color3.fromRGB(56, 56, 56),
			BorderSizePixel = 1,
			Size = UDim2.new(1,0,1,0),
			Position = UDim2.new(0.5,0,0.5,0),
			ZIndex = 9902,
			Parent = outline2
		}
	)
	
	local title = utility.new(
		"TextLabel",
		{
			AnchorPoint = Vector2.new(0.5,0),
			BackgroundTransparency = 1,
			Size = UDim2.new(1,-10,1,0),
			Position = UDim2.new(0.5,0,0,0),
			Font = self.font,
			Text = "",
			TextColor3 = Color3.fromRGB(255,255,255),
			TextXAlignment = "Left",
			TextSize = self.textsize,
			TextStrokeTransparency = 0,
			ZIndex = 9903,
			Parent = indent
		}
	)
	
	local con
	con = title:GetPropertyChangedSignal("TextBounds"):Connect(function()
		outline.Size = UDim2.new(0,title.TextBounds.X+20,0,isMobile and 30 or 26)
	end)
	
	watermark = {
		["outline"] = outline,
		["outline2"] = outline2,
		["indent"] = indent,
		["title"] = title,
		["connection"] = con
	}
	
	self.labels[#self.labels+1] = title
	setmetatable(watermark,watermarks)
	return watermark
end

function watermarks:update(content)
	local content = content or {}
	local watermark = self
	
	local text = ""
	
	for i,v in pairs(content) do
		text = text..i..": "..v.."  "
	end
	
	text = text:sub(0, -3)
	watermark.title.Text = text
end

function watermarks:updateside(side)
	side = utility.removespaces(tostring(side):lower())
	
	local sides = {
		topright = {
			AnchorPoint = Vector2.new(1,0),
			Position = UDim2.new(1,-10,0,10)
		},
		topleft = {
			AnchorPoint = Vector2.new(0,0),
			Position = UDim2.new(0,10,0,10)
		},
		bottomright = {
			AnchorPoint = Vector2.new(1,1),
			Position = UDim2.new(1,-10,1,-10)
		},
		bottomleft = {
			AnchorPoint = Vector2.new(0,1),
			Position = UDim2.new(0,10,1,-10)
		}
	}
	
	if sides[side] then
		self.outline.AnchorPoint = sides[side].AnchorPoint
		self.outline.Position = sides[side].Position
	end
end

function watermarks:toggle(bool)
	local watermark = self
	watermark.outline.Visible = bool
end

-- // Enhanced loader with mobile support
function library:loader(props)
	local name = props.name or props.Name or props.LoaderName or props.Loadername or props.loaderName or props.loadername or "Loader"
	local scriptname = props.scriptname or props.Scriptname or props.ScriptName or props.scriptName or "Universal"
	local closed = props.close or props.Close or props.closecallback or props.Closecallback or props.CloseCallback or props.closeCallback or function()end
	local logedin = props.login or props.Login or props.logincallback or props.Logincallback or props.LoginCallback or props.loginCallback or function()end
	local loader = {}
	
	local screen = utility.new(
		"ScreenGui",
		{
			Name = tostring(math.random(0,999999))..tostring(math.random(0,999999)),
			DisplayOrder = 9999,
			ResetOnSpawn = false,
			ZIndexBehavior = "Global",
			Parent = cre
		}
	)
	
	if (check_exploit == "Synapse" and syn.request) then
		syn.protect_gui(screen)
	end
	
	local loaderWidth = isMobile and math.min(screenSize.X * 0.8, 350) or 300
	local loaderHeight = isMobile and 110 or 90
	
	local outline = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5,0.5),
			BackgroundColor3 = Color3.fromRGB(168, 52, 235),
			BorderColor3 = Color3.fromRGB(12, 12, 12),
			BorderSizePixel = 1,
			Size = UDim2.new(0,loaderWidth,0,loaderHeight),
			Position = UDim2.new(0.5,0,0.5,0),
			ZIndex = 9900,
			Visible = false,
			Parent = screen
		}
	)
	
	local outline2 = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5,0.5),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BorderColor3 = Color3.fromRGB(12, 12, 12),
			BorderSizePixel = 1,
			Size = UDim2.new(1,-4,1,-4),
			Position = UDim2.new(0.5,0,0.5,0),
			ZIndex = 9901,
			Parent = outline
		}
	)
	
	local indent = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5,0.5),
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			BorderColor3 = Color3.fromRGB(56, 56, 56),
			BorderSizePixel = 1,
			Size = UDim2.new(1,0,1,0),
			Position = UDim2.new(0.5,0,0.5,0),
			ZIndex = 9902,
			Parent = outline2
		}
	)
	
	local title = utility.new(
		"TextLabel",
		{
			AnchorPoint = Vector2.new(0.5,0),
			BackgroundTransparency = 1,
			Size = UDim2.new(1,-10,0,20),
			Position = UDim2.new(0.5,0,0,0),
			Font = "RobotoMono",
			Text = name,
			TextColor3 = Color3.fromRGB(168, 52, 235),
			TextXAlignment = "Center",
			TextSize = utility.getResponsiveTextSize(12),
			TextStrokeTransparency = 0,
			ZIndex = 9903,
			Parent = indent
		}
	)
	
	local scripttitle = utility.new(
		"TextLabel",
		{
			AnchorPoint = Vector2.new(0.5,0),
			BackgroundTransparency = 1,
			Size = UDim2.new(1,-10,0,20),
			Position = UDim2.new(0.5,0,0,20),
			Font = "RobotoMono",
			Text = "Script: "..scriptname,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextXAlignment = "Center",
			TextSize = utility.getResponsiveTextSize(12),
			TextStrokeTransparency = 0,
			ZIndex = 9903,
			Parent = indent
		}
	)
	
	local makebutton = function(name,parent)
		local button_holder = utility.new(
			"Frame",
			{
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ZIndex = 9904,
				Parent = parent
			}
		)
		
		local button_outline = utility.new(
			"Frame",
			{
				BackgroundColor3 = Color3.fromRGB(24, 24, 24),
				BorderColor3 = Color3.fromRGB(12, 12, 12),
				BorderMode = "Inset",
				BorderSizePixel = 1,
				Position = UDim2.new(0,0,0,0),
				Size = UDim2.new(1,0,1,0),
				ZIndex = 9905,
				Parent = button_holder
			}
		)
		
		local button_outline2 = utility.new(
			"Frame",
			{
				BackgroundColor3 = Color3.fromRGB(24, 24, 24),
				BorderColor3 = Color3.fromRGB(56, 56, 56),
				BorderMode = "Inset",
				BorderSizePixel = 1,
				Position = UDim2.new(0,0,0,0),
				Size = UDim2.new(1,0,1,0),
				ZIndex = 9906,
				Parent = button_outline
			}
		)
		
		local button_color = utility.new(
			"Frame",
			{
				AnchorPoint = Vector2.new(0,0),
				BackgroundColor3 = Color3.fromRGB(30, 30, 30),
				BorderSizePixel = 0,
				Size = UDim2.new(1,0,0,0),
				Position = UDim2.new(0,0,0,0),
				ZIndex = 9907,
				Parent = button_outline2
			}
		)
		
		utility.new(
			"UIGradient",
			{
				Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(199, 191, 204)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))},
				Rotation = 90,
				Parent = button_color
			}
		)
		
		local button_button = utility.new(
			"TextButton",
			{
				AnchorPoint = Vector2.new(0,0),
				BackgroundTransparency = 1,
				Size = UDim2.new(1,0,1,0),
				Position = UDim2.new(0,0,0,0),
				Text = name,
				TextColor3 = Color3.fromRGB(255,255,255),
				TextSize = utility.getResponsiveTextSize(12),
				TextStrokeTransparency = 0,
				Font = "RobotoMono",
				ZIndex = 9908,
				Parent = button_holder
			}
		)
		
		return {button_holder,button_outline,button_button}
	end
	
	local close = makebutton("close",indent)
	local login = makebutton("login",indent)
	
	local buttonHeight = isMobile and 25 or 20
	local buttonY1 = isMobile and 45 : 40
	local buttonY2 = isMobile and 72 or 62
	
	close[1].AnchorPoint = Vector2.new(0.5,0)
	close[1].Size = UDim2.new(0.5,0,0,buttonHeight)
	close[1].Position = UDim2.new(0.5,0,0,buttonY1)
	
	login[1].AnchorPoint = Vector2.new(0.5,0)
	login[1].Size = UDim2.new(0.5,0,0,buttonHeight)
	login[1].Position = UDim2.new(0.5,0,0,buttonY2)
	
	-- Enhanced button interactions for mobile
	close[3].MouseButton1Down:Connect(function()
		close[2].BorderColor3 = Color3.fromRGB(168, 52, 235)
		outline:TweenPosition(UDim2.new(-1.5,0,0.5,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.75,true)
		closed()
		wait(0.05)
		close[2].BorderColor3 = Color3.fromRGB(12,12,12)
		wait(0.7)
		screen:Remove()
	end)
	
	-- Add touch support for close button
	close[3].TouchTap:Connect(function()
		close[2].BorderColor3 = Color3.fromRGB(168, 52, 235)
		outline:TweenPosition(UDim2.new(-1.5,0,0.5,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.75,true)
		closed()
		wait(0.05)
		close[2].BorderColor3 = Color3.fromRGB(12,12,12)
		wait(0.7)
		screen:Remove()
	end)
	
	login[3].MouseButton1Down:Connect(function()
		login[2].BorderColor3 = Color3.fromRGB(168, 52, 235)
		outline:TweenPosition(UDim2.new(1.5,0,0.5,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.75,true)
		logedin()
		wait(0.05)
		login[2].BorderColor3 = Color3.fromRGB(12,12,12)
		wait(0.7)
		screen:Remove()
	end)
	
	-- Add touch support for login button
	login[3].TouchTap:Connect(function()
		login[2].BorderColor3 = Color3.fromRGB(168, 52, 235)
		outline:TweenPosition(UDim2.new(1.5,0,0.5,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.75,true)
		logedin()
		wait(0.05)
		login[2].BorderColor3 = Color3.fromRGB(12,12,12)
		wait(0.7)
		screen:Remove()
	end)
	
	loader = {
		["outline"] = outline,
		["outline2"] = outline2,
		["indent"] = indent,
		["title"] = title
	}
	
	setmetatable(loader,loaders)
	return loader
end

function loaders:toggle()
	self.outline.Visible = true
end

-- // Config management functions
function library:saveconfig()
	local cfg = {}
	
	for i,v in pairs(self.pointers) do
		cfg[i] = {}
		for c,d in pairs(v) do
			cfg[i][c] = {}
			for x,z in pairs(d) do
				if typeof(z.current) == "Color3" then
					cfg[i][c][x] = {z.current.R,z.current.G,z.current.B}
				else
					cfg[i][c][x] = z.current
				end
			end
		end
	end
	
	return hs:JSONEncode(cfg)
end

function library:loadconfig(cfg)
	local cfg = hs:JSONDecode(readfile(cfg))
	for i,v in pairs(cfg) do
		for c,d in pairs(v) do
			for x,z in pairs(d) do
				if z ~= nil then
					if self.pointers[i] ~= nil and self.pointers[i][c] ~= nil and self.pointers[i][c][x] ~= nil then
						self.pointers[i][c][x]:set(z)
					end
				end
			end
		end
	end
end

function library:settheme(theme,color)
	local window = self
	
	if window.theme[theme] then
		window.theme[theme] = color
	end
	
	if window.themeitems[theme] then
		for i,v in pairs(window.themeitems[theme]) do
			for z,x in pairs(v) do
				x[i] = color
			end
		end
	end
end

function library:setkey(key)
	if typeof(key) == "EnumItem" then
		local window = self
		window.key = key
	end
end

function library:settoggle(side,bool)
	if side == "x" then
		self.x = bool
	else
		self.y = bool
	end
end

function library:setfont(font)
	if font ~= nil then
		local window = self
		for i,v in pairs(window.labels) do
			if v ~= nil then
				v.Font = font
			end
		end
	end
end

function library:settextsize(size)
	if size ~= nil then
		local window = self
		for i,v in pairs(window.labels) do
			if v ~= nil then
				v.TextSize = utility.getResponsiveTextSize(size)
			end
		end
	end
end

-- // Enhanced page creation with mobile support
function library:page(props)
	local name = props.name or props.Name or props.page or props.Page or props.pagename or props.Pagename or props.PageName or props.pageName or "new ui"
	local page = {}
	
	local tabWidth = isMobile and 85 or 75
	
	local tabbutton = utility.new(
		"Frame",
		{
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			BorderColor3 = Color3.fromRGB(12, 12, 12),
			BorderMode = "Inset",
			BorderSizePixel = 1,
			Size = UDim2.new(0,tabWidth,1,0),
			Parent = self.tabsbuttons
		}
	)
	
	local outline = utility.new(
		"Frame",
		{
			BackgroundColor3 = Color3.fromRGB(24, 24, 24),
			BorderColor3 = Color3.fromRGB(56, 56, 56),
			BorderMode = "Inset",
			BorderSizePixel = 1,
			Size = UDim2.new(1,0,1,0),
			Position = UDim2.new(0,0,0,0),
			Parent = tabbutton
		}
	)
	
	local button = utility.new(
		"TextButton",
		{
			AnchorPoint = Vector2.new(0,0),
			BackgroundTransparency = 1,
			Size = UDim2.new(1,0,1,0),
			Position = UDim2.new(0,0,0,0),
			Text = "",
			Parent = tabbutton
		}
	)
	
	local r_line = utility.new(
		"Frame",
		{
			BackgroundColor3 = Color3.fromRGB(56, 56, 56),
			BorderSizePixel = 0,
			Size = UDim2.new(0,1,0,1),
			Position = UDim2.new(1,0,1,1),
			ZIndex = 2,
			Parent = outline
		}
	)
	
	local l_line = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(1,0),
			BackgroundColor3 = Color3.fromRGB(56, 56, 56),
			BorderSizePixel = 0,
			Size = UDim2.new(0,1,0,1),
			Position = UDim2.new(0,0,1,1),
			ZIndex = 2,
			Parent = outline
		}
	)
	
	local line = utility.new(
		"Frame",
		{
			BackgroundColor3 = Color3.fromRGB(24, 24, 24),
			BorderSizePixel = 0,
			Size = UDim2.new(1,0,0,2),
			Position = UDim2.new(0,0,1,0),
			ZIndex = 2,
			Parent = outline
		}
	)
	
	local label = utility.new(
		"TextLabel",
		{
			BackgroundTransparency = 1,
			Size = UDim2.new(1,0,0,20),
			Position = UDim2.new(0,0,0,0),
			Font = self.font,
			Text = name,
			TextColor3 = Color3.fromRGB(255,255,255),
			TextSize = self.textsize,
			TextStrokeTransparency = 0,
			Parent = outline
		}
	)
	
	local pageholder = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5,0.5),
			BackgroundTransparency = 1,
			Size = UDim2.new(1,-20,1,-20),
			Position = UDim2.new(0.5,0,0.5,0),
			Visible = false,
			Parent = self.tabs
		}
	)
	
	-- Mobile-responsive layout
	local leftWidth = isMobile and 1 or 0.5
	local rightWidth = isMobile and 1 or 0.5
	local leftPos = isMobile and UDim2.new(0,0,0,0) or UDim2.new(0,0,0,0)
	local rightPos = isMobile and UDim2.new(0,0,0.5,5) or UDim2.new(1,0,0,0)
	local rightAnchor = isMobile and Vector2.new(0,0) or Vector2.new(1,0)
	
	local left = utility.new(
		"ScrollingFrame",
		{
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(leftWidth,isMobile and 0 or -5,isMobile and 0.5 or 1,-5),
			Position = leftPos,
			AutomaticCanvasSize = "Y",
			CanvasSize = UDim2.new(0,0,0,0),
			ScrollBarImageTransparency = 1,
			ScrollBarImageColor3 = Color3.fromRGB(0,0,0),
			ScrollBarThickness = 0,
			ClipsDescendants = false,
			VerticalScrollBarInset = "None",
			VerticalScrollBarPosition = "Right",
			Parent = pageholder
		}
	)
	
	utility.new(
		"UIListLayout",
		{
			FillDirection = "Vertical",
			Padding = UDim.new(0,10),
			Parent = left
		}
	)
	
	local right = utility.new(
		"ScrollingFrame",
		{
			AnchorPoint = rightAnchor,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(rightWidth,isMobile and 0 or -5,isMobile and 0.5 or 1,-5),
			Position = rightPos,
			AutomaticCanvasSize = "Y",
			CanvasSize = UDim2.new(0,0,0,0),
			ScrollBarImageTransparency = 1,
			ScrollBarImageColor3 = Color3.fromRGB(0,0,0),
			ScrollBarThickness = 0,
			ClipsDescendants = false,
			VerticalScrollBarInset = "None",
			VerticalScrollBarPosition = "Right",
			Parent = pageholder
		}
	)
	
	utility.new(
		"UIListLayout",
		{
			FillDirection = "Vertical",
			Padding = UDim.new(0,10),
			Parent = right
		}
	)
	
	page = {
		["library"] = self,
		["outline"] = outline,
		["r_line"] = r_line,
		["l_line"] = l_line,
		["line"] = line,
		["page"] = pageholder,
		["left"] = left,
		["right"] = right,
		["open"] = false,
		["pointers"] = {}
	}
	
	table.insert(self.pages,page)
	
	-- Enhanced button interaction with touch support
	button.MouseButton1Down:Connect(function()
		if page.open == false then
			for i,v in pairs(self.pages) do
				if v ~= page then
					if v.open then
						v.page.Visible = false
						v.open = false
						v.outline.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
						v.line.Size = UDim2.new(1,0,0,2)
						v.line.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
					end
				end
			end
			
			self:closewindows()
			
			page.page.Visible = true
			page.open = true
			page.outline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			page.line.Size = UDim2.new(1,0,0,3)
			page.line.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		end
	end)
	
	-- Add touch support
	button.TouchTap:Connect(function()
		if page.open == false then
			for i,v in pairs(self.pages) do
				if v ~= page then
					if v.open then
						v.page.Visible = false
						v.open = false
						v.outline.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
						v.line.Size = UDim2.new(1,0,0,2)
						v.line.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
					end
				end
			end
			
			self:closewindows()
			
			page.page.Visible = true
			page.open = true
			page.outline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			page.line.Size = UDim2.new(1,0,0,3)
			page.line.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		end
	end)
	
	local pointer = props.pointer or props.Pointer or props.pointername or props.Pointername or props.PointerName or props.pointerName or nil
	
	if pointer then
		self.pointers[tostring(pointer)] = page.pointers
	end
	
	self.labels[#self.labels+1] = label
	setmetatable(page, pages)
	return page
end

function pages:openpage()
	local page = self
	
	if page.open == false then
		for i,v in pairs(page.library.pages) do
			if v ~= page then
				if v.open then
					v.page.Visible = false
					v.open = false
					v.outline.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
					v.line.Size = UDim2.new(1,0,0,2)
					v.line.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
				end
			end
		end
		
		page.page.Visible = true
		page.open = true
		page.outline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		page.line.Size = UDim2.new(1,0,0,3)
		page.line.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	end
end

-- // Enhanced section creation with mobile support
function pages:section(props)
	local name = props.name or props.Name or props.page or props.Page or props.pagename or props.Pagename or props.PageName or props.pageName or "new ui"
	local side = props.side or props.Side or props.sectionside or props.Sectionside or props.SectionSide or props.sectionSide or "left"
	local size = props.size or props.Size or props.yaxis or props.yAxis or props.YAxis or props.Yaxis or (isMobile and 180 or 200)
	side = side:lower()
	
	local section = {}
	
	local sectionholder = utility.new(
		"Frame",
		{
			BackgroundColor3 = Color3.fromRGB(24, 24, 24),
			BorderColor3 = Color3.fromRGB(56, 56, 56),
			BorderMode = "Inset",
			BorderSizePixel = 1,
			Size = UDim2.new(1,0,0,size),
			Parent = self[side]
		}
	)
	
	local outline = utility.new(
		"Frame",
		{
			BackgroundColor3 = Color3.fromRGB(24, 24, 24),
			BorderColor3 = Color3.fromRGB(12, 12, 12),
			BorderMode = "Inset",
			BorderSizePixel = 1,
			Size = UDim2.new(1,0,1,0),
			Parent = sectionholder
		}
	)
	
	local color = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5,0),
			BackgroundColor3 = self.library.theme.accent,
			BorderSizePixel = 0,
			Size = UDim2.new(1,-2,0,1),
			Position = UDim2.new(0.5,0,0,0),
			Parent = outline
		}
	)
	
	table.insert(self.library.themeitems["accent"]["BackgroundColor3"],color)
	
	local content = utility.new(
		"Frame",
		{
			AnchorPoint = Vector2.new(0.5,1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1,-12,1,isMobile and -30 or -25),
			Position = UDim2.new(0.5,0,1,-5),
			Parent = outline
		}
	)
	
	local title = utility.new(
		"TextLabel",
		{
			BackgroundTransparency = 1,
			Size = UDim2.new(1,-5,0,isMobile and 25 or 20),
			Position = UDim2.new(0,5,0,0),
			Font = self.library.font,
			Text = name,
			TextColor3 = Color3.fromRGB(255,255,255),
			TextSize = self.library.textsize,
			TextStrokeTransparency = 0,
			TextXAlignment = "Left",
			Parent = outline
		}
	)
	
	utility.new(
		"UIListLayout",
		{
			FillDirection = "Vertical",
			Padding = UDim.new(0,isMobile and 7 or 5),
			Parent = content
		}
	)
	
	section = {
		["library"] = self.library,
		["sectionholder"] = sectionholder,
		["color"] = color,
		["content"] = content,
		["pointers"] = {}
	}
	
	local pointer = props.pointer or props.Pointer or props.pointername or props.Pointername or props.PointerName or props.pointerName or nil
	
	if pointer then
		if self.pointers then
			self.pointers[tostring(pointer)] = section.pointers
		end
	end
	
	self.library.labels[#self.library.labels+1] = title
	setmetatable(section, sections)
	return section
end

-- // Enhanced toggle with mobile support
function sections:toggle(props)
	local name = props.name or props.Name or props.page or props.Page or props.pagename or props.Pagename or props.PageName or props.pageName or "new ui"
	local def = props.def or props.Def or props.default or props.Default or props.toggle or props.Toggle or props.toggled or props.Toggled or false
	local callback = props.callback or props.callBack or props.CallBack or props.Callback or function()end
	
	local toggle = {}
	
	local toggleHeight = isMobile and 18 or 15
	local toggleSize = isMobile and 18 or 15
	
	local toggleholder = utility.new(
		"Frame",
		{
			BackgroundTransparency = 1,
			Size = UDim2.new(1,0,0,toggleHeight),
			Parent = self.content
		}
	)
	
	local outline = utility.new(
		"Frame",
		{
			BackgroundColor3 = Color3.fromRGB(24, 24, 24),
			BorderColor3 = Color3.fromRGB(12, 12, 12),
			BorderMode = "Inset",
			BorderSizePixel = 1,
			Size = UDim2.new(0,toggleSize,0,toggleSize),
			Parent = toggleholder
		}
	)
	
	local button = utility.new(
		"TextButton",
		{
			AnchorPoint = Vector2.new(0,0),
			BackgroundTransparency = 1,
			Size = UDim2.new(1,0,1,0),
			Position = UDim2.new(0,0,0,0),
			Text = "",
			Parent = toggleholder
		}
	)
	
	local title = utility.new(
		"TextLabel",
		{
			BackgroundTransparency = 1,
			Size = UDim2.new(1,-25,1,0),
			Position = UDim2.new(0,25,0,0),
			Font = self.library.font,
			Text = name,
			TextColor3 = Color3.fromRGB(255,255,255),
			TextSize = self.library.textsize,
			TextStrokeTransparency = 0,
			TextXAlignment = "Left",
			Parent = toggleholder
		}
	)
	
	local col = Color3.fromRGB(20, 20, 20)
	if def then
		col = self.library.theme.accent
	end
	
	local color = utility.new(
		"Frame",
		{
			BackgroundColor3 = col,
			BorderColor3 = Color3.fromRGB(56, 56, 56),
			BorderMode = "Inset",
			BorderSizePixel = 1,
			Size = UDim2.new(1,0,1,0),
			Parent = outline
		}
	)
	
	if def then
		table.insert(self.library.themeitems["accent"]["BackgroundColor3"],color)
	end
	
	utility.new(
		"UIGradient",
		{
			Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(199, 191, 204)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))},
			Rotation = 90,
			Parent = color
		}
	)
	
	toggle = {
		["library"] = self.library,
		["toggleholder"] = toggleholder,
		["title"] = title,
		["color"] = color,
		["callback"] = callback,
		["current"] = def
	}
	
	-- Enhanced button interaction with touch support
	button.MouseButton1Down:Connect(function()
		if toggle.current then
			toggle.callback(false)
			toggle.color.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			local find = table.find(self.library.themeitems["accent"]["BackgroundColor3"],toggle.color)
			if find then
				table.remove(self.library.themeitems["accent"]["BackgroundColor3"],find)
			end
			toggle.current = false
		else
			toggle.callback(true)
			toggle.color.BackgroundColor3 = self.library.theme.accent
			table.insert(self.library.themeitems["accent"]["BackgroundColor3"],toggle.color)
			toggle.current = true
		end
	end)
	
	-- Add touch support
	button.TouchTap:Connect(function()
		if toggle.current then
			toggle.callback(false)
			toggle.color.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			local find = table.find(self.library.themeitems["accent"]["BackgroundColor3"],toggle.color)
			if find then
				table.remove(self.library.themeitems["accent"]["BackgroundColor3"],find)
			end
			toggle.current = false
		else
			toggle.callback(true)
			toggle.color.BackgroundColor3 = self.library.theme.accent
			table.insert(self.library.themeitems["accent"]["BackgroundColor3"],toggle.color)
			toggle.current = true
		end
	end)
	
	local pointer = props.pointer or props.Pointer or props.pointername or props.Pointername or props.PointerName or props.pointerName or nil
	
	if pointer then
		if self.pointers then
			self.pointers[tostring(pointer)] = toggle
		end
	end
	
	self.library.labels[#self.library.labels+1] = title
	setmetatable(toggle, toggles)
	return toggle
end

function toggles:set(bool)
	if bool ~= nil then
		local toggle = self
		toggle.callback(bool)
		toggle.current = bool
		if bool then
			toggle.color.BackgroundColor3 = self.library.theme.accent
			table.insert(self.library.themeitems["accent"]["BackgroundColor3"],toggle.color)
		else
			toggle.color.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			local find = table.find(self.library.themeitems["accent"]["BackgroundColor3"],toggle.color)
			if find then
				table.remove(self.library.themeitems["accent"]["BackgroundColor3"],find)
			end
		end
	end
end

-- // Enhanced button with mobile support
function sections:button(props)
	local name = props.name or props.Name or "new button"
	local callback = props.callback or props.callBack or props.CallBack or props.Callback or function()end
	
	local button = {}
	local buttonHeight = isMobile and 25 or 20
	
	local buttonholder = utility.new(
		"Frame",
		{
			BackgroundTransparency = 1,
			Size = UDim2.new(1,0,0,buttonHeight),
			Parent = self.content
		}
	)
	
	local outline = utility.new(
		"Frame",
		{
			BackgroundColor3 = Color3.fromRGB(24, 24, 24),
			BorderColor3 = Color3.fromRGB(12, 12, 12),
			BorderMode = "Inset",
			BorderSizePixel = 1,
			Size = UDim2.new(1,0,1,0),
			Parent = buttonholder
		}
	)
	
	local outline2 = utility.new(
		"Frame",
		{
			BackgroundColor3 = Color3.fromRGB(24, 24, 24),
			BorderColor3 = Color3.fromRGB(56, 56, 56),
			BorderMode = "Inset",
			BorderSizePixel = 1,
			Size = UDim2.new(1,0,1,0),
			Parent = outline
		}
	)
	
	local color = utility.new(
		"Frame",
		{
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BorderSizePixel = 0,
			Size = UDim2.new(1,0,1,0),
			Parent = outline2
		}
	)
	
	local gradient = utility.new(
		"UIGradient",
		{
			Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(199, 191, 204)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))},
			Rotation = 90,
			Parent = color
		}
	)
	
	local buttonpress = utility.new(
		"TextButton",
		{
			AnchorPoint = Vector2.new(0,0),
			BackgroundTransparency = 1,
			Size = UDim2.new(1,0,1,0),
			Position = UDim2.new(0,0,0,0),
			Text = name,
			TextColor3 = Color3.fromRGB(255,255,255),
			TextSize = self.library.textsize,
			TextStrokeTransparency = 0,
			Font = self.library.font,
			Parent = buttonholder
		}
	)
	
	-- Enhanced button interaction with touch support
	buttonpress.MouseButton1Down:Connect(function()
		callback()
		outline.BorderColor3 = self.library.theme.accent
		table.insert(self.library.themeitems["accent"]["BorderColor3"],outline)
		wait(0.05)
		outline.BorderColor3 = Color3.fromRGB(12, 12, 12)
		local find = table.find(self.library.themeitems["accent"]["BorderColor3"],outline)
		if find then
			table.remove(self.library.themeitems["accent"]["BorderColor3"],find)
		end
	end)
	
	-- Add touch support
	buttonpress.TouchTap:Connect(function()
		callback()
		outline.BorderColor3 = self.library.theme.accent
		table.insert(self.library.themeitems["accent"]["BorderColor3"],outline)
		wait(0.05)
		outline.BorderColor3 = Color3.fromRGB(12, 12, 12)
		local find = table.find(self.library.themeitems["accent"]["BorderColor3"],outline)
		if find then
			table.remove(self.library.themeitems["accent"]["BorderColor3"],find)
		end
	end)
	
	button = {
		["library"] = self.library
	}
	
	self.library.labels[#self.library.labels+1] = buttonpress
	setmetatable(button, buttons)
	return button
end

-- // Enhanced slider with mobile support
function sections:slider(props)
	local name = props.name or props.Name or props.page or props.Page or props.pagename or props.Pagename or props.PageName or props.pageName or "new ui"
	local def = props.def or props.Def or props.default or props.Default or 0
	local max = props.max or props.Max or props.maximum or props.Maximum or 100
	local min = props.min or props.Min or props.minimum or props.Minimum or 0
	local rounding = props.rounding or props.Rounding or props.round or props.Round or props.decimals or props.Decimals or false
	local ticking = props.tick or props.Tick or props.ticking or props.Ticking or false
	local measurement = props.measurement or props.Measurement or props.digit or props.Digit or props.calc or props.Calc or ""
	local callback = props.callback or props.callBack or props.CallBack or props.Callback or function()end
	def = math.clamp(def,min,max)
	
	local slider = {}
	local sliderHeight = isMobile and 30 or 25
	
	local sliderholder = utility.new(
		"Frame",
		{
			BackgroundTransparency = 1,
			Size = UDim2.new(1,0,0,sliderHeight),
			Parent = self.content
		}
	)
	
	local outline = utility.new(
		"Frame",
		{
			BackgroundColor3 = Color3.fromRGB(24, 24, 24),
			BorderColor3 = Color3.fromRGB(12, 12, 12),
			BorderMode = "Inset",
			BorderSizePixel = 1,
			Size = UDim2.new(1,0,0,isMobile and 15 or 12),
			Position = UDim2.new(0,0,0,isMobile and 18 or 15),
			Parent = sliderholder
		}
	)
	
	local outline2 = utility.new(
		"Frame",
		{
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BorderColor3 = Color3.fromRGB(56, 56, 56),
			BorderMode = "Inset",
			BorderSizePixel = 1,
			Size = UDim2.new(1,0,1,0),
			Parent = outline
		}
	)	
	
	local value = utility.new(
		"TextLabel",
		{
			BackgroundTransparency = 1,
			Size = UDim2.new(1,0,0,2),
			Position = UDim2.new(0,0,0.5,0),
			Font = self.library.font,
			Text = def..measurement.."/"..max..measurement,
			TextColor3 = Color3.fromRGB(255,255,255),
			TextSize = self.library.textsize,
			TextStrokeTransparency = 0,
			ZIndex = 3,
			Parent = outline
		}
	)
	
	local color = utility.new(
		"Frame",
		{
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BorderSizePixel = 0,
			Size = UDim2.new(1,0,1,0),
			Parent = outline2
		}
	)
	
	utility.new(
		"UIGradient",
		{
			Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(199, 191, 204)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))},
			Rotation = 90,
			Parent = color
		}
	)
	
	local slide = utility.new(
		"Frame",
		{
			BackgroundColor3 = self.library.theme.accent,
			BorderSizePixel = 0,
			Size = UDim2.new((1 / color.AbsoluteSize.X) * (color.AbsoluteSize.X / (max - min) * (def - min)),0,1,0),
			ZIndex = 2,
			Parent = outline
		}
	)
	table.insert(self.library.themeitems["accent"]["BackgroundColor3"],slide)
	
	utility.new(
		"UIGradient",
		{
			Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(199, 191, 204)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))},
			Rotation = 90,
			Parent = slide
		}
	)
	
	local sliderbutton = utility.new(
		"TextButton",
		{
			AnchorPoint = Vector2.new(0,0),
			BackgroundTransparency = 1,
			Size = UDim2.new(1,0,1,0),
			Position = UDim2.new(0,0,0,0),
			Text = "",
			Parent = sliderholder
		}
	)
	
	local title = utility.new(
		"TextLabel",
		{
			BackgroundTransparency = 1,
			Size = UDim2.new(1,0,0,isMobile and 18 or 15),
			Position = UDim2.new(0,0,0,0),
			Font = self.library.font,
			Text = name,
			TextColor3 = Color3.fromRGB(255,255,255),
			TextSize = self.library.textsize,
			TextStrokeTransparency = 0,
			TextXAlignment = "Left",
			Parent = sliderholder
		}
	)
	
	slider = {
		["library"] = self.library,
		["outline"] = outline,
		["sliderbutton"] = sliderbutton,
		["title"] = title,
		["value"] = value,
		["slide"] = slide,
		["color"] = color,
		["max"] = max,
		["min"] = min,
		["current"] = def,
		["measurement"] = measurement,
		["tick"] = ticking,
		["rounding"] = rounding,
		["callback"] = callback
	}
	
	-- Enhanced slide function with mobile support
	local function slide()
		local mousePos = isMobile and utility.getInputPosition() or plr:GetMouse().X
		local size = math.clamp(mousePos - slider.color.AbsolutePosition.X ,0 ,slider.color.AbsoluteSize.X)
		local result = (slider.max - slider.min) / slider.color.AbsoluteSize.X * size + slider.min
		if slider.rounding then
			local newres = math.floor(result)
			value.Text = newres..slider.measurement.."/"..slider.max..slider.measurement
			slider.current = newres
			slider.callback(newres)
			if slider.tick then
				slider.slide:TweenSize(UDim2.new((1 / slider.color.AbsoluteSize.X) * (slider.color.AbsoluteSize.X / (slider.max - slider.min) * (newres - slider.min)) ,0 ,1 ,0) ,Enum.EasingDirection.Out ,Enum.EasingStyle.Quad ,0.15 ,true)
			else
				slider.slide:TweenSize(UDim2.new((1 / slider.color.AbsoluteSize.X) * size ,0 ,1 ,0) ,Enum.EasingDirection.Out ,Enum.EasingStyle.Quad ,0.15 ,true)
			end
		else
			local newres = utility.round(result ,2)
			value.Text = newres..slider.measurement.."/"..slider.max..slider.measurement
			slider.current = newres
			slider.callback(newres)
			if slider.tick then
				slider.slide:TweenSize(UDim2.new((1 / slider.color.AbsoluteSize.X) * (slider.color.AbsoluteSize.X / (slider.max - slider.min) * (newres - slider.min)) ,0 ,1 ,0) ,Enum.EasingDirection.Out ,Enum.EasingStyle.Quad ,0.15 ,true)
			else
				slider.slide:TweenSize(UDim2.new((1 / slider.color.AbsoluteSize.X) * size ,0 ,1 ,0) ,Enum.EasingDirection.Out ,Enum.EasingStyle.Quad ,0.15 ,true)
			end
		end
	end
	
	-- Enhanced input handling with touch support
	sliderbutton.MouseButton1Down:Connect(function()
		slider.holding = true
		slide()
		table.insert(self.library.themeitems["accent"]["BorderColor3"],outline)
		outline.BorderColor3 = self.library.theme.accent
	end)
	
	-- Add touch support for slider
	sliderbutton.TouchTap:Connect(function()
		slider.holding = true
		slide()
		table.insert(self.library.themeitems["accent"]["BorderColor3"],outline)
		outline.BorderColor3 = self.library.theme.accent
	end)
	
	uis.InputChanged:Connect(function(input)
		if slider.holding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			slide()
		end
	end)
	
	uis.InputEnded:Connect(function(Input)
		if (Input.UserInputType.Name == 'MouseButton1' or Input.UserInputType == Enum.UserInputType.Touch) and slider.holding then
			slider.holding = false
			outline.BorderColor3 = Color3.fromRGB(12, 12, 12)
			local find = table.find(self.library.themeitems["accent"]["BorderColor3"],outline)
			if find then
				table.remove(self.library.themeitems["accent"]["BorderColor3"],find)
			end
		end
	end)
	
	local pointer = props.pointer or props.Pointer or props.pointername or props.Pointername or props.PointerName or props.pointerName or nil
	
	if pointer then
		if self.pointers then
			self.pointers[tostring(pointer)] = slider
		end
	end
	
	self.library.labels[#self.library.labels+1] = title
	self.library.labels[#self.library.labels+1] = value
	setmetatable(slider, sliders)
	return slider
end

function sliders:set(value)
	local size = math.clamp((self.color.AbsoluteSize.X / (self.max - self.min) * (value - self.min)) ,0 ,self.color.AbsoluteSize.X)
	local result = value
	if self.rounding then
		local newres = math.floor(result)
		self.value.Text = newres..self.measurement.."/"..self.max..self.measurement
		self.current = newres
		self.callback(newres)
		if self.tick then
			self.slide:TweenSize(UDim2.new((1 / self.color.AbsoluteSize.X) * (self.color.AbsoluteSize.X / (self.max - self.min) * (newres - self.min)) ,0 ,1 ,0) ,Enum.EasingDirection.Out ,Enum.EasingStyle.Quad ,0.15 ,true)
		else
			self.slide:TweenSize(UDim2.new((1 / self.color.AbsoluteSize.X) * size ,0 ,1 ,0) ,Enum.EasingDirection.Out ,Enum.EasingStyle.Quad ,0.15 ,true)
		end
	else
		local newres = utility.round(result ,2)
		self.value.Text = newres..self.measurement.."/"..self.max..self.measurement
		self.current = newres
		self.callback(newres)
		if self.tick then
			self.slide:TweenSize(UDim2.new((1 / self.color.AbsoluteSize.X) * (self.color.AbsoluteSize.X / (self.max - self.min) * (newres - self.min)) ,0 ,1 ,0) ,Enum.EasingDirection.Out ,Enum.EasingStyle.Quad ,0.15 ,true)
		else
			self.slide:TweenSize(UDim2.new((1 / self.color.AbsoluteSize.X) * size ,0 ,1 ,0) ,Enum.EasingDirection.Out ,Enum.EasingStyle.Quad ,0.15 ,true)
		end
	end
end

-- // Close windows function with mobile support
function library:closewindows(ignore)
	local window = self
	
	for i,v in pairs(window.dropdowns) do
		if v ~= ignore then
			if v.open then
				v.optionsholder.Visible = false
				v.indicator.Text = "+"
				v.open = false
			end
		end
	end
	
	for i,v in pairs(window.multiboxes) do
		if v ~= ignore then
			if v.open then
				v.optionsholder.Visible = false
				v.indicator.Text = "+"
				v.open = false
			end
		end
	end
	
	for i,v in pairs(window.buttonboxs) do
		if v ~= ignore then
			if v.open then
				v.optionsholder.Visible = false
				v.indicator.Text = "+"
				v.open = false
			end
		end
	end
	
	for i,v in pairs(window.colorpickers) do
		if v ~= ignore then
			if v.open then
				v.cpholder.Visible = false
				v.open = false
			end
		end
	end
end

return library
