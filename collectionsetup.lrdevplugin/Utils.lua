-- Access the Lightroom SDK namespaces.
local LrApplication = import 'LrApplication'

-- Initialize the Logger
local logger = import 'LrLogger'( 'CollectionSetup' )

-- Access the Project namespaces.
require "LoggerConfig"

-- Get the activeCatalog
local catalog = LrApplication.activeCatalog()

------------------------------------------------------------------------------
Utils = {}
------------------------------------------------------------------------------

function Utils.findCollectionSet(name)
	sets = catalog:getChildCollectionSets()
	for i,v in ipairs(sets) do
		logger:trace(v:getName())
  	if name == v:getName() then return v end
  end
end

function Utils.makeCollectionSet(name, parent, errorString)
	local collectionSet = catalog:createCollectionSet(name, parent, true)
	if collectionSet == nil then
		logger:error(errorString)
	end

	return collectionSet
end

function Utils.isNotEmpty(string)
  if string == nil or string == '' then return false end

  return true
end

function Utils.Guard(condition, errorString)
	if not condition then
		logger:error(errorString)
	end

	return condition
end

function Utils.getCollectionSets(sets, t, depth)
    local indent = string.rep("  ", depth)
    if sets ~= nil then
        for _,set in ipairs(sets) do
            info = {
                id = set.localIdentifier,
                name = set:getName()
            }
            table.insert(t, {title = (indent .. set:getName()), value = info})
            Utils.getCollectionSets(set:getChildCollectionSets(), t, depth + 1)
        end
    end
end

function Utils.isValidDate(dateString)
	local y, m, d = dateString:match("(%d+)-(%d+)-(%d+)")
	if y == nil or m == nil or d == nil then return false end

	m, d, y = tonumber(m), tonumber(d), tonumber(y)
	logger:trace(dateString, tostring(m), tostring(y), tostring(d))
	if d <= 0 or d > 31 or m <= 0 or m > 12 or y <= 0 then
    	return false
	end

	return true
end

function Utils.print_r(arr, indentLevel)
    local str = ""
    local indentStr = "#"

    if(indentLevel == nil) then
        logger:trace(Utils.print_r(arr, 0))
        return
    end

    for i = 0, indentLevel do
        indentStr = indentStr.."\t"
    end

    for index,value in pairs(arr) do
        if type(value) == "table" then
            str = str..indentStr..index..": \n"..Utils.print_r(value, (indentLevel + 1))
        else
            str = str..indentStr..index..": "..value.."\n"
        end
    end

    return str
end

return Utils
