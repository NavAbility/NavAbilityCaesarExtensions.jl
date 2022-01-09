using NavAbilitySDK
using JSON
using RoME
using Caesar

function addFactor!(dfg::NavAbilityDFG, variables::AbstractVector{Symbol}, factor::AbstractDFGFactor; await::Int = 150)
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  @info "prepack"
  sdkFactor = packFactor(dfg, factor)
  @info "postpack"
  requestId = NavAbilitySDK.addPackedFactor(dfg.navabilityClient, context, json(sdkFactor))
  for _ in 1:await
    savedFactor = NavAbilitySDK.getFactor(dfg.navabilityClient, context, factor.label)
    if !(savedFactor === nothing)
      break
    end
    sleep(1)
  end
  return requestId
end

function getFactors(dfg::NavAbilityDFG, regexFilter::Union{Nothing, Regex}=nothing; tags::Vector{Symbol}=Symbol[], solvable::Int=0)
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  response = NavAbilitySDK.getFactors(dfg.navabilityClient, context)
  dfgVariables = map(v -> unpackFactor(dfg, v), response)
  # TODO: Implement regexFilter
  # TODO: Implement tags
  # TODO: Implement solver filter
  return dfgVariables
end