using NavAbilitySDK
using DistributedFactorGraphs
using JSON

function gqlToDfg(factor)
  return factor
end

function addFactor!(dfg::CloudDFG, factor::AbstractDFGFactor; await::Int = 150)
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  sdkFactor = packFactor(dfg, factor)
  requestId = addPackedFactor(dfg.navabilityClient, context, json(sdkFactor))
  for _ in 1:await
    savedFactor = getFactor(dfg, getLabel(factor))
    if !(savedFactor === nothing)
      @info savedFactor
      break
    end
    sleep(1)
  end
  return requestId
end

function getFactor(dfg::NavAbilityDFG, label::Union{Symbol, String})
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  factor = getFactor(dfg.navabilityClient, context, string(label))
  @info factor
  return factor
end

function getFactors(dfg::NavAbilityDFG, regexFilter::Union{Nothing, Regex}=nothing; tags::Vector{Symbol}=Symbol[], solvable::Int=0)
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  gqlFactors = getFactors(dfg.navabilityClient, context)
  packedDfgFactors = map(v -> gqlToDfg(v),gqlFactors)
  dfgFactors = map(f -> unpackFactor(dfg, f), packedDfgFactors)
  # TODO: Implement regexFilter
  # TODO: Implement tags
  # TODO: Implement solver filter
  @info dfgFactors
  return dfgFactors
end