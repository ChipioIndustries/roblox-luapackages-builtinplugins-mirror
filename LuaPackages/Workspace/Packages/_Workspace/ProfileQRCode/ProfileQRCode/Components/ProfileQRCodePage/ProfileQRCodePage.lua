local IXPService = game:GetService("IXPService")
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local Packages = ProfileQRCode.Parent

local Cryo = require(Packages.Cryo)
local React = require(Packages.React)
local RoactAppExperiment = require(Packages.RoactAppExperiment)
local RoactUtils = require(Packages.RoactUtils)
local UIBlox = require(Packages.UIBlox)

local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local Toast = UIBlox.App.Dialog.Toast

local EventNames = require(ProfileQRCode.Analytics.EventNames)
local ProfileQRCodeTopBar = require(ProfileQRCode.Components.ProfileQRCodeTopBar)
local QRCodeFriendRequestNotification = require(ProfileQRCode.Components.QRCodeFriendRequestNotification)
local QRCodeView = require(ProfileQRCode.Components.QRCodeView)
local TextKeys = require(ProfileQRCode.Common.TextKeys)

local useAcceptFriendUrl = require(ProfileQRCode.Networking.useAcceptFriendUrl)
local useAnalytics = require(ProfileQRCode.Analytics.useAnalytics)
local useGetUsersInfoUrl = require(ProfileQRCode.Networking.useGetUsersInfoUrl)
local useLocalization = RoactUtils.Hooks.useLocalization
local useLocalUserId = require(Packages.RobloxAppHooks).useLocalUserId
local useStyle = UIBlox.Core.Style.useStyle
local NetworkingFriends = require(Packages.NetworkingFriends)
local Images = UIBlox.App.ImageSet.Images

local getFFlagProfileQRCodeEnableAlerts = require(Packages.SharedFlags).getFFlagProfileQRCodeEnableAlerts
local getFFlagProfileQRCodeEnableAlertsExperiment =
	require(ProfileQRCode.Flags.getFFlagProfileQRCodeEnableAlertsExperiment)
local getFStringProfileQRCodeFriendRequestAlertsExperimentKey =
	require(ProfileQRCode.Flags.getFStringProfileQRCodeFriendRequestAlertsExperimentKey)
local getFStringProfileQRCodeFriendRequestAlertsLayer =
	require(ProfileQRCode.Flags.getFStringProfileQRCodeFriendRequestAlertsLayer)

-- We have a hardcoded white here as for gradients to work, you need a full white background. This colour will not show.
local BACKGROUND_FOR_GRADIENT = Color3.new(1, 1, 1)
local GRADIENT_ROTATION = 90
local ROOT_PADDING = 24
local TOP_BAR_PADDING = -56

local QR_ALERT_TOP_PADDING = 44
local QR_ALERT_SIDE_PADDING = 28

local ADD_TO_QUEUE = "addItemToQueue"
local REMOVE_FROM_QUEUE = "removeItemFromQueue"

local FRIEND_ADDED_IMAGE = Images["icons/actions/friends/friendAdd"]
local TOAST_DURATION = 3

export type Props = {
	onClose: () -> (),
	profileQRCodeFriendRequestAlertsEnabled: boolean?,
	robloxEventReceiver: any?,
}

local ProfileQRCodePage = function(props: Props)
	local localized = useLocalization({
		description = TextKeys.Description,
		friendAdded = TextKeys.FriendAdded,
	})
	local style = useStyle()
	local friendRequestAlertsEnabled = if getFFlagProfileQRCodeEnableAlertsExperiment()
		then props.profileQRCodeFriendRequestAlertsEnabled
		else false
	local analytics = if getFFlagProfileQRCodeEnableAlerts() then useAnalytics() else nil

	local localUserId, acceptFriendUrl, showFriendAcceptedToast, setShowFriendAcceptedToast, notificationQueue, updateNotificationQueue

	if getFFlagProfileQRCodeEnableAlerts() and props.robloxEventReceiver then
		local robloxEventReceiver = props.robloxEventReceiver

		showFriendAcceptedToast, setShowFriendAcceptedToast = React.useState(false)
		notificationQueue, updateNotificationQueue = React.useReducer(function(oldQueue, action)
			if action.type == ADD_TO_QUEUE then
				if getFFlagProfileQRCodeEnableAlertsExperiment() then
					IXPService:LogUserLayerExposure(getFStringProfileQRCodeFriendRequestAlertsLayer())
				end
				-- update queue
				return Cryo.List.join(oldQueue, { action.newUserId })
			elseif action.type == REMOVE_FROM_QUEUE then
				return Cryo.List.removeIndex(oldQueue, 1)
			else
				return oldQueue
			end
		end, {})

		localUserId = useLocalUserId()
		local getUsersInfoUrl = useGetUsersInfoUrl()
		acceptFriendUrl = useAcceptFriendUrl()

		local function friendshipNotificationReceived(details)
			-- Check to make sure this is the type of friend notification we respond to
			if
				details.Type == "FriendshipRequested"
				and details.EventArgs.SourceType
					== NetworkingFriends.Enums.FriendshipOriginSourceType.QrCode.rawValue()
			then
				-- get the requesting user id, each friendship request has 2 user ids the requester and the requestee.  The
				-- requestee should be the local user so if UserId1 is the local user id then UserId2 must be the requester
				local userId = tostring(details.EventArgs.UserId1)
				if userId == localUserId then
					userId = tostring(details.EventArgs.UserId2)
				end

				-- Now using the requester user id we make a call to get the display name of the requesting user
				getUsersInfoUrl(userId):andThen(function()
					updateNotificationQueue({ type = ADD_TO_QUEUE, newUserId = userId })
				end)
			end
		end

		React.useEffect(function()
			robloxEventReceiver:observeEvent("FriendshipNotifications", function(detail)
				friendshipNotificationReceived(detail)
			end)
		end, { robloxEventReceiver })
	end

	return React.createElement("Frame", {
		BackgroundColor3 = BACKGROUND_FOR_GRADIENT,
		BackgroundTransparency = 0,
		ZIndex = 2,
		Size = UDim2.new(1, 0, 1, 0),
		BorderSizePixel = 0,
	}, {
		Gradient = React.createElement("Frame", {
			BackgroundColor3 = BACKGROUND_FOR_GRADIENT,
			BackgroundTransparency = 0,
			ZIndex = 2,
			Size = UDim2.new(1, 0, 1, 0),
			BorderSizePixel = 0,
		}, {
			Layout = React.createElement("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			Padding = React.createElement("UIPadding", {
				PaddingTop = UDim.new(0, ROOT_PADDING),
			}),
			TopBar = React.createElement(ProfileQRCodeTopBar, {
				layoutOrder = 1,
				onClose = props.onClose,
			}),
			Content = React.createElement("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, TOP_BAR_PADDING),
				BorderSizePixel = 0,
				LayoutOrder = 2,
			}, {
				Layout = React.createElement("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				Padding = React.createElement("UIPadding", {
					PaddingTop = UDim.new(0, ROOT_PADDING),
					PaddingRight = UDim.new(0, ROOT_PADDING),
					PaddingBottom = UDim.new(0, ROOT_PADDING),
					PaddingLeft = UDim.new(0, ROOT_PADDING),
				}),
				QRCodeView = React.createElement(QRCodeView, {
					layoutOrder = 1,
				}),
				Spacer1 = React.createElement("Frame", {
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 0, 0, ROOT_PADDING),
					LayoutOrder = 2,
				}),
				Description = React.createElement(StyledTextLabel, {
					layoutOrder = 3,
					text = localized.description,
					fontStyle = style.Font.Body,
					lineHeight = 1,
					colorStyle = style.Theme.TextDefault,
					size = UDim2.new(1, 0, 0, 0),
					automaticSize = Enum.AutomaticSize.Y,
					textXAlignment = Enum.TextXAlignment.Center,
					textYAlignment = Enum.TextYAlignment.Center,
					fluidSizing = false,
					richText = false,
				}),
			}),
			Gradient = React.createElement("UIGradient", {
				Rotation = GRADIENT_ROTATION,
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, style.Theme.BackgroundContrast.Color),
					ColorSequenceKeypoint.new(1, style.Theme.BackgroundContrast.Color),
				}),
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 0.4),
					NumberSequenceKeypoint.new(1, 0),
				}),
			}),
		}),
		FriendAcceptToastFrame = if friendRequestAlertsEnabled
				and getFFlagProfileQRCodeEnableAlerts()
				and showFriendAcceptedToast
			then React.createElement("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				ZIndex = 100,
			}, {
				FriendAcceptToast = React.createElement(Toast, {
					toastContent = {
						toastTitle = localized.friendAdded,
						iconImage = FRIEND_ADDED_IMAGE,
						onDismissed = function()
							setShowFriendAcceptedToast(false)
						end,
					},
					duration = TOAST_DURATION,
					show = true,
				}),
			})
			else nil,
		FriendsInviteFrame = if friendRequestAlertsEnabled
				and getFFlagProfileQRCodeEnableAlerts()
				and #notificationQueue > 0
				and not showFriendAcceptedToast
			then React.createElement("Frame", {
				BackgroundTransparency = 1,
				Position = UDim2.new(0, QR_ALERT_SIDE_PADDING, 0, QR_ALERT_TOP_PADDING),
				Size = UDim2.new(1, -(QR_ALERT_SIDE_PADDING * 2), 1, 0),
				ZIndex = 100,
			}, {
				FriendsInvite = React.createElement(QRCodeFriendRequestNotification, {
					notificationQueueSize = #notificationQueue,
					onAccept = function(acceptedUserId)
						acceptFriendUrl(localUserId, acceptedUserId):andThen(function()
							updateNotificationQueue({ type = REMOVE_FROM_QUEUE, newUserId = "0" })
							setShowFriendAcceptedToast(true)
						end)
						-- We can remove the `and analytics` when we remove the flag as
						-- long as typechecking is happy
						if getFFlagProfileQRCodeEnableAlerts() and analytics then
							-- SACQ-593: Add test for this
							analytics.fireEvent(EventNames.QRPageFriendRequestBannerAccepted, {
								qrCodeBannerQueueSize = #notificationQueue,
							})
						end
					end,
					onClose = function()
						updateNotificationQueue({ type = REMOVE_FROM_QUEUE, newUserId = "0" })
						-- We can remove the `and analytics` when we remove the flag as
						-- long as typechecking is happy
						if getFFlagProfileQRCodeEnableAlerts() and analytics then
							-- SACQ-593: Add test for this
							analytics.fireEvent(EventNames.QRPageFriendRequestBannerDismissed, {
								qrCodeBannerQueueSize = #notificationQueue,
							})
						end
					end,
					userId = tostring(notificationQueue[1]),
				}),
			})
			else nil,
	})
end

if getFFlagProfileQRCodeEnableAlertsExperiment() then
	ProfileQRCodePage = RoactAppExperiment.connectUserLayer({
		getFStringProfileQRCodeFriendRequestAlertsLayer(),
	}, function(layerVariables, props)
		local profileQRCodeFriendRequestAlertsLayer: any = layerVariables[getFStringProfileQRCodeFriendRequestAlertsLayer()]
			or {}
		return {
			profileQRCodeFriendRequestAlertsEnabled = profileQRCodeFriendRequestAlertsLayer[getFStringProfileQRCodeFriendRequestAlertsExperimentKey()],
		}
	end, false)(ProfileQRCodePage)
end

return ProfileQRCodePage
