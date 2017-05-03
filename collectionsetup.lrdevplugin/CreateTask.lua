-- Access the Lightroom SDK namespaces.
local LrApplication 	= import 'LrApplication'
local LrDialogs         = import 'LrDialogs'
local LrFunctionContext = import 'LrFunctionContext'
local LrLogger          = import 'LrLogger'

-- Initialize the Logger
local logger = import 'LrLogger'( 'CollectionSetup' )

-- Access the Project namespaces.
require "LoggerConfig"
require "TripDetailsDialog"
require "CollectionSetup"

LrFunctionContext.postAsyncTaskWithContext('CreateTask', function(context)
    LrDialogs.attachErrorDialogToFunctionContext(context)

	-- Get the details
	local result, properties = TripDetailsDialog.show()

	-- Create the collections
	if result == 'ok' then
		CollectionSetup.run(
			properties.tripName,
            properties.parentName,
			properties.startDate,
			properties.endDate)
	end
end)
