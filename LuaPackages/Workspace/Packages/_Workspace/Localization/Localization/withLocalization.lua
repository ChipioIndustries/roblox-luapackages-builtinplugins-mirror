local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Roact)
local ArgCheck = require(CorePackages.Workspace.Packages.ArgCheck)
local LocalizationConsumer = require(script.Parent.LocalizationConsumer)

local function withLocalization(stringsToBeLocalized)
	ArgCheck.isType(stringsToBeLocalized, "table", "stringsToBeLocalized passed to withLocalization()")

	return function(render)
		ArgCheck.isType(render, "function", "render passed to withLocalization()")

		return Roact.createElement(LocalizationConsumer, {
			render = render,
			stringsToBeLocalized = stringsToBeLocalized,
		})
	end
end

return withLocalization
