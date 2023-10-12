Utilites = {}; 

function Utilites:CreatePed(data)
    while not HasModelLoaded(data.model) do 
        RequestModel(data.model); 

        Citizen.Wait(250); 
    end

    local ped = CreatePed(4, data.model, data.coords.xyz, data.coords.w, false, false);

    SetModelAsNoLongerNeeded(data.model);

    FreezeEntityPosition(ped, true); 
    SetEntityInvincible(ped, true);
    
    SetBlockingOfNonTemporaryEvents(ped, true);
    SetPedFleeAttributes(ped, 0, 0);

    SetPedCombatAttributes(ped, 17, true);

    return ped;
end


function Utilites:DrawText3D(coords, text)
    SetDrawOrigin(coords)
    
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetTextCentre(1)
    SetTextFont(4)
    SetTextScale(0.35, 0.35)
    EndTextCommandDisplayText(0.0, 0.0)
  
    BeginTextCommandGetWidth("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetTextFont(4)
    SetTextScale(0.35, 0.35)
    local textWidth = EndTextCommandGetWidth(1)
    local width = textWidth + 0.0015
    local characterHeight = GetRenderedCharacterHeight(0.35, 4) * 1.3
    DrawRect(0.0, characterHeight/2, width, characterHeight)
    
    ClearDrawOrigin()
end
