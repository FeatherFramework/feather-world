local resourceName = GetCurrentResourceName()

local function Capabilities()
    return {
        ok = true,
        value = {
            resource = resourceName,
            contract = 1,
            version = GetResourceMetadata(resourceName, 'version', 0) or '0.0.0',
            state = 'ready',
            features = { population = 1, interiors = 1, wagonCleanup = 1, map = 1, lootPromptSuppression = 1 }
        }
    }
end

exports('GetCapabilities', Capabilities)

RegisterCommand('WorldContractSmokeTest', function(source)
    if source ~= 0 then return end
    local capabilities = Capabilities()
    local density = WorldPopulation.GetDensityMultipliers()
    local tests = {
        { 'capabilities', capabilities.ok and capabilities.value.contract == 1 },
        { 'density configuration', density.ok and tonumber(density.value.ambientPeds) ~= nil },
        { 'defensive snapshot', density.ok and density.value ~= Config.DensityMultipliers },
        { 'interior fix configuration', type(Config.InteriorFix) == 'table'
            and Config.InteriorFix.enabled == true
            and Config.InteriorFix.expectedInteriorDefinitions == 35
            and Config.InteriorFix.expectedInteriorMetadata == 35
            and Config.InteriorFix.expectedEntitySets == 494
            and Config.InteriorFix.expectedImapOperations == 400
            and Config.InteriorFix.expectedImapDescriptions == 217 },
        { 'wagon cleanup configuration', type(Config.WagonFix) == 'table'
            and type(Config.WagonFix.components) == 'table'
            and #Config.WagonFix.components > 0
            and tonumber(Config.WagonFix.checkIntervalMs) ~= nil
            and tonumber(Config.WagonFix.networkControl.maxAttempts) ~= nil }
    }
    local passed = 0
    for _, test in ipairs(tests) do
        if test[2] then passed = passed + 1 end
        print(('[WorldContractSmokeTest] %-24s %s'):format(test[1], test[2] and 'PASS' or 'FAIL'))
    end
    print(('[WorldContractSmokeTest] done %d/%d passed'):format(passed, #tests))
end, true)
