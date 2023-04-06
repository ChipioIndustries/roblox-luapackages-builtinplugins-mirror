local ExperienceChat = script:FindFirstAncestor("ExperienceChat")
local ProjectRoot = ExperienceChat.Parent
local Rodux = require(ProjectRoot.Rodux)

local FFlagShowVerifiedBadgeInNewChat = require(ExperienceChat.Flags.FFlagShowVerifiedBadgeInNewChat)

return Rodux.combineReducers({
	Messages = require(script.Messages),
	MutedUsers = require(script.MutedUsers),
	VerifiedUsers = FFlagShowVerifiedBadgeInNewChat() and require(script.VerifiedUsers) or nil,
	Players = require(script.Players),
	LocalCharacter = require(script.LocalCharacter),
	TextChannels = require(script.TextChannels),
	ChatVisibility = require(script.ChatVisibility),
	CanLocalUserChat = require(script.CanLocalUserChat),
	LocalTeam = require(script.LocalTeam),
	isUsingTouch = require(script.isUsingTouch),
	shouldFocusChatInputBar = require(script.shouldFocusChatInputBar),
	Voice = require(script.Voice),
	BubbleChatSettings = require(script.BubbleChat),
	ChatLayout = require(script.ChatLayout),
	AutoCastCommands = require(script.AutoCastCommands),
	Adornees = require(script.Adornees),
})
