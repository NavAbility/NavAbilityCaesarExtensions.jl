using NavAbilitySDK
using DistributedFactorGraphs
using IncrementalInference

mutable struct NavAbilityDFG{T <: AbstractParams} <: AbstractDFG{T}
    navabilityClient::NavAbilityClient
    solverParams::T
    userId::String
    robotId::String
    sessionId::String
end

function NavAbilityDFG(apiUrl::String, userId::String, robotId::String, sessionId::String)
    navabilityClient = NavAbilityHttpsClient(apiUrl)
    return NavAbilityDFG(navabilityClient,SolverParams(),userId,robotId,sessionId)
end

function Base.show(io::IO, dfg::NavAbilityDFG)
    summary(io, dfg)
    println(io, "\n  UserId: ", dfg.userId)
    println(io, "  RobotId: ", dfg.robotId)
    println(io, "  SessionId: ", dfg.sessionId)
end
Base.show(io::IO, ::MIME"text/plain", dfg::NavAbilityDFG) = show(io, dfg)