RegisterServerEvent("DRP_Bank:RequestATMInfo")
AddEventHandler("DRP_Bank:RequestATMInfo", function()
    local src = source
       TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
            TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
            TriggerClientEvent("DRP_Bank:OpenMenu", src, CharacterData.name, characterMoney.data[1].bank, characterMoney.data[1].cash)
        end)
    end)
end)
---------------------------------------------------------------------------
-- Withdrawing Money
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Bank:WithdrawMoney")
AddEventHandler("DRP_Bank:WithdrawMoney", function(amount)
    local src = source
    TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
        TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
            local bankBalance = characterMoney.data[1].bank
            local newBankBalance = characterMoney.data[1].bank - tonumber(amount)
            
            if bankBalance >= tonumber(amount) then
                exports["externalsql"]:AsyncQueryCallback({
                    query = "UPDATE `characters` SET `bank` = :bank WHERE `id` = :charid",
                    data = {
                        bank = newBankBalance,
                        charid = CharacterData.charid
                    }
                }, function(results)

                    local cashBalance = characterMoney.data[1].cash
                    local newCashBalance = characterMoney.data[1].cash + tonumber(amount)
                    exports["externalsql"]:AsyncQueryCallback({
                        query = "UPDATE `characters` SET `cash` = :cash WHERE `id` = :charid",
                        data = {
                            cash = newCashBalance,
                            charid = CharacterData.charid
                        }
                    }, function(results)
                        TriggerClientEvent("DRP_Bank:ActionCallback", src, true, "Success", newBankBalance, newCashBalance)
                    end)
                end)
            else 
                TriggerClientEvent("DRP_Bank:ActionCallback", src, false, "Insufficiant Funds", false)
            end
        end)
    end)
end)
---------------------------------------------------------------------------
-- Depositing Money
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Bank:DepositMoney")
AddEventHandler("DRP_Bank:DepositMoney", function(amount)
    local src = source
    TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
        TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)

            local cashBalance = characterMoney.data[1].cash
            local newCashBalance = characterMoney.data[1].cash - tonumber(amount)
            
            if cashBalance >= tonumber(amount) then
                exports["externalsql"]:AsyncQueryCallback({
                    query = "UPDATE `characters` SET `cash` = :cash WHERE `id` = :charid",
                    data = {
                        cash = newCashBalance,
                        charid = CharacterData.charid
                    }
                }, function(results)

                    local bankBalance = characterMoney.data[1].bank
                    local newBankBalance = characterMoney.data[1].bank + tonumber(amount)

                    exports["externalsql"]:AsyncQueryCallback({
                        query = "UPDATE `characters` SET `bank` = :bank WHERE `id` = :charid",
                        data = {
                            bank = newBankBalance,
                            charid = CharacterData.charid
                        }
                    }, function(results)
                        TriggerClientEvent("DRP_Bank:ActionCallback", src, true, "Success", newBankBalance, newCashBalance)
                    end)
                end)
            else 
                TriggerClientEvent("DRP_Bank:ActionCallback", src, false, "Insufficiant Funds", false)
            end
        end)
    end)
end)
---------------------------------------------------------------------------
-- Laundering Money
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Bank:LaunderMoney")
AddEventHandler("DRP_Bank:LaunderMoney", function()
    local src = source
    local character = exports["drp_id"]:GetCharacterData(src)
    SetTimeout(1200, function()
        cleanMoney(src)
    end)
end)
---------------------------------------------------------------------------
function cleanMoney(source)
    local src = source
    local character = exports["drp_id"]:GetCharacterData(src)
    local moneyLaundered = 0
    local cleanedCash = 0

    TriggerEvent("DRP_Bank:GetCharacterMoney", character.charid, function(characterMoney)
        SetTimeout(2500, function()
            local dirtyMoney = characterMoney.data[1].dirtyCash
            if dirtyMoney > 1000 then
                moneyLaundered = math.random(100, 1000)
            elseif dirtyMoney > 0 then
                moneyLaundered = dirtyMoney
            end
            ---------------------------------------------------------------------------
            if moneyLaundered > 0 then
                TriggerEvent("DRP_Bank:RemoveDirtyMoney", src, moneyLaundered)
                cleanedCash = math.floor(moneyLaundered * 0.70)
                TriggerEvent("DRP_Bank:AddCashMoney", src, cleanedCash)

                TriggerClientEvent("DRP_Core:Info", src, "Launder", "I have laundered $"..moneyLaundered.." into $"..cleanedCash.." Stay around, I have more!", 2500, false, "leftCenter")
                cleanMoney(src)
            else
                TriggerClientEvent("DRP_Core:Warning", src, "Launder", "That is all the money I could Launder, all done!", 2500, false, "leftCenter")
                TriggerClientEvent("DRP_Bank:FinishedLaundering", src)
            end
        end)
    end)
end
---------------------------------------------------------------------------
-- Adding BANK Money
---------------------------------------------------------------------------
AddEventHandler("DRP_Bank:AddBankMoney", function(source, amount)
    local src = source
    if type(amount) == "number" then
        local character = exports["drp_id"]:GetCharacterData(src)
        TriggerEvent("DRP_Bank:GetCharacterMoney", character.charid, function(characterMoney)
            local newBankBalance = characterMoney.data[1].bank + tonumber(amount)
            exports["externalsql"]:AsyncQueryCallback({
                query = "UPDATE `characters` SET `bank` = :bank WHERE `id` = :charid",
                data = {
                    bank = newBankBalance,
                    charid = character.charid
                }
            }, function(results)
                TriggerClientEvent("DRP_Bank:ActionCallback", src, true, "Success", newBankBalance)
                TriggerClientEvent("DRP_Core:Info", src, "Bank", "An amount of $"..amount.." has been added to your Bank Account", 2500, false, "leftCenter")
            end)
        end)
    end
end)
---------------------------------------------------------------------------
-- Removing BANK money
---------------------------------------------------------------------------
AddEventHandler("DRP_Bank:RemoveBankMoney", function(source, amount)
    local src = source
    TriggerEvent("DRP_ID:GetCharacterData", src, function(characterData)
        TriggerEvent("DRP_Bank:GetCharacterMoney", characterData.charid, function(characterMoney)
            local newBankBalance = characterMoney.data[1].bank - tonumber(amount)
            exports["externalsql"]:AsyncQueryCallback({
                query = "UPDATE `characters` SET `bank` = :bank WHERE `id` = :charid",
                data = {
                    bank = newBankBalance,
                    charid = characterData.charid
                }
            }, function(results)
                TriggerClientEvent("DRP_Bank:ActionCallback", src, true, "Success", newBankBalance)
                TriggerClientEvent("DRP_Core:Info", src, "Bank", "An amount of $"..amount.." has been removed to your Bank Account", 2500, false, "leftCenter")
            end)
        end)
    end)
end)
---------------------------------------------------------------------------
-- Adding CASH Money
---------------------------------------------------------------------------
AddEventHandler("DRP_Bank:AddCashMoney", function(source, amount)
    local src = source
    if type(amount) == "number" then
        TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
            TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
                local newCashBalance = characterMoney.data[1].cash + tonumber(amount)
                exports["externalsql"]:AsyncQueryCallback({
                    query = "UPDATE `characters` SET `cash` = :cash WHERE `id` = :charid",
                    data = {
                        cash = newCashBalance,
                        charid = CharacterData.charid
                    }
                }, function(results)
                    TriggerClientEvent("DRP_Bank:ActionCallback", src, true, "Success", newBankBalance)
                    TriggerClientEvent("DRP_Core:Info", src, "Bank", "You picked up $"..amount.." cash", 2500, false, "leftCenter")
                end)
            end)
        end)
    end
end)
---------------------------------------------------------------------------
-- Removing CASH Money
---------------------------------------------------------------------------
AddEventHandler("DRP_Bank:RemoveCashMoney", function(source, amount)
    local src = source
    print("removing cash "..amount)
    TriggerEvent("DRP_ID:GetCharacterData", src, function(characterData)
        TriggerEvent("DRP_Bank:GetCharacterMoney", characterData.charid, function(characterMoney)
            local playerCash = characterMoney.data[1].cash - amount
            exports["externalsql"]:AsyncQueryCallback({
                query = "UPDATE `characters` SET `cash` = :cash WHERE `id` = :charid",
                data = {
                    cash = playerCash,
                    charid = characterData.charid
                }
            }, function(results)
                TriggerClientEvent("DRP_Bank:ActionCallback", src, true, "Success", newBankBalance)
                TriggerClientEvent("DRP_Core:Info", src, "Bank", "You have spent $"..amount.." cash", 2500, false, "leftCenter")
            end)
        end)
    end)
end)
---------------------------------------------------------------------------
-- Adding Dirty Money
---------------------------------------------------------------------------
AddEventHandler("DRP_Bank:AddDirtyMoney", function(source, amount)
    local src = source
    if type(amount) == "number" then
        TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
            TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
                local newDirtyBalance = characterMoney.data[1].dirtyCash + tonumber(amount)
                exports["externalsql"]:AsyncQueryCallback({
                    query = "UPDATE `characters` SET `dirtyCash` = :dirtyCash WHERE `id` = :charid",
                    data = {
                        dirtyCash = newDirtyBalance,
                        charid = CharacterData.charid
                    }
                }, function(results)
                    TriggerClientEvent("DRP_Bank:ActionCallback", src, true, "Success", newBankBalance)
                end)
            end)
        end)
    end
end)
---------------------------------------------------------------------------
-- Removing Dirty Money
---------------------------------------------------------------------------
AddEventHandler("DRP_Bank:RemoveDirtyMoney", function(source, amount)
    local src = source
    TriggerEvent("DRP_ID:GetCharacterData", src, function(characterData)
        TriggerEvent("DRP_Bank:GetCharacterMoney", characterData.charid, function(characterMoney)
            local moneyRemoved = 25
            local newDirtyBalance = characterMoney.data[1].dirtyCash - tonumber(amount)
            exports["externalsql"]:AsyncQueryCallback({
                query = "UPDATE `characters` SET `dirtyCash` = :dirtyCash WHERE `id` = :charid",
                data = {
                    dirtyCash = newDirtyBalance,
                    charid = characterData.charid
                }
            }, function(results)
                TriggerClientEvent("DRP_Bank:ActionCallback", src, true, "Success", newBankBalance)
            end)
        end)
    end)
end)
---------------------------------------------------------------------------
-- Get Character Money Data
---------------------------------------------------------------------------
AddEventHandler("DRP_Bank:GetCharacterMoney", function(charid, callback)
	local src = source
		exports["externalsql"]:AsyncQueryCallback({
			query = "SELECT * FROM `characters` WHERE `id` = :char_id",
			data = {
				char_id = charid
			}
		}, function(results)
		callback(results)
	end)
end)

function GetCharacterMoney(charid, callback)
    local src = source
		exports["externalsql"]:AsyncQueryCallback({
			query = "SELECT * FROM `characters` WHERE `id` = :char_id",
			data = {
				char_id = charid
			}
		}, function(results)
		callback(results)
	end)
end
---------------------------------------------------------------------------
-- All Commands For Banking
---------------------------------------------------------------------------
RegisterCommand('cash', function(source, args, user)
    local src = source
    TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
        TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
            TriggerClientEvent("chatMessage", src, tostring("^2Cash^0: Your Cash Total: ^2$"..characterMoney.data[1].cash.."^0 "))
        end)
    end)
end, false)
---------------------------------------------------------------------------
RegisterCommand('dirty', function(source, args, user)
    local src = source
    TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
        TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
            TriggerClientEvent("chatMessage", src, tostring("^1Dirty Cash^0: Your Dirty Cash Total: ^1$"..characterMoney.data[1].dirtyCash.."^0 "))
        end)
    end)
end, false)
---------------------------------------------------------------------------
RegisterCommand('bank', function(source, args, user)
    local src = source
    TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
        TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
            TriggerClientEvent("chatMessage", src, tostring("^4Bank^0: Your Latest Bank Statement: ^4$"..characterMoney.data[1].bank.."^0 "))
        end)
    end)
end, false)