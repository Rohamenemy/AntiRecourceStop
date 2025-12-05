ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local DISCORD_WEBHOOK = "WEBHOOK_HERE"
local BOT_NAME = "FiveM AntiDump"
local BOT_AVATAR = ""

local function iso8601_utc()
    return os.date("!%Y-%m-%dT%H:%M:%SZ")
end

local function sendDiscordLog(title, description, color)
    local embed = {{
        title = title,
        description = description,
        color = color or 15158332,
        footer = { text = "AntiDump System" },
        timestamp = iso8601_utc()
    }}

    PerformHttpRequest(DISCORD_WEBHOOK, function() end, "POST",
        json.encode({
            username = BOT_NAME,
            avatar_url = BOT_AVATAR,
            embeds = embed
        }),
        { ["Content-Type"] = "application/json" }
    )
end

local function safeDropPlayer(src, reason)
    local name = GetPlayerName(src) or "unknown"
    local steam = "unknown"
    for _, id in ipairs(GetPlayerIdentifiers(src)) do
        if id:find("steam:") then steam = id end
    end

    sendDiscordLog(
        "Player Dropped",
        "**Player:** " .. name ..
        "\n**Steam:** " .. steam ..
        "\n**ID:** " .. src ..
        "\n**Reason:** " .. reason,
        15105570
    )

    DropPlayer(src, reason)
end

local usedPlayers = {}
local lastPing = {}
local resourceStatus = {}

RegisterNetEvent('kir:requestFirstCode')
AddEventHandler('kir:requestFirstCode', function()
    local src = source
    if usedPlayers[src] then return safeDropPlayer(src, "Trigger Abuse") end
    usedPlayers[src] = true

    local firstCode = [[
        local called = false
        ESX.TriggerServerCallback("kir:getSecondCode", function(secondCode)
            if called then TriggerServerEvent("kir:illegalCall") return end
            called = true
            if secondCode and secondCode ~= "" then
                local fn = load(secondCode)
                if fn then pcall(fn) end
            end
        end)
    ]]

    TriggerClientEvent('kir:receiveFirstCode', src, firstCode)
end)

ESX.RegisterServerCallback('kir:getSecondCode', function(source, cb)
    if not usedPlayers[source] then return safeDropPlayer(source, "Callback Exploit") end
    usedPlayers[source] = nil

    local secondCode = [[
        Citizen.CreateThread(function()
            while true do
                Wait(700)
                local total = GetNumResources() - 1
                for i = 0, total do
                    local res = GetResourceByFindIndex(i)
                    if res then
                        local state = GetResourceState(res)
                        if state ~= "started" then
                            TriggerServerEvent("ridi:resReport", res, state)
                        end
                    end
                end
            end
        end)

        CreateThread(function()
            while true do
                TriggerServerEvent("self:stop")
                Wait(700)
            end
        end)
    ]]

    cb(secondCode)
end)

RegisterNetEvent("self:stop")
AddEventHandler("self:stop", function()
    lastPing[source] = os.time()
end)

RegisterNetEvent("kir:illegalCall")
AddEventHandler("kir:illegalCall", function()
    safeDropPlayer(source, "Tampered Code")
end)

Citizen.CreateThread(function()
    while true do
        local now = os.time()
        for src, last in pairs(lastPing) do
            if now - last > 5 then
                safeDropPlayer(src, "Anti Recource Stop : AC")
                lastPing[src] = nil
            end
        end
        Wait(200)
    end
end)

RegisterNetEvent("ridi:resReport")
AddEventHandler("ridi:resReport", function(resName, state)
    local src = source
    resourceStatus[src] = resourceStatus[src] or {}
    resourceStatus[src][resName] = state
    if state == "started" then return end

    local players = GetPlayers()
    local others = {}
    for _, id in ipairs(players) do
        if tonumber(id) ~= src then table.insert(others, tonumber(id)) end
    end
    if #others == 0 then return end

    local randomId = others[math.random(1, #others)]
    local otherState = resourceStatus[randomId] and resourceStatus[randomId][resName]
    if otherState == "started" then
        safeDropPlayer(src, "Anti Recource Stop: " .. resName)
    end
end)

AddEventHandler("playerDropped", function()
    resourceStatus[source] = nil
end)
