-- given a button component with the field 'onActivated', activates the button and
-- checks if the onActivated function was called

local CoreGui = game:GetService("CoreGui")

local Root = script.Parent
local Packages = Root.Parent

local Rhodium = require(Packages.Rhodium)
local Roact = require(Packages.Roact)

local Element = Rhodium.Element
local XPath = Rhodium.XPath

local mockStyle = require(Packages.UnitTestHelpers).mockStyle

return function(component)
	local buttonActivated = false

	local ElementGui = Roact.createElement("ScreenGui", {}, {
		buttonElement = Roact.createElement(component, {
			onActivated = function()
				buttonActivated = true
			end,
		}),
	})

	local withStyle = mockStyle(ElementGui)

	local instance = Roact.mount(withStyle, CoreGui, "TestRoot")
	local buttonPath = XPath.new("game.CoreGui.TestRoot.buttonElement")

	local button = Element.new(buttonPath)

	assert(button:getRbxInstance() ~= nil, "button was nil")

	button:click()

	wait(0)

	assert(buttonActivated == true, "button was not activated")

	Roact.unmount(instance)
end
