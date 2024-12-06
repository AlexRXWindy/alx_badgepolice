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

local function notify(messageKey, type)
    local language = Config.Language or 'es'
    local messages = Config.Messages[language] or Config.Messages['es']
    local message = messages[messageKey] or 'Mensaje no encontrado.'

    if Framework == exports['qb-core']:GetCoreObject() then
        Framework.Functions.Notify(message, type)
    elseif Framework == exports['es_extended']:getSharedObject() then
        exports['mythic_notify']:SendAlert(type, message)
    end
end

function requestPlateNumber(citizenId)
    TriggerServerEvent('requestPlateNumber', citizenId)
end

function requestGeneratePlateForPlayer(targetPlayerId)
    TriggerServerEvent('generatePlateForPlayer', targetPlayerId)
end

RegisterCommand('generarplaca', function(source, args)
    local playerData = Framework.Functions.GetPlayerData and Framework.Functions.GetPlayerData() or Framework.GetPlayerData()

    if playerData.job.name == 'police' and playerData.job.grade.level == 4 then
        if #args ~= 1 then
            notify('correct_usage_generate', 'error')
            return
        end

        local targetPlayerId = tonumber(args[1])
        requestGeneratePlateForPlayer(targetPlayerId)
    else
        notify('no_permissions', 'error')
    end
end, false)

RegisterCommand('modificarplaca', function(source, args)
    local playerData = Framework.Functions.GetPlayerData and Framework.Functions.GetPlayerData() or Framework.GetPlayerData()

    if playerData.job.name == 'police' and playerData.job.grade.level == 4 then
        if #args ~= 2 then
            notify('correct_usage_modify', 'error')
            return
        end

        local targetPlayerId = tonumber(args[1])
        local newPlateNumber = args[2]

        TriggerServerEvent('modifyPlayerPlate', targetPlayerId, newPlateNumber)
    else
        notify('no_permissions', 'error')
    end
end, false)

RegisterNetEvent('receivePlateNumber')
AddEventHandler('receivePlateNumber', function(plateNumber)
    if plateNumber then
        notify('your_plate', 'success')
    else
        notify('plate_not_found', 'error')
    end
end)

RegisterCommand('miplaca', function(source, args)
    local playerData = Framework.Functions.GetPlayerData and Framework.Functions.GetPlayerData() or Framework.GetPlayerData()
    if playerData and playerData.citizenid then
        requestPlateNumber(playerData.citizenid)
    else
        notify('citizenid_not_found', 'error')
    end
end, false)
