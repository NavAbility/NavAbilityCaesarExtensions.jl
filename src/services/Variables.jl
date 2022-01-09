using NavAbilitySDK
using DistributedFactorGraphs
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

function addVariable!(dfg::NavAbilityDFG, variable::AbstractDFGVariable; maxWaitSeconds::Int=150)
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  packedVariable = packVariable(dfg, variable)
  @info packedVariable
  requestId = addPackedVariable(dfg.navabilityClient, context, packedVariable)
  for _ in 1:maxWaitSeconds
    savedVariable = getVariable(dfg, getLabel(variable))
    if !(savedVariable === nothing)
      @info savedVariable
      break
    end
    sleep(1)
  end
  return requestId
end

function getVariable(dfg::NavAbilityDFG, label::Union{Symbol, String})
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  variable = getVariable(dfg.navabilityClient, context, string(label))
  @info variable
  return variable
end

function getVariables(dfg::NavAbilityDFG, regexFilter::Union{Nothing, Regex}=nothing; tags::Vector{Symbol}=Symbol[], solvable::Int=0)
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  gqlVariables = getVariables(dfg.navabilityClient, context)
  packedDfgVariables = map(v -> gqlToDfg(v),gqlVariables)
  dfgVariables = map(v -> unpackVariable(dfg, v, unpackPPEs=false, unpackSolverData=false, unpackBigData=false), packedDfgVariables)
  # TODO: Implement regexFilter
  # TODO: Implement tags
  # TODO: Implement solver filter
  @info dfgVariables
  return dfgVariables
end