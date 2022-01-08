module NavAbilityCaesarExtensions

# Primary Struct Extensions
include("./entities/NavAbilityDFG.jl")
export NavAbilityDFG

# Variable Extensions
import DistributedFactorGraphs: addVariable!, getVariables # Import required to extend
import DistributedFactorGraphs: addFactor! # Import required to extend
include("./services/Variables.jl")
include("./services/Factor.jl")
include("./services/Solve.jl")
export addVariable!, getVariables
export addFactor!
export solveGraph!

end