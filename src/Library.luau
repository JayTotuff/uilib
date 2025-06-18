-- Main Library File
local Root = script
local Flipper = require(Root.Packages.Flipper)
local Creator = require(Root.Modules.Creator)

local Library = {
    Version = "1.0.0",
    Elements = {},
    Utilities = require(Root.Modules.Utilities),
}

-- Import modules
local WindowModule = require(Root.Components.Window)
local TabModule = require(Root.Components.Tab)

function Library:CreateWindow(Config)
    return WindowModule:New(Config)
end

-- Element metatable for chaining methods
Library.Elements = {}
Library.Elements.__index = Library.Elements

-- Add common element methods
function Library.Elements:CreateToggle(Name, Config)
    local Toggle = require(Root.Components.Toggle)
    return Toggle:New(Name, Config, self.Container)
end

function Library.Elements:CreateSlider(Name, Config)
    local Slider = require(Root.Components.Slider)
    return Slider:New(Name, Config, self.Container)
end

function Library.Elements:CreateButton(Config)
    local Button = require(Root.Components.Button)
    return Button:New(Config, self.Container)
end

function Library.Elements:CreateSection(Title)
    local Section = require(Root.Components.Section)
    return Section:New(Title, self.Container)
end

return Library
