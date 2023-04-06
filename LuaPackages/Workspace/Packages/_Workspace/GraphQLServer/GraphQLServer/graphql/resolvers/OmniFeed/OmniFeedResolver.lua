-- ROBLOX upstream: https://github.com/Roblox/lua-apps/blob/e027a80507/graphql/resolvers/FeedResolver.ts
local Packages = script:FindFirstAncestor("GraphQLServer").Parent
local LuauPolyfill = require(Packages.LuauPolyfill)
local Array = LuauPolyfill.Array
type Array<T> = LuauPolyfill.Array<T>
type Promise<T> = LuauPolyfill.Promise<T>
type Object = LuauPolyfill.Object
local exports = {}

local OmniFeedConnector = require(script.Parent.Parent.Parent.connectors.OmniFeed.OmniFeedConnector)
type OmniFeedRoot = OmniFeedConnector.OmniFeedRoot
type OmniFeedJson = OmniFeedConnector.OmniFeedJson
type OmniFeedItemJson = OmniFeedConnector.OmniFeedItemJson
type OmniFeedMetadataRoot = OmniFeedConnector.OmniFeedMetadataRoot
local findFeedBySessionId = OmniFeedConnector.findOmniFeedBySessionId
local fetchMoreOmniRecommendationMetadata = OmniFeedConnector.fetchMoreOmniRecommendationMetadata

local generatedTypes = require(script.Parent.Parent.Parent.generatedTypes)
type QueryOmniFeedArgs = generatedTypes.QueryOmniFeedArgs
type OmniFeedMetadata = generatedTypes.OmniFeedMetadata
type OmniFeedItem = generatedTypes.OmniFeedItem
type OmniFeedRecommendation = generatedTypes.OmniFeedRecommendation
type Experience = generatedTypes.Experience

type OmniFeedItemRoot = {
	recommendations: Array<OmniFeedRecommendation>?,
	topic: string?,
	topicId: string?,
	treatmentType: string?,
	metadata: OmniFeedMetadataRoot?,
}

local resolvers = {
	OmniFeedItem = {
		experiences = function(root: OmniFeedItemRoot): Array<Experience>?
			if not root.metadata or not root.metadata.Game or not root.recommendations then
				return nil
			end
			local GameJSON: Object = (root.metadata :: Object).Game
			local experiences: Array<Experience> = {}
			local recommendations = root.recommendations :: Array<OmniFeedRecommendation>

			for _, recommendationMetadata in recommendations do
				if not recommendationMetadata.contentId then
					continue
				end
				local experience = GameJSON[tostring(recommendationMetadata.contentId)]
				local contentMetadata = recommendationMetadata.contentMetadata
				local adId = if contentMetadata and contentMetadata.EncryptedAdTrackingData
					then contentMetadata.EncryptedAdTrackingData
					else nil

				if experience and experience.universeId then
					table.insert(experiences, {
						placeId = if experience.rootPlaceId then tostring(experience.rootPlaceId) else nil,
						name = experience.name,
						universeId = tostring(experience.universeId),
						totalUpVotes = experience.totalUpVotes,
						totalDownVotes = experience.totalDownVotes,
						playerCount = experience.playerCount,
						under9 = if experience.under9 then experience.under9 else false,
						under13 = if experience.under13 then experience.under13 else false,
						adId = adId or "",
						isSponsored = adId ~= nil and adId ~= "",
					})
				end
			end

			return experiences
		end,
	},
	OmniFeedMetadata = {
		GameJSON = function(root: OmniFeedMetadataRoot)
			return root.Game
		end,
		CatalogAssetJSON = function(root: OmniFeedMetadataRoot)
			return root.CatalogAsset
		end,
		CatalogBundleJSON = function(root: OmniFeedMetadataRoot)
			return root.CatalogBundle
		end,
		RecommendedFriendJSON = function(root: OmniFeedMetadataRoot)
			return root.RecommendedFriend
		end,
	},
	OmniFeed = {
		metadata = function(root: OmniFeedRoot)
			return root.contentMetadata
		end,
		sortsExpirationTime = function(root: OmniFeedRoot): number?
			if not root.sortsRefreshInterval then
				return nil
			end
			return math.floor(tick()) + (root.sortsRefreshInterval :: number)
		end,
		recommendationsId = function(root: OmniFeedRoot)
			return root.requestId
		end,
		sorts = function(root: OmniFeedRoot): Array<OmniFeedItemRoot>?
			if not root.sorts then
				return nil
			end

			local feedItems = Array.map(root.sorts :: Array<OmniFeedItemJson>, function(value)
				return {
					topic = value.topic,
					topicId = value.topicId,
					treatmentType = value.treatmentType,
					recommendations = value.recommendationList,
					-- Used to merge experience data into FeedItemContent
					metadata = root.contentMetadata,
				}
			end)
			return feedItems
		end,
	},
	OmniFeedItemWithMetadata = {
		metadata = function(root)
			return root.contentMetadata
		end,
		sort = function(root)
			return {
				topicId = root.topicId,

				-- Used to merge experience data into FeedItemContent
				metadata = root.contentMetadata,
				recommendations = root.recommendations,
			}
		end,
	},
	Query = {
		omniFeed = function(_root: any, ref0: QueryOmniFeedArgs, context: any): Promise<OmniFeedRoot>
			return findFeedBySessionId(ref0, context.fetchImpl)
		end,
		refreshOmniFeedItem = function(_root: any, args, context: any)
			return fetchMoreOmniRecommendationMetadata(args, context.fetchImpl)
		end,
	},
}
exports.default = resolvers
return exports
