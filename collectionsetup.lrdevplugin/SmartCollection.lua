
------------------------------------------------------------------------------
SmartCollection = {}
------------------------------------------------------------------------------

function SmartCollection.all(startDate, endDate)
	return
	{
  		{
			criteria = "captureTime",
			operation = "in",
			value = startDate,
			value2 = endDate,
  		}
	}
end

function SmartCollection.pick(startDate, endDate)
	return
	{
  		{
			criteria = "captureTime",
			operation = "in",
			value = startDate,
			value2 = endDate,
  		},
		{
			criteria = "pick",
			operation = "==",
			value = 1,
		},
		combine = "intersect"
	}
end

function SmartCollection.tiff(startDate, endDate)
	return
	{
  		{
			criteria = "captureTime",
			operation = "in",
			value = startDate,
			value2 = endDate,
  		},
		{
			criteria = "fileFormat",
			operation = "==",
			value = "TIFF",
		},
		combine = "intersect"
	}
end

function SmartCollection.select(startDate, endDate)
	return
	{
  		{
			criteria = "captureTime",
			operation = "in",
			value = startDate,
			value2 = endDate,
  		},
		{
			criteria = "fileFormat",
			operation = "==",
			value = "TIFF",
		},
		{
			criteria = "pick",
			operation = "==",
			value = 1,
		},
		combine = "intersect"
	}
end

return SmartCollection
