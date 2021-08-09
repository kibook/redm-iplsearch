RegisterCommand("iplsearch", function(source, args, raw)
	local radius = tonumber(args[1]) or 10.0

	TriggerClientEvent("iplsearch:search", source, radius)
end, true)
