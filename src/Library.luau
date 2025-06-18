-- Library.luau (Main file that gets loaded)
local Library = {}
Library.Version = "1.0.0"

-- Import all components
local Window = require(script.Components.Window)
local Tab = require(script.Components.Tab)
local Slider = require(script.Components.Slider)
local Button = require(script.Components.Button)
local Dropdown = require(script.Components.Dropdown)
local Toggle = require(script.Components.Toggle)
-- ... other components

function Library:CreateWindow(config)
    return Window.new(config)
end

-- Export the library
return Library
