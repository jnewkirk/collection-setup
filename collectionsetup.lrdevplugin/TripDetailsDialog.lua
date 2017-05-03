-- Access the Lightroom SDK namespaces.
local LrApplication = import 'LrApplication'
local LrFunctionContext = import 'LrFunctionContext'
local LrBinding = import 'LrBinding'
local LrDialogs = import 'LrDialogs'
local LrView = import 'LrView'
local LrColor = import 'LrColor'

local logger = import 'LrLogger'( 'CollectionSetup' )

require "LoggerConfig"
require "CollectionSetup"

TripDetailsDialog = {}

function TripDetailsDialog.show()
	return LrFunctionContext.callWithContext( "CreateCollectionDialog", function(context)

		local f = LrView.osFactory()
		local catalog = LrApplication.activeCatalog ()

		local properties = LrBinding.makePropertyTable( context )
		properties.parentName = nil
		properties.tripName = "Trip Name"
		properties.startDate = os.date("%Y-%m-%d", os.time())
		properties.endDate = os.date("%Y-%m-%d", os.time() + (3600 * 24))
		properties.checkbox_state = 'unchecked'

		properties.collection_items = {}
		Utils.getCollectionSets(catalog:getChildCollectionSets(), properties.collection_items, 0)

		local contents = f:view
		{
			spacing = f:control_spacing(),
			bind_to_object = properties,

			f:group_box
			{
				spacing = f:control_spacing(),
				fill_horizontal = 1,

				f:row
				{
					spacing = f:label_spacing(),
					f:static_text
					{
						title = "Name: ",
						font = "<system/bold>",
						width = LrView.share "label_width",
					},

					f:edit_field
					{
						fill_horizontal = 1,
						value = LrView.bind( 'tripName' ),
						font = "<system>",
						validate = function (f, value)
							return Utils.isNotEmpty(value), value, "You must enter the name"
						end
					},
				},
				f:spacer
				{
					height = 2,
				},
				f:group_box
				{
					title = "Location",
					spacing = f:control_spacing(),
					font = "<system>",
					fill_horizontal = 1,

					f:checkbox
					{
						title = "Inside a Collection Set",
						checked_value = "checked",
						unchecked_value = "unchecked",
						value = LrView.bind('checkbox_state'),
						font = "<system>",
					},
					f:popup_menu
					{
						value = LrView.bind('collection_value'),
						items = LrView.bind('collection_items'),
						fill_horizontal = 1,
						font = "<system>",
						immediate = true,
						enabled = LrBinding.keyEquals('checkbox_state', "checked"),
					},
				},
			},
			f:spacer
			{
				height = 2,
			},
			f:group_box
			{
				spacing = f:control_spacing(),
				fill_horizontal = 1,
				title = "Capture Dates",
				font = "<system>",

				f:row
      			{
					spacing = f:label_spacing(),
        			f:static_text
        			{
          				title = "Start Date:",
          				alignment = 'right',
						font = "<system/bold>",
						width = LrView.share "label_width",
        			},
        			f:edit_field
        			{
						tooltip = "e.g. 2017-05-05",
          				width_in_chars = 18,
						fill_horizontal = 1,
          				value = LrView.bind( 'startDate' ),
						validate = function(f, value)
							return Utils.isValidDate(value), value, value .. " is invalid, e.g. 2017-05-05"
						end
        			},
				},
				f:row
      			{
					spacing = f:label_spacing(),
        			f:static_text
        			{
          				title = "End Date:",
          				alignment = 'right',
						font = "<system/bold>",
						width = LrView.share "label_width",
        			},

        			f:edit_field
        			{
						tooltip = "e.g. 2017-05-05",
          				width_in_chars = 18,
						fill_horizontal = 1,
          				value = LrView.bind( 'endDate' ),
						font = "<system>",
						validate = function(f, value)
							return Utils.isValidDate(value), value, value .. " is invalid, e.g. 2017-05-05"
						end
        			},
				},
			},
		}

	    local dialogResult = LrDialogs.presentModalDialog(
      	{
			title = "Trip Details",
			resizeable = "false",
			contents = contents,
          	actionVerb = "Create",
		} )

		if dialogResult == 'ok' then
			if properties.collection_value ~= nil then
				properties.parentName = properties.collection_value.name
			end
			return 'ok', properties
		end

		return nil
	end )
end

return TripDetailsDialog
