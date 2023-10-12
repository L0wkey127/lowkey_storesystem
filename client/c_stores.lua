Storesystem = {}; 

function Storesystem:Init()
    for storeId, storeData in pairs(Config.Stores) do 
        self.shopKeeper = Utilites:CreatePed({
            model = storeData.model and storeData.model or 'mp_m_shopkeep_01',
            coords = storeData.ped - vector4(0.0, 0.0, 0.98, 0.0),
        })  

        if storeData.blip then 
            local blip = AddBlipForCoord(storeData.ped.x, storeData.ped.y, storeData.ped.z)

            SetBlipSprite(blip, 52)
            SetBlipScale(blip, 0.65)
    
            SetBlipColour(blip, 2)
            SetBlipAsShortRange(blip, true)
    
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(storeData.label)
            EndTextCommandSetBlipName(blip)
        end
    end

    while true do 
        local playerPed, loopInterval = PlayerPedId(), 1500; 

        for storeId, storeData in pairs(Config.Stores) do 
            local distance = #(GetEntityCoords(playerPed) - storeData.marker); 

            if distance < 5.0 then 
                loopInterval = 5; 

                Utilites:DrawText3D(storeData.marker, ('[~g~E~s~] %s'):format(storeData.label));

                if distance < 1.5 and IsControlJustReleased(0, 38) then 
                    self:LoadStore(storeId);
                end
            end
        end

        Citizen.Wait(loopInterval); 
    end
end

function Storesystem:LoadStore(storeId)
    SetNuiFocus(true, true); 

    SendNUIMessage({
        type = 'display', 
        data = {
            storeId = storeId, 
        }
    })
end

RegisterNUICallback('getProducts', function(data, callback)
    local storeData = Config.Stores[data.storeId];  

    for i = 1, #storeData.products do 
        storeData.products[i].amount = 0;
    end

    callback({
        label = storeData.label,
        products = storeData.products
    });
end)

RegisterNUICallback('pay', function(data, callback)
    local basket = data.basket;

    if not basket or #basket <= 0 then return end; 

    local p = promise:new(); 

    ESX.TriggerServerCallback('lowkey_storesystem:hasMoney', function(response) 
        p:resolve(response);
    end, data.price, basket)

    local hasMoney = Citizen.Await(p);

    if not hasMoney then 
        ESX.ShowNotification('Du har inte tillräckligt med pengar...') return 
    end

    callback({
        success = true, 
    })
end)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false); 
end)