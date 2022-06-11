using NavAbilitySDK
using DistributedFactorGraphs
using RoME
using JSON

function exists(dfg::NavAbilityDFG, label::String)
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  gqlVariable = NavAbilitySDK.getVariable(dfg.navabilityClient, context, label) |> fetch
  if haskey(gqlVariable,"label") && gqlVariable["label"] == label
    return true
  end
  gqlFactor = NavAbilitySDK.getFactor(dfg.navabilityClient, context, label) |> fetch
  if haskey(gqlFactor,"label") && gqlFactor["label"] == label
    return true
  end
  return false
end