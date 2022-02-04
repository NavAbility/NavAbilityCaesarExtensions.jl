using .NavAbilityCaesarExtensions
using NavAbilitySDK
using DistributedFactorGraphs
using RoME

function gqlFactorToDfg(dfg, gqlFactor)
  return unpackFactor(dfg, gqlFactor)
end

function addFactor!(dfg::NavAbilityDFG, factor::AbstractDFGFactor; maxWaitSeconds::Int = 150)
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  sdkFactor = packFactor(dfg, factor)
  requestId = addPackedFactor(dfg.navabilityClient, context, sdkFactor)
  label = string(getLabel(factor))
  for i in 1:maxWaitSeconds
    @info i
    if exists(dfg, label)
      break
    end
    sleep(1)
  end
  return requestId
end

function getFactor(dfg::NavAbilityDFG, label::Union{Symbol, String})
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  gqlFactor = NavAbilitySDK.getFactor(dfg.navabilityClient, context, string(label))
  return gqlFactorToDfg(dfg, gqlFactor)
end

function getFactors(dfg::NavAbilityDFG, regexFilter::Union{Nothing, Regex}=nothing; tags::Vector{Symbol}=Symbol[], solvable::Int=0)
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  gqlFactors = NavAbilitySDK.getFactors(dfg.navabilityClient, context)
  dfgFactors = map(f -> gqlFactorToDfg(dfg, f),gqlFactors)
  # TODO: Implement regexFilter
  # TODO: Implement tags
  # TODO: Implement solver filter
  return dfgFactors
end