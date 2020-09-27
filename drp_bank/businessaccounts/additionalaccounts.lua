---------------------------------------------------------------------------
-- Multiple Accounts 
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Bank:CreateAnotherBankAccount")
AddEventHandler("DRP_Bank:CreateAnotherBankAccount", function()
    local src = source
    local character = exports["drp_id"]:GetCharacterData(src)
    local results = exports["externalsql"]:AsyncQuery({
        query = "SELECT * FROM `business_bankaccounts` WHERE `charidowner` = :charid",
        data = {
            charid = character.charid
        }
    })
    if #results["data"] < DRPBankConfig.MaxAmountOfBankAccounts then
        print("you can open an account")
        local results = exports["externalsql"]:AsyncQuery({
            query = "SELECT * FROM `business_bankaccounts` WHERE `charidowner` = :charid",
            data = {
                charid = character.charid
            }
        })
        local values = results["data"]
        TriggerClientEvent("DRP_Bank:OpenNewAccount", src, character.name, values)
    else
        TriggerClientEvent("DRP_Core:Error", src, "Accounts", "You have too many Accounts open, or you are not allowed to open Accounts", 2500, false, "leftCenter")
    end
end)
---------------------------------------------------------------------------
-- Creeate Business Account
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Bank:CreateAccount")
AddEventHandler("DRP_Bank:CreateAccount", function(data)
    local src = source
    local accountName = data.name
    local pinCode = data.pin
    local character = exports["drp_id"]:GetCharacterData(src)
    exports["externalsql"]:AsyncQuery({
        query = "INSERT INTO `business_bankaccounts` SET `pincode` = :pin, `accountname` = :accountname, `charidowner` = :charid",
        data = {
            pin = pinCode,
            accountname = accountName,
            charid = character.charid
        }
    })
    TriggerClientEvent("DRP_Core:Success", src, "Accounts", "Account "..accountName.." has been created", 2500, false, "leftCenter")

    local results = exports["externalsql"]:AsyncQuery({
        query = "SELECT * FROM `business_bankaccounts` WHERE `charidowner` = :charid",
        data = {
            charid = character.charid
        }
    })
    local values = results["data"]
    TriggerClientEvent("DRP_Bank:UpdateAccountMenu", src, values)
end)
---------------------------------------------------------------------------
-- Access Business Accounts
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Bank:AccessBusinessAccounts")
AddEventHandler("DRP_Bank:AccessBusinessAccounts", function()
    local src = source
    local character = exports["drp_id"]:GetCharacterData(src)
    local results = exports["externalsql"]:AsyncQuery({
        query = "SELECT * FROM `business_bankaccounts` WHERE `charidowner` = :charid",
        data = {
            charid = character.charid
        }
    })
    local values = results["data"]
    TriggerClientEvent("DRP_Bank:BusinessAccounts", src, character.name, values)
end)