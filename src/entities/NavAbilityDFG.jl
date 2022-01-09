using NavAbilitySDK
using DistributedFactorGraphs

mutable struct NavAbilityDFG{T <: AbstractParams} <: AbstractDFG{T}
    navabilityClient::NavAbilityClient
    userId::String
    robotId::String
    sessionId::String
end

function NavAbilityDFG(apiUrl::String, userId::String, robotId::String, sessionId::String)::NavAbilityDFG
    navabilityClient = NavAbilityHttpsClient(apiUrl)
    return NavAbilityDFG{SolverParams}(navabilityClient,userId,robotId,sessionId)
end

function Base.show(io::IO, dfg::NavAbilityDFG)
    summary(io, dfg)
    println(io, "\n  UserId: ", dfg.userId)
    println(io, "  RobotId: ", dfg.robotId)
    println(io, "  SessionId: ", dfg.sessionId)
end
Base.show(io::IO, ::MIME"text/plain", dfg::NavAbilityDFG) = show(io, dfg)