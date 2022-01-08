using NavAbilitySDK
using Caesar

function convert(dfg::NavAbilityDFG, variable::AbstractDFGVariable)::NavAbilitySDK.Variable
  return packVariable(dfg, variable)
end

function addVariable!(dfg::NavAbilityDFG, variable::AbstractDFGVariable; maxWaitSeconds::Int = 150)::String
    context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
    sdkVariable = convert(dfg, variable)
    requestId = addPackedVariable(dfg.navabilityClient, context, sdkVariable)
    for _ in 1:maxWaitSeconds
      savedVariable = NavAbilitySDK.getVariable(dfg.navabilityClient, context, variable.label)
      if !(savedVariable === nothing)
        break
      end
      sleep(1)
    end
    return requestId
end

function getVariable(dfg::NavAbilityDFG, label::Union{Symbol, String})
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  return NavAbilitySDK.getVariable(dfg.navAbilityClient, context, string(label))
end

function ls(dfg::NavAbilityDFG)
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  return NavAbilitySDK.ls(dfg.navAbilityClient, context)
end