-- Types duplicated in UserSearchTileUniversalWrapper

export type Args = {
	userId: string,
	index: number,
	hasEmphasis: boolean?,
	contextualInfoType: string?,
	contextualInfoDisplay: { text: string, icon: string? }?,
}

export type LuaAppNetworkingRequests = {
	requestFriendship: (args: Args) -> (),
	acceptFriendRequest: (args: Args) -> (),
}

export type LuaAppNavigation = {
	navigateToUserInfo: (args: Args) -> (),
}

export type PreviousUsernames = {
	[number]: string,
}

export type SearchUser = {
	id: string,
	name: string,
	displayName: string,
	previousUsernames: PreviousUsernames,
}

export type SearchParameters = {
	searchKeyword: string,
}

return nil
