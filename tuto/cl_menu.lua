local PlayerData, CurrentActionData, HandcuffTimer, dragStatus, blipsCops, currentTask, spawnedVehicles = {}, {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, isHandcuffed, hasAlreadyJoined, playerInService, isInShopMenu = false, false, false, false, false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
dragStatus.isDragged = false
ESX = nil
locksound = false
onDuty = false
local ex = true

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports["es_extended"]:getSharedObject()
		Citizen.Wait(0)
	end


	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)


local exemple = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 0, 0}, Title = "Flash Admin" },
	Data = { currentMenu = "interaction" },
	Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

			local slide = btn.slidenum

			local btn = btn.name

			local check = btn.unkCheckbox

			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

			local playerPed = PlayerPedId()

			local coords = GetEntityCoords(playerPed)
			if btn == "~g~> Ouvrir le Menu" then
				OpenMenu('TUTO')
			elseif btn == "~r~> Fermer le Menu" then
				CloseMenu(true)
			elseif btn == "~b~> Spawn Sanchez" then
				ExecuteCommand('car sanchez')
			end
		end
},

	Menu = {
		["interaction"] = {
			b = {
				{name = "~g~> Ouvrir le Menu", ask = ">", askX = true},
				{name = "~r~> Fermer le Menu", },
			}
        },
		["TUTO"] = {
			b = {
				{name = "~b~> Spawn Sanchez", ask = ">", askX = true},
			}
        },
	}
}


-- ouvrir  le menu avec une touche.
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if IsControlJustPressed(1, 167) then
			CreateMenu(exemple)
		end
	end
end)