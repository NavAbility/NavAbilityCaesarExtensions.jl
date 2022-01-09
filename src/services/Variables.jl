using NavAbilitySDK
using Caesar
using JSON

function gqlToDfg(gqlVariable)
  gqlVariable["timestamp"] = gqlVariable["timestamp"]["formatted"]
  for ppe in gqlVariable["ppes"]
      ppe["lastUpdatedTimestamp"] = ppe["lastUpdatedTimestamp"]["formatted"]
  end
  ppeDict = Dict()
  for ppe in gqlVariable["ppes"]
      ppeDict[ppe.solveKey] = ppe
  end
  gqlVariable["ppeDict"] = ppeDict

  return gqlVariable
end

function addVariable!(dfg::NavAbilityDFG, label::Symbol, varType::Union{Type{T}, T}; maxWaitSeconds::Int=150) where T<:InferenceVariable
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  variable = Variable(string(label), string(varType))
  requestId = NavAbilitySDK.addVariable(dfg.navabilityClient, context, variable)
  for _ in 1:maxWaitSeconds
    savedVariable = NavAbilitySDK.getVariable(dfg.navabilityClient, context, string(label))
    if !(savedVariable === nothing)
      break
    end
    sleep(1)
  end
  return requestId
end

function getVariable(dfg::NavAbilityDFG, label::Union{Symbol, String})
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  return NavAbilitySDK.getVariable(dfg.navabilityClient, context, string(label))
end

function getVariables(dfg::NavAbilityDFG, regexFilter::Union{Nothing, Regex}=nothing; tags::Vector{Symbol}=Symbol[], solvable::Int=0)
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  gqlVariables = NavAbilitySDK.getVariables(dfg.navabilityClient, context)
  packedDfgVariables = map(v -> gqlToDfg(v),gqlVariables)
  dfgVariables = map(v -> unpackVariable(dfg, v, unpackPPEs=false, unpackSolverData=false, unpackBigData=false), packedDfgVariables)
  # TODO: Implement regexFilter
  # TODO: Implement tags
  # TODO: Implement solver filter
  return dfgVariables
end