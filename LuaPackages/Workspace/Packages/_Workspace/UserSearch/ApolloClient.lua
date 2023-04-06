--[[
	Package link auto-generated by Rotriever
]]
local PackageIndex = script.Parent.Parent.Parent._Workspace

local Package = require(PackageIndex["ApolloClient"]["ApolloClient"])

export type ApolloCache<TSerialized> = Package.ApolloCache<TSerialized> 
export type ApolloClient<TCacheShape> = Package.ApolloClient<TCacheShape> 
export type ApolloClientOptions<TCacheShape> = Package.ApolloClientOptions<TCacheShape> 
export type ApolloError = Package.ApolloError
export type ApolloLink = Package.ApolloLink
export type ApolloQueryResult<T> = Package.ApolloQueryResult<T> 
export type ApolloReducerConfig = Package.ApolloReducerConfig
export type Cache_DiffResult<T> = Package.Cache_DiffResult<T> 
export type Cache_WatchCallback = Package.Cache_WatchCallback
export type Cache_ReadOptions<TVariables, TData> = Package.Cache_ReadOptions<TVariables, TData> 
export type Cache_WriteOptions<TResult, TVariables> = Package.Cache_WriteOptions<TResult, TVariables> 
export type Cache_DiffOptions = Package.Cache_DiffOptions
export type Cache_WatchOptions<Watcher> = Package.Cache_WatchOptions<Watcher> 
export type Cache_EvictOptions = Package.Cache_EvictOptions
export type Cache_ModifyOptions = Package.Cache_ModifyOptions
export type Cache_BatchOptions<C> = Package.Cache_BatchOptions<C> 
export type Cache_ReadQueryOptions<TData, TVariables> = Package.Cache_ReadQueryOptions<TData, TVariables> 
export type Cache_ReadFragmentOptions<TData, TVariables> = Package.Cache_ReadFragmentOptions<TData, TVariables> 
export type Cache_WriteQueryOptions<TData, TVariables> = Package.Cache_WriteQueryOptions<TData, TVariables> 
export type Cache_WriteFragmentOptions<TData, TVariables> = Package.Cache_WriteFragmentOptions<TData, TVariables> 
export type Cache_Fragment<TData, TVariables> = Package.Cache_Fragment<TData, TVariables> 
export type DataProxy = Package.DataProxy
export type DataProxy_Query<TVariables, TData> = Package.DataProxy_Query<TVariables, TData> 
export type DataProxy_Fragment<TVariables, TData> = Package.DataProxy_Fragment<TVariables, TData> 
export type DataProxy_ReadQueryOptions<TData, TVariables> = Package.DataProxy_ReadQueryOptions<TData, TVariables> 
export type DataProxy_ReadFragmentOptions<TData, TVariables> = Package.DataProxy_ReadFragmentOptions<TData, TVariables> 
export type DataProxy_WriteOptions<TData> = Package.DataProxy_WriteOptions<TData> 
export type DataProxy_WriteQueryOptions<TData, TVariables> = Package.DataProxy_WriteQueryOptions<TData, TVariables> 
export type DataProxy_WriteFragmentOptions<TData, TVariables> = Package.DataProxy_WriteFragmentOptions<TData, TVariables> 
export type DataProxy_DiffResult<T> = Package.DataProxy_DiffResult<T> 
export type DefaultContext = Package.DefaultContext
export type DefaultOptions = Package.DefaultOptions
export type DiffQueryAgainstStoreOptions = Package.DiffQueryAgainstStoreOptions
export type DocumentNode = Package.DocumentNode
export type ErrorPolicy = Package.ErrorPolicy
export type FetchMoreOptions<TData, TVariables> = Package.FetchMoreOptions<TData, TVariables> 
export type FetchMoreQueryOptions<TVariables, TData> = Package.FetchMoreQueryOptions<TVariables, TData> 
export type FetchPolicy = Package.FetchPolicy
export type FetchResult<TData, C, E> = Package.FetchResult<TData, C, E> 
export type FieldFunctionOptions<TArgs, TVars> = Package.FieldFunctionOptions<TArgs, TVars> 
export type FieldMergeFunction<T, V> = Package.FieldMergeFunction<T, V> 
export type FieldPolicy<TExisting, TIncoming, TReadResult> = Package.FieldPolicy<TExisting, TIncoming, TReadResult> 
export type FieldReadFunction<T, V> = Package.FieldReadFunction<T, V> 
export type FragmentMatcher = Package.FragmentMatcher
export type GraphQLRequest = Package.GraphQLRequest
export type HttpLink = Package.HttpLink
export type HttpOptions = Package.HttpOptions
export type IdGetterObj = Package.IdGetterObj
export type IdGetter = Package.IdGetter
export type InMemoryCache = Package.InMemoryCache
export type InMemoryCacheConfig = Package.InMemoryCacheConfig
export type InternalRefetchQueriesInclude = Package.InternalRefetchQueriesInclude
export type InternalRefetchQueriesMap<TResult> = Package.InternalRefetchQueriesMap<TResult> 
export type InternalRefetchQueriesOptions<TCache, TResult> = Package.InternalRefetchQueriesOptions<TCache, TResult> 
export type InternalRefetchQueriesResult<TResult> = Package.InternalRefetchQueriesResult<TResult> 
export type InternalRefetchQueryDescriptor = Package.InternalRefetchQueryDescriptor
export type MergeInfo = Package.MergeInfo
export type MergeTree = Package.MergeTree
export type MissingFieldError = Package.MissingFieldError
export type MutationOptions<TData, TVariables, TContext, TCache> = Package.MutationOptions<TData, TVariables, TContext, TCache> 
export type MutationQueryReducer<T> = Package.MutationQueryReducer<T> 
export type MutationQueryReducersMap<T> = Package.MutationQueryReducersMap<T> 
export type MutationUpdaterFunction<TData, TVariables, TContext, TCache> = Package.MutationUpdaterFunction<TData, TVariables, TContext, TCache> 
export type NetworkStatus = Package.NetworkStatus
export type NextLink = Package.NextLink
export type NormalizedCache = Package.NormalizedCache
export type NormalizedCacheObject = Package.NormalizedCacheObject
export type Observable<T> = Package.Observable<T> 
export type Observer<T> = Package.Observer<T> 
export type ObservableQuery<TData, TVariables> = Package.ObservableQuery<TData, TVariables> 
export type ObservableSubscription = Package.ObservableSubscription
export type OnQueryUpdated<TResult> = Package.OnQueryUpdated<TResult> 
export type Operation = Package.Operation
export type OperationVariables = Package.OperationVariables
export type OptimisticStoreItem = Package.OptimisticStoreItem
export type PossibleTypesMap = Package.PossibleTypesMap
export type PureQueryOptions = Package.PureQueryOptions
export type QueryListener = Package.QueryListener
export type QueryOptions<TVariables, TData> = Package.QueryOptions<TVariables, TData> 
export type ReactiveVar<T> = Package.ReactiveVar<T> 
export type ReadMergeModifyContext = Package.ReadMergeModifyContext
export type ReadQueryOptions = Package.ReadQueryOptions
export type Reference = Package.Reference
export type RefetchQueriesInclude = Package.RefetchQueriesInclude
export type RefetchQueriesOptions<TCache, TResult> = Package.RefetchQueriesOptions<TCache, TResult> 
export type RefetchQueriesPromiseResults<TResult> = Package.RefetchQueriesPromiseResults<TResult> 
export type RefetchQueriesResult<TResult> = Package.RefetchQueriesResult<TResult> 
export type RefetchQueryDescriptor = Package.RefetchQueryDescriptor
export type RequestHandler = Package.RequestHandler
export type Resolver = Package.Resolver
export type Resolvers = Package.Resolvers
export type ServerError = Package.ServerError
export type ServerParseError = Package.ServerParseError
export type StoreObject = Package.StoreObject
export type StoreValue = Package.StoreValue
export type SubscribeToMoreOptions<TData, TSubscriptionVariables, TSubscriptionData> = Package.SubscribeToMoreOptions<TData, TSubscriptionVariables, TSubscriptionData> 
export type SubscriptionOptions<TVariables, TData> = Package.SubscriptionOptions<TVariables, TData> 
export type Transaction<T> = Package.Transaction<T> 
export type TypePolicies = Package.TypePolicies
export type TypePolicy = Package.TypePolicy
export type TypedDocumentNode<Result, Variables> = Package.TypedDocumentNode<Result, Variables> 
export type UpdateQueryOptions<TVariables> = Package.UpdateQueryOptions<TVariables> 
export type UriFunction = Package.UriFunction
export type WatchQueryFetchPolicy = Package.WatchQueryFetchPolicy
export type WatchQueryOptions<TVariables, TData> = Package.WatchQueryOptions<TVariables, TData> 
export type ApolloContextValue = Package.ApolloContextValue
export type BaseMutationOptions<TData, TVariables, TContext, TCache> = Package.BaseMutationOptions<TData, TVariables, TContext, TCache> 
export type BaseQueryOptions<TVariables> = Package.BaseQueryOptions<TVariables> 
export type BaseSubscriptionOptions<TData, TVariables> = Package.BaseSubscriptionOptions<TData, TVariables> 
export type CommonOptions<TOptions> = Package.CommonOptions<TOptions> 
export type Context = Package.Context
export type DocumentType = Package.DocumentType
export type IDocumentDefinition = Package.IDocumentDefinition
export type LazyQueryHookOptions<TData, TVariables> = Package.LazyQueryHookOptions<TData, TVariables> 
export type LazyQueryResult<TData, TVariables> = Package.LazyQueryResult<TData, TVariables> 
export type MutationDataOptions<TData, TVariables, TContext, TCache> = Package.MutationDataOptions<TData, TVariables, TContext, TCache> 
export type MutationFunction<TData, TVariables, TContext, TCache> = Package.MutationFunction<TData, TVariables, TContext, TCache> 
export type MutationFunctionOptions<TData, TVariables, TContext, TCache> = Package.MutationFunctionOptions<TData, TVariables, TContext, TCache> 
export type MutationHookOptions<TData, TVariables, TContext, TCache> = Package.MutationHookOptions<TData, TVariables, TContext, TCache> 
export type MutationResult<TData> = Package.MutationResult<TData> 
export type MutationTuple<TData, TVariables, TContext, TCache> = Package.MutationTuple<TData, TVariables, TContext, TCache> 
export type ObservableQueryFields<TData, TVariables> = Package.ObservableQueryFields<TData, TVariables> 
export type OnSubscriptionDataOptions<TData> = Package.OnSubscriptionDataOptions<TData> 
export type QueryDataOptions<TData, TVariables> = Package.QueryDataOptions<TData, TVariables> 
export type QueryFunctionOptions<TData, TVariables> = Package.QueryFunctionOptions<TData, TVariables> 
export type QueryHookOptions<TData, TVariables> = Package.QueryHookOptions<TData, TVariables> 
export type QueryLazyOptions<TVariables> = Package.QueryLazyOptions<TVariables> 
export type QueryResult<TData, TVariables> = Package.QueryResult<TData, TVariables> 
export type QueryTuple<TData, TVariables> = Package.QueryTuple<TData, TVariables> 
export type RefetchQueriesFunction = Package.RefetchQueriesFunction
export type SubscriptionCurrentObservable = Package.SubscriptionCurrentObservable
export type SubscriptionDataOptions<TData, TVariables> = Package.SubscriptionDataOptions<TData, TVariables> 
export type SubscriptionHookOptions<TData, TVariables> = Package.SubscriptionHookOptions<TData, TVariables> 
export type SubscriptionResult<TData> = Package.SubscriptionResult<TData> 


return Package