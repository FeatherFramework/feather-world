WorldPopulation = {}

local function Copy(input)
    local output = {}
    for key, value in pairs(input) do output[key] = value end
    return output
end

function WorldPopulation.GetDensityMultipliers()
    return { ok = true, value = Copy(Config.DensityMultipliers) }
end

exports('GetDensityMultipliers', WorldPopulation.GetDensityMultipliers)
