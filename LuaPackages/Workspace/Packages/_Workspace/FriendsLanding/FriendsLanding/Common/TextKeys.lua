local AddFriends = script:FindFirstAncestor("FriendsLanding").AddFriends
local dependencies = require(AddFriends.dependencies)
local getFFlagSocialOnboardingExperimentEnabled = dependencies.getFFlagSocialOnboardingExperimentEnabled

return {
	CONTACT_IMPORTER_TOOLTIP_HEADER = "Feature.Friends.Label.FriendingTooltip",
	CONTACT_IMPORTER_TOOLTIP_BODY = "Feature.Friends.FriendingTooltipBody",
	NO_FRIENDS_TOOLTIP = "Feature.Friends.Message.ViewAndConnectTooltip",
	PROFILE_QR_CODE_TILE_FOOTER = "Feature.Profile.Label.QRCodeFriendRequest",
	ADD_FRIENDS_EMPTY_STATE_PROMPT_TEXT = if getFFlagSocialOnboardingExperimentEnabled()
		then "Feature.AddFriends.Label.EmptyStatePrompt"
		else nil,
	ADD_FRIENDS_TOOLTIP_TITLE = if getFFlagSocialOnboardingExperimentEnabled()
		then "Feature.AddFriends.Title.AddFriendsTooltipTitle"
		else nil,
}
