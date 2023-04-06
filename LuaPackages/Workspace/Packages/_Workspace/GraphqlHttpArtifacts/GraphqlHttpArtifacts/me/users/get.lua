return {
	request = {
		cachePolicy = Enum.HttpCachePolicy.None,
		headers = {},
		method = "GET",
		url = {
			host = "users.roblox.com",
			path = "/v1/users/1",
			query = {},
			scheme = "https",
		},
	},
	response = {
		body = '{"description":"Welcome to the Roblox profile! This is where you can check out the newest items in the catalog, and get a jumpstart on exploring and building on our Imagination Platform. If you want news on updates to the Roblox platform, or great new experiences to play with friends, check out blog.roblox.com. Please note, this is an automated account. If you need to reach Roblox for any customer service needs find help at www.roblox.com/help","created":"2006-02-27T21:06:40.3Z","isBanned":false,"externalAppDisplayName":null,"hasVerifiedBadge":true,"id":1,"name":"Roblox","displayName":"Roblox"}',
		headers = {
			["cache-control"] = "no-cache",
			["content-length"] = "601",
			["content-type"] = "application/json; charset=utf-8",
			["report-to"] = '{"group":"network-errors","max_age":604800,"endpoints":[{"url":"https://ncs.roblox.com/upload"}]}',
			["roblox-machine-id"] = "CHI1-WEB913",
			["x-frame-options"] = "SAMEORIGIN",
			["x-powered-by"] = "ASP.NET",
			date = "Thu, 01 Dec 2022 18:51:44 GMT",
			nel = '{"report_to":"network-errors","max_age":604800,"success_fraction":0.001,"failure_fraction":1}',
			p3p = 'CP="CAO DSP COR CURa ADMa DEVa OUR IND PHY ONL UNI COM NAV INT DEM PRE"',
			server = "Microsoft-IIS/8.5",
		},
		isCached = false,
		stats = {
			durations = {
				SSLHandshake = 0,
				connect = 0,
				inQueue = 0.000013503999999997518,
				makeRequest = 0.00004,
				nameLookup = 0.000045,
				receiveResponse = 0.116155,
				roundTripTime = 0.1162843269999998,
			},
			retried = false,
		},
		status = {
			code = 200,
			message = "OK",
		},
		type = "internal-response",
	},
}
