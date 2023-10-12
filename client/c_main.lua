ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    Storesystem:Init()
end)
