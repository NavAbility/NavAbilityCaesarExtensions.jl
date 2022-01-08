using NavAbilitySDK
using DistributedFactorGraphs
using IncrementalInference

mutable struct NavAbilityDFG
    navabilityClient::NavAbilityClient
    userId::String
    robotId::String
    sessionId::String
end

function NavAbilityDFG(apiUrl::String, userId::String, robotId::String, sessionId::String)::NavAbilityDFG
    navabilityClient = NavAbilityHttpsClient(apiUrl)
    return NavAbilityDFG(navabilityClient,userId,robotId,sessionId)
end