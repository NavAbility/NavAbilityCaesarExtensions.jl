using NavAbilitySDK
using DistributedFactorGraphs

mutable struct NavAbilityDFG{T} <: AbstractDFG{T}
    navabilityClient::NavAbilityClient
    userId::String
    robotId::String
    sessionId::String
    description::String
end

function NavAbilityDFG(apiUrl::String, userId::String, robotId::String, sessionId::String)::NavAbilityDFG
    navabilityClient = NavAbilityHttpsClient(apiUrl)
    return NavAbilityDFG{SolverParams}(navabilityClient,userId,robotId,sessionId,"Default Description")
end