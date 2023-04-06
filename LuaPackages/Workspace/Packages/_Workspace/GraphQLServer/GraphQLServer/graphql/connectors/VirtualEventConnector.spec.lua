local GraphQLServer = script:FindFirstAncestor("GraphQLServer")

local JestGlobals = require(GraphQLServer.Parent.Dev.JestGlobals)
local expect = JestGlobals.expect
local RecordPlayback = require(GraphQLServer.Parent.Dev.RecordPlayback)
local buildFetch = require(GraphQLServer.Parent.Fetch).buildFetch
local GraphqlHttpArtifacts = require(GraphQLServer.Parent.Dev.GraphqlHttpArtifacts)
local VirtualEventConnector = require(script.Parent.VirtualEventConnector)
local findVirtualEventById = VirtualEventConnector.findVirtualEventById
local findVirtualEventsByUniverseId = VirtualEventConnector.findVirtualEventsByUniverseId
local findRsvpsByVirtualEventId = VirtualEventConnector.findRsvpsByVirtualEventId
local findRsvpCountersByVirtualEventId = VirtualEventConnector.findRsvpCountersByVirtualEventId
local updateRsvpStatus = VirtualEventConnector.updateRsvpStatus
local neverShowNotificationModalAgain = VirtualEventConnector.neverShowNotificationModalAgain
local enablePushNotifications = VirtualEventConnector.enablePushNotifications

return function()
	local create = nil

	beforeAll(function()
		create = RecordPlayback.createRecordPlayback({
			-- the path must point to the instance in the DataModel used here
			instanceParent = GraphqlHttpArtifacts,
			fileSystemPath = "modules/graphql/http-artifacts/src",
		})
	end)

	describe("fetch VirtualEvent", function()
		it("should fetch a VirtualEvent", function()
			create("virtual-event-success"):execute(function(httpService)
				local fetchImpl = buildFetch(httpService)
				local virtualEvent = findVirtualEventById("813902335774097414", fetchImpl):expect()

				expect(virtualEvent).toBeDefined()
				expect(virtualEvent.id).toEqual("813902335774097414")
			end)
		end)

		it("should throw if a VirtualEvent cannot be found", function()
			create("virtual-event-fail"):execute(function(httpService)
				local capturedError
				local fetchImpl = buildFetch(httpService)

				findVirtualEventById("badVirtualEvent", fetchImpl)
					:catch(function(err)
						capturedError = err
					end)
					:expect()

				expect(capturedError).toBeDefined()
				expect(capturedError.message).toEqual("Failed to find VirtualEvent matching id: badVirtualEvent.")
			end)
		end)
	end)

	describe("fetch VirtualEvents by universeId", function()
		it("should fetch all VirtualEvents for an experience", function()
			create("virtual-events-for-experience-success"):execute(function(httpService)
				local fetchImpl = buildFetch(httpService)
				local virtualEventsPage = findVirtualEventsByUniverseId(2183742951, nil, fetchImpl):expect()

				expect(virtualEventsPage).toBeDefined()
				assert(virtualEventsPage, "")

				expect(virtualEventsPage.cursor).toBeDefined()
				expect(virtualEventsPage.virtualEvents).toBeDefined()
				assert(virtualEventsPage.virtualEvents, "")

				expect(#virtualEventsPage.virtualEvents).toBe(3)
			end)
		end)

		it("should throw if the experience can't be found", function()
			create("virtual-events-for-experience-fail"):execute(function(httpService)
				local capturedError
				local fetchImpl = buildFetch(httpService)
				local virtualEventsPage = findVirtualEventsByUniverseId(-1, nil, fetchImpl)
					:catch(function(err)
						capturedError = err
					end)
					:expect()

				expect(virtualEventsPage).toBeNil()
				expect(capturedError).toBeDefined()
				expect(capturedError.message).toEqual("Failed to find experience matching universeId: -1")
			end)
		end)
	end)

	describe("fetch RSVPs", function()
		it("should fetch a VirtualEvent's list of RSVPs", function()
			create("virtual-event-rsvps-success"):execute(function(httpService)
				local fetchImpl = buildFetch(httpService)
				local rsvps = findRsvpsByVirtualEventId("813902335774097414", fetchImpl):expect()

				expect(rsvps).toBeDefined()
				expect(#rsvps).toBe(4)
			end)
		end)

		it("should throw on failure", function()
			create("virtual-event-rsvps-fail"):execute(function(httpService)
				local capturedError
				local fetchImpl = buildFetch(httpService)

				findRsvpsByVirtualEventId("badVirtualEvent", fetchImpl)
					:catch(function(err)
						capturedError = err
					end)
					:expect()

				expect(capturedError).toBeDefined()
				expect(capturedError.message).toEqual("Failed to find RSVPs matching VirtualEvent id: badVirtualEvent.")
			end)
		end)
	end)

	describe("fetch RSVP counters", function()
		it("should return the VirtualEvent's RSVP counters", function()
			create("virtual-event-rsvp-counters-success"):execute(function(httpService)
				local fetchImpl = buildFetch(httpService)
				local rsvpCounters = findRsvpCountersByVirtualEventId("813902335774097414", fetchImpl):expect()

				expect(rsvpCounters).toBeDefined()
				expect(rsvpCounters.none).toBe(0)
				expect(rsvpCounters.maybeGoing).toBe(0)
				expect(rsvpCounters.going).toBe(4)
				expect(rsvpCounters.notGoing).toBe(4)
			end)
		end)

		it("should throw on failure", function()
			create("virtual-event-rsvp-counters-fail"):execute(function(httpService)
				local capturedError
				local fetchImpl = buildFetch(httpService)

				findRsvpCountersByVirtualEventId("badVirtualEvent", fetchImpl)
					:catch(function(err)
						capturedError = err
					end)
					:expect()

				expect(capturedError).toBeDefined()
				expect(capturedError.message).toEqual(
					"Failed to find RSVP counters matching VirtualEvent id: badVirtualEvent."
				)
			end)
		end)
	end)

	describe("update RSVP status", function()
		it("should return the RsvpResponse type", function()
			create("virtual-event-update-rsvp-success"):execute(function(httpService)
				local fetchImpl = buildFetch(httpService)
				local res = updateRsvpStatus("832582841240813598", "going", fetchImpl):expect()

				expect(res.virtualEvent).toEqual({
					id = "832582841240813598",
					userRsvpStatus = "going",
				})
			end)
		end)

		it("should error for bad VirtualEvent ID", function()
			create("virtual-event-update-rsvp-fail"):execute(function(httpService)
				local capturedError
				local fetchImpl = buildFetch(httpService)

				updateRsvpStatus("badVirtualEvent", "going", fetchImpl)
					:catch(function(err)
						capturedError = err
					end)
					:expect()

				expect(capturedError).toBeDefined()
				expect(capturedError.message).toEqual(
					"Failed to set RSVP status matching VirtualEvent id: badVirtualEvent."
				)
			end)
		end)
	end)

	describe("update modal history", function()
		it("should return true on success", function()
			create("virtual-event-modal-history-success"):execute(function(httpService)
				local fetchImpl = buildFetch(httpService)
				local res = neverShowNotificationModalAgain(fetchImpl):expect()

				expect(res).toBe(true)
			end)
		end)

		it("should error if something goes wrong on the server", function()
			create("virtual-event-modal-history-fail"):execute(function(httpService)
				local capturedError
				local fetchImpl = buildFetch(httpService)

				neverShowNotificationModalAgain(fetchImpl)
					:catch(function(err)
						capturedError = err
					end)
					:expect()

				expect(capturedError).toBeDefined()
				expect(capturedError.message).toEqual("Failed to update modal history")
			end)
		end)
	end)

	describe("update notification preferences", function()
		it("should return true on success", function()
			create("virtual-event-notification-preferences-success"):execute(function(httpService)
				local fetchImpl = buildFetch(httpService)
				local res = enablePushNotifications(fetchImpl):expect()

				expect(res).toBe(true)
			end)
		end)

		it("should error if something goes wrong on the server", function()
			create("virtual-event-notification-preferences-fail"):execute(function(httpService)
				local capturedError
				local fetchImpl = buildFetch(httpService)

				enablePushNotifications(fetchImpl)
					:catch(function(err)
						capturedError = err
					end)
					:expect()

				expect(capturedError).toBeDefined()
				expect(capturedError.message).toEqual("Failed to update notification preferences")
			end)
		end)
	end)
end
