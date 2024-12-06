local Framework = nil

CreateThread(function()
    if GetResourceState('qb-core') == 'started' then
        Framework = exports['qb-core']:GetCoreObject()
    elseif GetResourceState('es_extended') == 'started' then
        Framework = exports['es_extended']:getSharedObject()
    else
        print('No se detectó un framework válido. Asegúrate de tener QBCore o ESX.')
    end
end)

function generatePlateNumber()
    local plateNumber = ""
    for i = 1, 4 do
        plateNumber = plateNumber .. tostring(math.random(0, 9))
    end
    return plateNumber
end

function savePlateNumberToFile(plateNumber, citizenId)
    local filePath = "data/plate_numbers.json"
    local plateNumbers = json.decode(LoadResourceFile(GetCurrentResourceName(), filePath)) or {}

    plateNumbers[citizenId] = { plate = plateNumber }

    SaveResourceFile(GetCurrentResourceName(), filePath, json.encode(plateNumbers))
end

RegisterNetEvent('generatePlateForPlayer', function(targetPlayerId)
    local src = source
    local targetPlayer = Framework.Functions.GetPlayer and Framework.Functions.GetPlayer(targetPlayerId) or Framework.GetPlayerFromId(targetPlayerId)

    if targetPlayer then
        local targetCitizenId = targetPlayer.PlayerData.citizenid or targetPlayer.getIdentifier()
        local plateNumber = generatePlateNumber()

        savePlateNumberToFile(plateNumber, targetCitizenId)
        TriggerClientEvent('QBCore:Notify', src, Config.Messages[Config.Language].plate_generated .. plateNumber, 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, Config.Messages[Config.Language].player_not_online, 'error')
    end
end)

RegisterNetEvent('modifyPlayerPlate')
AddEventHandler('modifyPlayerPlate', function(targetPlayerId, newPlateNumber)
    local src = source
    local xPlayer = Framework.Functions.GetPlayer and Framework.Functions.GetPlayer(src) or Framework.GetPlayerFromId(src)

    if xPlayer and xPlayer.PlayerData.job.name == 'police' and xPlayer.PlayerData.job.grade.level == 4 then
        local targetPlayer = Framework.Functions.GetPlayer and Framework.Functions.GetPlayer(targetPlayerId) or Framework.GetPlayerFromId(targetPlayerId)

        if targetPlayer then
            local targetCitizenId = targetPlayer.PlayerData.citizenid or targetPlayer.getIdentifier()
            local filePath = "data/plate_numbers.json"
            local plateNumbers = json.decode(LoadResourceFile(GetCurrentResourceName(), filePath)) or {}

            plateNumbers[targetCitizenId] = { plate = newPlateNumber }
            SaveResourceFile(GetCurrentResourceName(), filePath, json.encode(plateNumbers))

            TriggerClientEvent('QBCore:Notify', src, Config.Messages[Config.Language].plate_modified .. newPlateNumber, 'success')
            TriggerClientEvent('QBCore:Notify', targetPlayerId, Config.Messages[Config.Language].plate_modified .. newPlateNumber, 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, Config.Messages[Config.Language].player_not_online, 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Config.Messages[Config.Language].no_permissions, 'error')
    end
end)
