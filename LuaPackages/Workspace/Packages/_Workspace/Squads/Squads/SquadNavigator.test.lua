local CoreGui = game:GetService("CoreGui")

local Squads = script:FindFirstAncestor("Squads")
local devDependencies = require(Squads.devDependencies)
local dependencies = require(Squads.dependencies)

local RoactNavigation = dependencies.RoactNavigation
local NavigationActions = RoactNavigation.Actions

local JestGlobals = devDependencies.JestGlobals
local afterEach = JestGlobals.afterEach
local beforeEach = JestGlobals.beforeEach
local describe = JestGlobals.describe
local it = JestGlobals.it
local jestExpect = JestGlobals.expect

local createTreeWithProviders = devDependencies.createTreeWithProviders
local ReactRoblox = devDependencies.ReactRoblox
local RhodiumHelpers = devDependencies.RhodiumHelpers()

local SquadNavigator = require(script.Parent.SquadNavigator)

it("Should return correct initial route from router", function()
	local state = SquadNavigator.router.getStateForAction(NavigationActions.init(), nil)
	jestExpect(#state.routes).toBe(1)
	jestExpect(state.routes[state.index].routeName).toBe("SquadLobby")
end)

describe("SquadNavigator Rendering", function()
	local container
	local root

	beforeEach(function()
		container = Instance.new("ScreenGui")
		container.Parent = CoreGui

		root = ReactRoblox.createRoot(container)
	end)

	afterEach(function()
		root:unmount()
		container:Destroy()
	end)

	it("Should render the initial page", function()
		local SquadAppContainer = RoactNavigation.createAppContainer(SquadNavigator)

		ReactRoblox.act(function()
			root:render(createTreeWithProviders(SquadAppContainer, {
				state = {
					ScreenSize = {
						X = 320,
						Y = 640,
					},
					TopBar = {
						statusBarHeight = 20,
					},
				},
				props = {},
			}))
		end)

		-- Find an element we expect on the page.
		local element = RhodiumHelpers.findFirstInstance(container, {
			Name = "PeekViewContainer",
		})
		jestExpect(element).never.toBeNil()
	end)
end)
