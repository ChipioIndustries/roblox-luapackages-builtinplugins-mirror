game:DefineFastFlag("OverridePlayerVerifiedBadge", false)

--[=[
	The `FFlagOverridePlayerVerifiedBadge` flag is used as a mechanism to
	completely disable the check for the verified badge status on the
    player object and always return a player is verified.

	@within VerifiedBadges
	@tag Fast
	@private
]=]
local function getFFlagOverridePlayerVerifiedBadge()
	return game:GetFastFlag("OverridePlayerVerifiedBadge")
end

return getFFlagOverridePlayerVerifiedBadge
