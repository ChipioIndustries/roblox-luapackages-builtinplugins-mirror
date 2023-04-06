local LuaSocialLibrariesDeps = script.Parent

game:DefineFastFlag("SocialUpdateRoduxFriendsv314", false)

local getFFlagSocialUpdateRoduxFriendsv314 = function()
	return game:GetFastFlag("SocialUpdateRoduxFriendsv314")
end

return {
	GenericPagination = require(LuaSocialLibrariesDeps.GenericPagination),
	RoactFitComponents = require(LuaSocialLibrariesDeps.RoactFitComponents),
	Mock = require(LuaSocialLibrariesDeps.Mock),
	RoduxNetworking = require(LuaSocialLibrariesDeps.RoduxNetworking),
	llama = require(LuaSocialLibrariesDeps.llama),
	RoduxAliases = require(LuaSocialLibrariesDeps.RoduxAliases),
	RoduxUsers = require(LuaSocialLibrariesDeps.RoduxUsers),
	RoduxUsers_v13 = require(LuaSocialLibrariesDeps.RoduxUsers_v13),
	RoduxFriends = if getFFlagSocialUpdateRoduxFriendsv314()
		then require(LuaSocialLibrariesDeps.RoduxFriends_v315)
		else require(LuaSocialLibrariesDeps.RoduxFriends),
	RoduxPresence = require(LuaSocialLibrariesDeps.RoduxPresence),
	RoduxPresence_v3 = require(LuaSocialLibrariesDeps.RoduxPresence_v3),
	RoduxGames = require(LuaSocialLibrariesDeps.RoduxGames),
	RoduxContacts = require(LuaSocialLibrariesDeps.RoduxContacts),
	RoduxUserPermissions = require(LuaSocialLibrariesDeps.RoduxUserPermissions),
	NetworkingAccountInformation = require(LuaSocialLibrariesDeps.NetworkingAccountInformation),
	NetworkingAccountSettings = require(LuaSocialLibrariesDeps.NetworkingAccountSettings),
	NetworkingUserSettings = require(LuaSocialLibrariesDeps.NetworkingUserSettings),
	RoduxShareLinks = require(LuaSocialLibrariesDeps.RoduxShareLinks),
	httpRequest = require(LuaSocialLibrariesDeps.httpRequest),
	NetworkingPresence = require(LuaSocialLibrariesDeps.NetworkingPresence),
	NetworkingAliases = require(LuaSocialLibrariesDeps.NetworkingAliases),
	NetworkingChat = require(LuaSocialLibrariesDeps.NetworkingChat),
	NetworkingFriends = require(LuaSocialLibrariesDeps.NetworkingFriends),
	NetworkingFriends_221 = require(LuaSocialLibrariesDeps.NetworkingFriends_221),
	NetworkingGames = require(LuaSocialLibrariesDeps.NetworkingGames),
	NetworkingContacts = require(LuaSocialLibrariesDeps.NetworkingContacts),
	NetworkingShareLinks = require(LuaSocialLibrariesDeps.NetworkingShareLinks),
	NetworkingPremiumFeatures = require(LuaSocialLibrariesDeps.NetworkingPremiumFeatures),
	NetworkingCurrentlyWearing = require(LuaSocialLibrariesDeps.NetworkingCurrentlyWearing),
	CollisionMatchers = require(LuaSocialLibrariesDeps.CollisionMatchers),
	SocialLibraries = require(LuaSocialLibrariesDeps.SocialLibraries),
	NetworkingUsers = require(LuaSocialLibrariesDeps.NetworkingUsers),
	NetworkingBlocking = require(LuaSocialLibrariesDeps.NetworkingBlocking),
	getFFlagSocialUpdateRoduxFriendsv314 = getFFlagSocialUpdateRoduxFriendsv314,
	NetworkingSquads = require(LuaSocialLibrariesDeps.NetworkingSquads),
	RoduxSquads = require(LuaSocialLibrariesDeps.RoduxSquads),
	NetworkingCall = require(LuaSocialLibrariesDeps.NetworkingCall),
	RoduxCall = require(LuaSocialLibrariesDeps.RoduxCall),
}
