using DistributedFactorGraphs
using NavAbilitySDK

mutable struct NVADFG{T <: AbstractParams} <: AbstractDFG{T}
    navabilityClient::NavAbilityClient
    # These are standard across all DFG's. I think you might 
    # want to change this, which is not a problem at all.
    solverParams::T # Solver parameters
    userId::String
    robotId::String
    sessionId::String
    description::String
end

function NVADFG(apiUrl::String, userId::String, robotId::String, sessionId::String)::NVADFG
    navabilityClient = NavAbilityHttpsClient(apiUrl)
    return NVADFG(navabilityClient,NoSolverParams(),userId,robotId,sessionId,"DEFAULT_NAVABILITY_DFG")
end