RegisterCommand("imapsearch", function(source, args, raw)
	local radius = tonumber(args[1]) or 10.0

	CreateThread(function()
		local coords = GetEntityCoords(PlayerPedId())

		print(string.format("Started search at %.2f, %.2f, %.2f ...", coords.x, coords.y, coords.z))

		local imaps = {}

		for imap, info in pairs(Imaps) do
			table.insert(imaps, {
				hash = imap,
				hashname = info.hashname,
				x = info.x,
				y = info.y,
				z = info.z
			})
		end

		for i = 1, #imaps do
			local distance = #(coords - vector3(imaps[i].x, imaps[i].y, imaps[i].z))

			if distance <= radius then
				local status = IsImapActive(imaps[i].hash) and "active" or "inactive"

				print(string.format("%10d %8s %s", imaps[i].hash, status, imaps[i].hashname))
			end

			if i % 100 == 0 then
				Wait(0)
			end
		end

		print("Done")
	end)
end)

CreateThread(function()
	TriggerEvent("chat:addSuggestion", "/imapsearch", "Search for nearby imaps", {
		{name = "radius", help = "Radius around you to search (default: 10.0)"}
	})
end)
