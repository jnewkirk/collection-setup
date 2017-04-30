local LrDialogs = import 'LrDialogs'
local LrApplication = import 'LrApplication'
local LrTasks = import 'LrTasks'

local logger = import 'LrLogger'( 'CollectionSetup' )
local catalog = LrApplication.activeCatalog()

require "LoggerConfig"
require "Utils"
require "SmartCollection"

-------------------------------------------------------------------------------
CollectionSetup = {}
-------------------------------------------------------------------------------

function CollectionSetup.run(locationName, parentName, tripName, startDate, endDate)
	LrTasks.startAsyncTask(function()
		catalog:withWriteAccessDo("build collections",
			function(context)
				local result = Utils.Guard(catalog.hasWriteAccess, "Write access could not be obtained.")
				if result == 'false' then return end

				local errorString = "Unable to create " .. locationName .. " collectionSet"
				local location = Utils.getCollectionSet(locationName, parentName, errorString)
				if location == nil then
					LrDialogs.message(errorString)
					return
				end

				errorString = "Unable to create " .. tripName .. " collectionSet"
				local trip = Utils.makeCollectionSet(tripName, location, errorString)
				if trip == nil then
					LrDialogs.message(errorString)
					return
				end

				all = catalog:createSmartCollection("All",
								SmartCollection.all(startDate, endDate), trip, true)
				pick = catalog:createSmartCollection("Pick",
								SmartCollection.pick(startDate, endDate), trip, true)
				tiff = catalog:createSmartCollection("TIFF",
								SmartCollection.tiff(startDate, endDate), trip, true)
				select = catalog:createSmartCollection("Select",
								SmartCollection.select(startDate, endDate), trip, true)
			end )
	 end )
end
