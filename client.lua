function IsPositionInsideImapStreamingExtents(imap, x, y, z)
	return Citizen.InvokeNative(0x73B40D97D7BAAD77, imap, x, y, z)
end

RegisterCommand('imapsearch', function(source, args, raw)
	CreateThread(function()
		local coords = GetEntityCoords(PlayerPedId())

		print(string.format('Started searching for Imaps at %.2f, %.2f, %.2f ...', coords.x, coords.y, coords.z))

		local imaps = {}
		for imap, info in pairs(Imaps) do
			table.insert(imaps, {hash = imap, x = info.x, y = info.y, z = info.z})
		end

		for i = 1, #imaps do
			local distance = #(coords - vector3(imaps[i].x, imaps[i].y, imaps[i].z))

			if distance <= 10.0 then
				print(imaps[i].hash, IsImapActive(imaps[i].hash) and 'active' or 'deactive')
			end

			if i % 100 == 0 then
				Wait(0)
			end
		end

		print('Done')
	end)
end)
