Config = {
    DevMode = false,
    DisableRandomLootPrompts = true,
    EnableInteriorFixes = true,
    WagonFix = {
        enabled = true,
        checkIntervalMs = 1000,
        orphanCheckIntervalMs = 5000,
        componentDistance = 3.0,
        occupantDistance = 5.0,
        networkControl = {
            maxAttempts = 50,
            waitMs = 10
        },
        components = {
            's_wagonprison_lock',
            's_coachlock02x',
            'p_wagonprison_lock01x',
            'p_wagonprison_chain01x'
        }
    },
    DensityMultipliers = {
        ambientPeds = 1.0,
        scenarioPeds = 1.0,
        vehicles = 1.0,
        parkedVehicles = 1.0,
        randomVehicles = 1.0,
        ambientAnimals = 1.0,
        ambientHumans = 1.0,
        scenarioAnimals = 1.0,
        scenarioHumans = 1.0
    }
}
