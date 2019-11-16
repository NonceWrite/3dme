RegisterServerEvent('3dme:shareMeDisplay')
AddEventHandler('3dme:shareMeDisplay', function(text)
	TriggerClientEvent('3dme:triggerMeDisplay', -1, text, source)
end)

RegisterServerEvent('3dme:shareDoDisplay')
AddEventHandler('3dme:shareDoDisplay', function(text)
	TriggerClientEvent('3dme:triggerDoDisplay', -1, text, source)
end)
