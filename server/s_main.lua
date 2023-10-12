ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

Storesystem = {}

function Storesystem:Init()
    ESX.RegisterServerCallback('lowkey_storesystem:hasMoney', function(source, callback, price, basket)
        local player = ESX.GetPlayerFromId(source); 

        if not player then return end;

        if player.getMoney() >= price then 
            player.removeMoney(price); 
            
            if basket and #basket > 0 then 
                for _, item in pairs(basket) do 
                    player.addInventoryItem(item.item, item.amount); 
                end
            end

            callback(true); 
        else 
            callback(false); 
        end
    end)
end

Citizen.CreateThread(function()
    Storesystem:Init()
end)