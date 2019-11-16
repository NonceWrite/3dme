Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/me', 'test me.')
end)

Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/do', 'test do.')
end)


local nbrDisplaying = 1

RegisterCommand('me', function(source, args, raw, user)
    local text = string.sub(raw, 4)
    TriggerServerEvent('3dme:shareMeDisplay', '[ME] ' ..text)
end)

RegisterCommand('do', function(source, args, raw, user)
    local text = string.sub(raw, 4)
    TriggerServerEvent('3dme:shareDoDisplay', '[DO] ' ..text)
end)


RegisterNetEvent('3dme:triggerMeDisplay')
AddEventHandler('3dme:triggerMeDisplay', function(text, source)
    local offset = 1 + (nbrDisplaying*0.15)
    Display(GetPlayerFromServerId(source), text, offset)
end)

RegisterNetEvent('3dme:triggerDoDisplay')
AddEventHandler('3dme:triggerDoDisplay', function(text, source)
    local offset = 1 + (nbrDisplaying*0.15)
    DisplayDo(GetPlayerFromServerId(source), text, offset)
end)

function Display(mePlayer, text, offset)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(5000)
        displaying = false
    end)
	
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 500 then
                 DrawText3DMe(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset-1.250, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DisplayDo(mePlayer, text, offset)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(5000)
        displaying = false
    end)
	
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 500 then
                 DrawText3DDo(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset-1.400, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DrawText3DMe(x,y,z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
  local scale = (1 / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov
  if onScreen then
		SetTextScale(0.45, 0.45)
		SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 16, 20, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		-- local factor = (string.len(text)) / 370
		-- DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
    end
end

    function DrawText3DDo(x,y,z, text)
        local onScreen, _x, _y = World3dToScreen2d(x, y, z)
        local p = GetGameplayCamCoords()
        local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
        local scale = (1 / distance) * 2
        local fov = (1 / GetGameplayCamFov()) * 100
        local scale = scale * fov
        if onScreen then
              SetTextScale(0.45, 0.45)
              SetTextFont(4)
              SetTextProportional(1)
              SetTextColour(16, 92, 255, 215)
              SetTextEntry("STRING")
              SetTextCentre(1)
              AddTextComponentString(text)
              DrawText(_x,_y)
              -- local factor = (string.len(text)) / 370
              -- DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
          end
end
