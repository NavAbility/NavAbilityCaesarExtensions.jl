using DistributedFactorGraphs
using NavAbilitySDK

mutable struct NavAbilityDFG{T <: AbstractParams} <: AbstractDFG{T}
    navabilityClient::NavAbilityClient
    # These are standard across all DFG's. I think you might 
    # want to change this, which is not a problem at all.
    solverParams::T # Solver parameters
    userId::String
    robotId::String
    sessionId::String
    description::String
end

function NavAbilityDFG(apiUrl::String, userId::String, robotId::String, sessionId::String)::NavAbilityDFG
    navabilityClient = NavAbilityHttpsClient(apiUrl)
    return NavAbilityDFG(navabilityClient,NoSolverParams(),userId,robotId,sessionId,"DEFAULT_NAVABILITY_DFG")
end