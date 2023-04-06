local FriendsCarousel = script:FindFirstAncestor("FriendsCarousel")
local devDependencies = require(FriendsCarousel.devDependencies)
local createTreeWithProviders = require(FriendsCarousel.TestHelpers.createTreeWithProviders)
local mockStore = require(FriendsCarousel.TestHelpers.mockStore)

local UnitTestHelpers = devDependencies.UnitTestHelpers
local RhodiumHelpers = devDependencies.RhodiumHelpers()
local JestGlobals = devDependencies.JestGlobals
local jestExpect = devDependencies.jestExpect
local describe = JestGlobals.describe
local it = JestGlobals.it
local jest = devDependencies.jest
local findImageSet = devDependencies.findImageSet
local runWhileMounted = UnitTestHelpers.runWhileMounted

local AddFriendsTileCircular = require(script.Parent)

local getFFlagFriendsCarouselCircularBadge = require(FriendsCarousel.Flags.getFFlagFriendsCarouselCircularBadge)

describe("AddFriendsTileCircular", function()
	local state = {}

	it("should create and destroy without errors", function()
		local element = createTreeWithProviders(AddFriendsTileCircular, {
			store = mockStore(state),
			props = {},
		})
		runWhileMounted(element, function(parent)
			jestExpect(#parent:GetChildren()).toBe(1)
		end)
	end)

	it("should fire onActivated if pressed", function()
		local onActivated = jest.fn()
		local element = createTreeWithProviders(AddFriendsTileCircular, {
			store = mockStore(state),
			props = {
				onActivated = function()
					onActivated()
				end,
			},
		})
		runWhileMounted(element, function(parent)
			local AddFriendsTileCircular = RhodiumHelpers.findFirstInstance(parent, {
				Name = "AddFriendsTileCircular",
			})
			RhodiumHelpers.clickInstance(AddFriendsTileCircular)
			jestExpect(onActivated).toHaveBeenCalled()
		end)
	end)

	it("SHOULD show the right icon", function()
		local element = createTreeWithProviders(AddFriendsTileCircular, {
			store = mockStore(state),
			props = {},
		})
		runWhileMounted(element, function(parent)
			local imageLabelWithLegacyIcon =
				RhodiumHelpers.findFirstInstance(parent, findImageSet("icons/menu/friends_large"))

			jestExpect(imageLabelWithLegacyIcon).toEqual(jestExpect.any("Instance"))
		end)
	end)

	it("SHOULD have the right text in the right place", function()
		local element = createTreeWithProviders(AddFriendsTileCircular, {
			store = mockStore(state),
			props = {
				labelText = "Test Label Text",
			},
		})
		runWhileMounted(element, function(parent)
			local AddFriendsLabel = RhodiumHelpers.findFirstInstance(parent, { Name = "AddFriendsLabel" })
			local AddFriendButton = RhodiumHelpers.findFirstInstance(parent, { Name = "AddFriendButton" })

			jestExpect(AddFriendsLabel).never.toBeNil()
			jestExpect(AddFriendsLabel.Text).toBe("Test Label Text")
			jestExpect(AddFriendButton).toBeAbove(AddFriendsLabel)
		end)
	end)

	it("SHOULD not render badge if it's not passed", function()
		local element = createTreeWithProviders(AddFriendsTileCircular, {
			store = mockStore(state),
			props = {
				labelText = "Test Label Text",
				onActivated = function() end,
			},
		})
		runWhileMounted(element, function(parent)
			local badge = RhodiumHelpers.findFirstInstance(parent, {
				Name = "Badge",
			})

			jestExpect(badge).toBeNil()
		end)
	end)

	it("SHOULD render correct badge value if it passed", function()
		if getFFlagFriendsCarouselCircularBadge() then
			local element = createTreeWithProviders(AddFriendsTileCircular, {
				store = mockStore(state),
				props = {
					labelText = "Test Label Text",
					onActivated = function() end,
					badgeValue = "badgeValue",
				},
			})
			runWhileMounted(element, function(parent)
				local badge = RhodiumHelpers.findFirstInstance(parent, {
					Name = "Badge",
				})

				jestExpect(badge).never.toBeNil()
				jestExpect(badge.Inner.TextLabel.Text).toEqual("bad...")
			end)
		end
	end)
end)
