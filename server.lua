RegisterCommand("iplsearch", function(source, args, raw)
	local radius = tonumber(args[1]) or 10.0

	TriggerClientEvent("iplsearch:search", source, radius)
end, true)

RegisterCommand("gotoipl", function(source, args, raw)
	local hash = tonumber(args[1])

	if hash then
		TriggerClientEvent("iplsearch:gotoIpl", -1, hash)
	end
end, true)
