--[[
	A hook that will fire a callback only one time when a condition becomes true.
]]

local RoactUtils = script:FindFirstAncestor("RoactUtils")
local Packages = RoactUtils.Parent

local React = require(Packages.React)
local dependencyArray = require(script.Parent.dependencyArray)

return function(callback: () -> (), when: any)
	local hasRunEver = React.useRef(false)

	React.useEffect(function()
		if when and not hasRunEver.current then
			callback()
			hasRunEver.current = true
		end
	end, dependencyArray(when))
end
