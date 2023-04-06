local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)
local Roact = dependencies.Roact
local llama = dependencies.llama
local ProfileQRCode = dependencies.ProfileQRCode
local SocialLuaAnalytics = dependencies.SocialLuaAnalytics
local Contexts = SocialLuaAnalytics.Analytics.Enums.Contexts
local getFFlagAddFriendsQRCodeAnalytics = dependencies.getFFlagAddFriendsQRCodeAnalytics
local getFFlagProfileQRCodeEnableAlerts = dependencies.getFFlagProfileQRCodeEnableAlerts
local FriendsLandingContext = require(FriendsLanding.FriendsLandingContext)

return function(props)
	local context
	if getFFlagProfileQRCodeEnableAlerts() then
		context = FriendsLandingContext.useContext()
	end

	return Roact.createElement(
		ProfileQRCode.ProfileQRCodeEntryPoint,
		llama.Dictionary.join(props, {
			onClose = function()
				props.navigation.goBack()
			end,
			source = if getFFlagAddFriendsQRCodeAnalytics() then Contexts.AddFriends.rawValue() else nil,
			robloxEventReceiver = if getFFlagProfileQRCodeEnableAlerts() then context.robloxEventReceiver else nil,
		})
	)
end
