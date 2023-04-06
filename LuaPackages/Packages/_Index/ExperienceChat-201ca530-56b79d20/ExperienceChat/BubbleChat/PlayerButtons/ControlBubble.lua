--[[
	Indicator bubble that accepts an icon and an onActivated function.

	This is shown when a user's device has given Roblox camera or microphone permissions.
]]
local ExperienceChat = script:FindFirstAncestor("ExperienceChat")

local Packages = ExperienceChat.Parent
local Roact = require(Packages.Roact)

local UIBlox = require(Packages.UIBlox)
local Dictionary = require(Packages.llama).Dictionary

local ImageSetButton = UIBlox.Core.ImageSet.Button
local Colors = UIBlox.App.Style.Colors

local DISABLED_ICON_COLOR = Colors.Flint
local DISABLED_ICON_TRANSPARENCY = 0.5
local BACKGROUND_COLOR = Colors.Graphite
local ICON_COLOR = Colors.White
local ICON_TRANSPARENCY = 0
local DEFAULT_BACKGROUND_COLOR = Color3.fromRGB(250, 250, 250)

local ControlBubble = Roact.PureComponent:extend("ControlBubble")

-- ControlBubble.validateProps = t.strictInterface({
-- 	LayoutOrder = t.optional(t.number),
-- 	icon = t.any,
-- 	onActivated = t.callback,
-- 	enabled = t.boolean,
-- 	isImageSet = t.boolean,
-- })

function ControlBubble:render()
	local chatSettings = self.props.chatSettings
	local backgroundImageSettings = chatSettings.BackgroundImage
	local imageComponent = if self.props.isImageSet then ImageSetButton else "ImageButton"

	-- Default has a gray background around the icons (different from regular
	-- bubble chat bubbles which is white). If a developer updates the color, set it to that color.
	-- If not, keep the default gray background around the buttons.
	local backgroundColor = if not chatSettings.BackgroundColor3
			or chatSettings.BackgroundColor3 == DEFAULT_BACKGROUND_COLOR
		then BACKGROUND_COLOR
		else chatSettings.BackgroundColor3

	return Roact.createElement("ImageButton", {
		AnchorPoint = Vector2.new(0.5, 1),
		Size = UDim2.new(0, 44, 1, 0),
		LayoutOrder = self.props.LayoutOrder,
		BorderSizePixel = 0,
		Transparency = 1,
		ZIndex = 2,
		[Roact.Event.Activated] = self.props.onActivated,
	}, {
		UICorner = chatSettings.CornerEnabled and Roact.createElement("UICorner", {
			CornerRadius = chatSettings.CornerRadius,
		}),
		Contents = Roact.createElement(
			"ImageLabel",
			Dictionary.join(backgroundImageSettings, {
				Size = UDim2.fromScale(1, 1),
				BackgroundColor3 = backgroundColor,
				BorderSizePixel = 0,
			}),
			{
				UICorner = chatSettings.CornerEnabled and Roact.createElement("UICorner", {
					CornerRadius = chatSettings.CornerRadius,
				}),
				Padding = Roact.createElement("UIPadding", {
					PaddingTop = UDim.new(0, chatSettings.Padding),
					PaddingRight = UDim.new(0, chatSettings.Padding),
					PaddingBottom = UDim.new(0, chatSettings.Padding),
					PaddingLeft = UDim.new(0, chatSettings.Padding),
				}),
				Icon = Roact.createElement(imageComponent, {
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),
					-- Icons from image set are a different size.
					Size = not self.props.isImageSet and UDim2.fromOffset(14, 18) or UDim2.fromOffset(28, 28),
					BackgroundTransparency = 1,
					ImageTransparency = if self.props.enabled then ICON_TRANSPARENCY else DISABLED_ICON_TRANSPARENCY,
					ImageColor3 = if self.props.enabled then ICON_COLOR else DISABLED_ICON_COLOR,
					BorderSizePixel = 0,
					Image = self.props.isImageSet and self.props.imageSetIcon or self.props.icon,
				}),
			}
		),
	})
end

return ControlBubble
