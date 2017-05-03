-- Access the Lightroom SDK namespaces.
local LrApplication 	= import 'LrApplication'
local LrBinding 		= import 'LrBinding'
local LrDialogs         = import 'LrDialogs'
local LrErrors          = import 'LrErrors'
local LrFunctionContext = import 'LrFunctionContext'
local LrLogger          = import 'LrLogger'
local LrTasks           = import 'LrTasks'

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
        local parentName = nil
        if properties.collection_value ~= nil then
            logger:trace("Location: " .. properties.collection_value.name)
            parentName = properties.collection_value.name
        end

		CollectionSetup.run(
			properties.tripName,
            parentName,
			properties.startDate,
			properties.endDate)
	end
end)
