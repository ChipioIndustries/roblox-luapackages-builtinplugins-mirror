-- ROBLOX upstream: https://github.com/apollographql/apollo-client/blob/v3.4.2/src/react/components/index.ts
local exports = {}
exports.Query = require(script.Query).Query
exports.Mutation = require(script.Mutation).Mutation
-- ROBLOX TODO: subscriptions are not supported yet
-- exports.Subscription = require(script.Subscription).Subscription

local typesModule = require(script.types)
export type QueryComponentOptions<TData, TVariables> = typesModule.QueryComponentOptions<TData, TVariables>
export type MutationComponentOptions<TData, TVariables, TContext, TCache> = typesModule.MutationComponentOptions<
	TData,
	TVariables,
	TContext,
	TCache
>
export type SubscriptionComponentOptions<TData, TVariables> = typesModule.SubscriptionComponentOptions<
	TData,
	TVariables
>

return exports
