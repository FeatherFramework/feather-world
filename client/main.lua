function DebugLog(...)
    if Config.DevMode then print('[feather-world]', ...) end
end

CreateThread(function()
    StartGlobalEventListeners()
    StartPlayerRuntime()
    StartPopulationDensity()
    if Config.EnableInteriorFixes then StartInteriorsFix() end
    if Config.EnableWagonFix then StartWagonFix() end
    while Config.DisableRandomLootPrompts do
        Citizen.InvokeNative(0xFC094EF26DD153FA, 2)
        Wait(0)
    end
end)

exports('SetFogOfWar', function(toggle) MapAPI.setFOW(toggle == true) end)
exports('DisplayWorldRadar', function(toggle) MapAPI.DisplayRadar(toggle == true) end)
exports('StartGpsRoute', MapAPI.StartGps)
exports('StopGpsRoute', MapAPI.StopGps)

RegisterCommand('WorldClientSmokeTest', function()
    local multipliers = Config.DensityMultipliers
    local densityReady = type(multipliers) == 'table' and tonumber(multipliers.ambientPeds) ~= nil
        and WorldPopulationFrames > 0
    local interiorsReady = not Config.EnableInteriorFixes or (InteriorsActive == true and IMapsActive == true)
    local safeguardsReady = tonumber(EventListenerCount) == 3
    print(('[WorldClientSmokeTest] density loop             %s -- frames=%s'):format(
        densityReady and 'PASS' or 'FAIL', tostring(WorldPopulationFrames)))
    print(('[WorldClientSmokeTest] interior fixes          %s'):format(interiorsReady and 'PASS' or 'FAIL'))
    print(('[WorldClientSmokeTest] safeguard listeners      %s -- listeners=%s'):format(
        safeguardsReady and 'PASS' or 'FAIL', tostring(EventListenerCount)))
    print(('[WorldClientSmokeTest] done %d/3 passed'):format(
        (densityReady and 1 or 0) + (interiorsReady and 1 or 0) + (safeguardsReady and 1 or 0)))
end, false)
