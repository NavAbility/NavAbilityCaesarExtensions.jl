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
      savedVariable = getVariable(dfg.navabilityClient, context, variable.label)
      if !(savedVariable === nothing)
        break
      end
      sleep(1)
    end
    return requestId
end