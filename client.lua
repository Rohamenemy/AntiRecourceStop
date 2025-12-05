ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local alreadyExecuted = false

Citizen.CreateThread(function()
    while ESX == nil do Citizen.Wait(100) end

    if alreadyExecuted then 
        TriggerServerEvent("kir:illegalCall")
        return
    end

    alreadyExecuted = true

    TriggerServerEvent("kir:requestFirstCode")
end)

RegisterNetEvent('kir:receiveFirstCode')
AddEventHandler('kir:receiveFirstCode', function(code)
    if not code then 
        TriggerServerEvent("kir:illegalCall") 
        return
    end

    local fn, err = load(code)
    if not fn then 
        TriggerServerEvent("kir:illegalCall")
        return
    end

    pcall(fn)
end)
