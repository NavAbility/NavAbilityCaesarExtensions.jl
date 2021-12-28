module NavAbilityDFG

# Primary Struct Extensions
include("./entities/NavAbilityDFG.jl")
export NavAbilityDFG

# Variable Extensions
import DistributedFactorGraphs:addVariable! # Import required to extend
include("./services/Variables.jl")
export addVariable!

end