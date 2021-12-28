using DistributedFactorGraphs

mutable struct NavAbilityDFG{T <: AbstractParams} <: AbstractDFG{T}
    # These are standard across all DFG's. I think you might 
    # want to change this, which is not a problem at all.
    solverParams::T # Solver parameters
    userId::String
    robotId::String
    sessionId::String
    description::String
end