------- File Information --------
-- inspired by popdensity by kibook
-- OG Script: https://github.com/kibook/popdensity
-----------------------------------

local function SetAmbientAnimalDensity(multiplier)
	Citizen.InvokeNative(0xC0258742B034DFAF, multiplier)
end

local function SetAmbientHumanDensity(multiplier)
	Citizen.InvokeNative(0xBA0980B5C0A11924, multiplier)
end

local function SetAmbientPedDensity(multiplier)
	Citizen.InvokeNative(0xAB0D553FE20A6E25, multiplier)
end

local function SetScenarioAnimalDensity(multiplier)
	Citizen.InvokeNative(0xDB48E99F8E064E56, multiplier)
end

local function SetScenarioHumanDensity(multiplier)
	Citizen.InvokeNative(0x28CB6391ACEDD9DB, multiplier)
end

WorldPopulationFrames = 0

function SetupDensities(multipliers)
	DebugLog("Starting pop density")
    while true do
		if SetPedDensityMultiplierThisFrame then
			-- FiveM
			SetPedDensityMultiplierThisFrame(multipliers.ambientPeds)
			SetScenarioPedDensityMultiplierThisFrame(multipliers.scenarioPeds, multipliers.scenarioPeds)
		else
			-- RedM
			SetAmbientAnimalDensity(multipliers.ambientAnimals)
			SetAmbientHumanDensity(multipliers.ambientHumans)
			SetAmbientPedDensity(multipliers.ambientPeds)
			SetScenarioAnimalDensity(multipliers.scenarioAnimals)
			SetScenarioHumanDensity(multipliers.scenarioHumans)
			SetScenarioPedDensityMultiplierThisFrame(multipliers.scenarioPeds)
		end

		SetParkedVehicleDensityMultiplierThisFrame(multipliers.parkedVehicles)
		SetRandomVehicleDensityMultiplierThisFrame(multipliers.randomVehicles)
		SetVehicleDensityMultiplierThisFrame(multipliers.vehicles)
		WorldPopulationFrames = WorldPopulationFrames + 1

		Wait(0)
	end
end

function StartPopulationDensity()
    CreateThread(function()
		SetupDensities(Config.DensityMultipliers)
    end)
end
