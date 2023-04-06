local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local Packages = ProfileQRCode.Parent
local enumerate = require(Packages.Enumerate)

return enumerate(script.Name, {
	FriendRequestBannerAccepted = "friendRequestBannerAccepted",
	FriendRequestBannerDismissed = "friendRequestBannerDismissed",
})
