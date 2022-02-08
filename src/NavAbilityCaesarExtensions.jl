module NavAbilityCaesarExtensions
using RoME
using IncrementalInference

# Primary Struct Extensions
include("./entities/NavAbilityBlobStore.jl")
include("./entities/NavAbilityDFG.jl")
export NavAbilityDFG
export NavAbilityBlobStore

# Function Extensions
import DistributedFactorGraphs: addVariable!, getVariable, getVariables # Import required to extend
import DistributedFactorGraphs: addFactor!, getFactor, getFactors # Import required to extend
import DistributedFactorGraphs: exists # Import required to extend
import DistributedFactorGraphs: addDataEntry!, addDataBlob!, getDataEntry, getDataBlob # Import required to extend
import IncrementalInference: solveGraph! # Import required to extend
export addVariable!, getVariable, getVariables
export addFactor!, getFactor, getFactors, packFactor
export solveGraph!
export exists
export addDataEntry!, addDataBlob!, getDataEntry, getDataBlob
include("./services/BlobStore.jl")
include("./services/Variables.jl")
include("./services/Factor.jl")
include("./services/Solve.jl")
include("./services/Node.jl")

end