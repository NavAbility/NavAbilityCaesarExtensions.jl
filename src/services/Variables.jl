using .NavAbilityCaesarExtensions
using NavAbilitySDK
using DistributedFactorGraphs
using RoME
using JSON
using Unmarshal

# TODO: Reconcile these differences
function gqlVariableToDfg(dfg, gqlVariable)
  if haskey(gqlVariable,"label")
    ppes = map(ppe -> begin
      return unmarshal(MeanMaxPPE, ppe)
    end, gqlVariable["ppes"])
    solverData = map(sd -> begin
      packedSolverData = unmarshal(PackedVariableNodeData, sd)
      return unpackVariableNodeData(dfg, packedSolverData)
    end,gqlVariable["solverData"])
  end
  dfgVariable = unpackVariable(dfg, gqlVariable, unpackPPEs=false, unpackSolverData=false, unpackBigData=false)
  [(dfgVariable.solverDataDict[sd.solveKey] = sd) for sd in solverData]
  [(dfgVariable.ppeDict[ppe.solveKey] = ppe) for ppe in ppes]
  return dfgVariable
end

function addVariable!(dfg::NavAbilityDFG, variable::AbstractDFGVariable; maxWaitSeconds::Int=150)
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  packedVariable = packVariable(dfg, variable)
  requestId = addPackedVariable(dfg.navabilityClient, context, packedVariable)
  label = string(getLabel(variable))
  for i in 1:maxWaitSeconds
    @info i
    if exists(dfg, label)
      break
    end
    sleep(1)
  end
  return requestId
end

function getVariable(dfg::NavAbilityDFG, label::Union{Symbol, String})
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  gqlVariable = NavAbilitySDK.getVariable(dfg.navabilityClient, context, string(label))
  dfgVariable = gqlVariableToDfg(dfg, gqlVariable)
  return dfgVariable
end

function getVariables(dfg::NavAbilityDFG, regexFilter::Union{Nothing, Regex}=nothing; tags::Vector{Symbol}=Symbol[], solvable::Int=0)
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  gqlVariables = NavAbilitySDK.getVariables(dfg.navabilityClient, context)
  dfgVariables = map(v -> gqlVariableToDfg(dfg, v),gqlVariables)
  # TODO: Implement regexFilter
  # TODO: Implement tags
  # TODO: Implement solver filter
  return dfgVariables
end