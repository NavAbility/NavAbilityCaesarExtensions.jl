module NavAbilityCaesarExtensions

# Primary Struct Extensions
include("./entities/NavAbilityDFG.jl")
export NavAbilityDFG

# Variable Extensions
import DistributedFactorGraphs: addVariable!, getVariable, getVariables # Import required to extend
import DistributedFactorGraphs: addFactor!, getFactor, getFactors # Import required to extend
import IncrementalInference: addFactor!
export addVariable!, getVariable, getVariables
export addFactor!, getFactor, getFactors
export solveGraph!
include("./services/Variables.jl")
include("./services/Factor.jl")
include("./services/Solve.jl")

end