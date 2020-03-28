RegisterServerEvent('DRP_Soda:checkAccounts')
AddEventHandler('DRP_Soda:checkAccounts', function()
    local src = source
    local charInfo = exports["drp_id"]:GetCharacterData(src)
    TriggerEvent("DRP_Inventory:CheckWeight", charInfo, DRPSoda.Item, 1, function(weightCheck)
        if weightCheck == true then
            TriggerEvent("DRP_Bank:GetCharacterMoney", charInfo.charid, function(characterMoney)
                print('cash:', tonumber(characterMoney.data[1].cash))
                if tonumber(characterMoney.data[1].cash) >= tonumber(DRPSoda.Price) then
                    TriggerEvent("DRP_Bank:RemoveCashMoney", src, tonumber(DRPSoda.Price))
                    TriggerClientEvent("DRP_Soda:getSoda", src)
                else
                    TriggerClientEvent("DRP_Core:Error", src, "Soda Machine", tostring("You don't have enough Cash!"), 2500, false, "leftCenter")
                end
            end)
        else
            TriggerClientEvent("DRP_Core:Error", src, "Inventory", tostring("You don't have enough room in your inventory!"), 2500, false, "leftCenter")
        end
    end)
end)
