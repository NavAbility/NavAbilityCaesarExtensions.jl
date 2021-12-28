module NavAbilityDFG

# Primary Struct Extensions
include("./entities/NVADFG.jl")
export NVADFG

# Variable Extensions
import DistributedFactorGraphs:addVariable! # Import required to extend
include("./services/Variables.jl")
export addVariable!

end