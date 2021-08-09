RegisterNetEvent("iplsearch:search")

function IsIplActiveHash(iplHash)
	Citizen.InvokeNative(0xD779B9B910BD3B7C, iplHash)
end

AddEventHandler("iplsearch:search", function(radius)
	Citizen.CreateThread(function()
		local coords = GetEntityCoords(PlayerPedId())

		print(string.format("Started search at %.2f, %.2f, %.2f ...", coords.x, coords.y, coords.z))

		local ipls = {}

		for ipl, info in pairs(Ipls) do
			table.insert(ipls, {
				hash = ipl,
				hashname = info.hashname,
				x = info.x,
				y = info.y,
				z = info.z
			})
		end

		for i = 1, #ipls do
			local distance = #(coords - vector3(ipls[i].x, ipls[i].y, ipls[i].z))

			if distance <= radius then
				local status = IsIplActiveHash(ipls[i].hash) and "active" or "inactive"

				print(string.format("%10d %8s %s", ipls[i].hash, status, ipls[i].hashname))
			end

			if i % 100 == 0 then
				Citizen.Wait(0)
			end
		end

		print("Done")
	end)
end)

Citizen.CreateThread(function()
	TriggerEvent("chat:addSuggestion", "/iplsearch", "Search for nearby IPLs", {
		{name = "radius", help = "Radius around you to search (default: 10.0)"}
	})
end)
