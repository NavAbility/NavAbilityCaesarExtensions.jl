using NavAbilitySDK

function convert(variable::AbstractDFGVariable)::NavAbilitySDK.Variable
  throw("Not implemented yet.")
end

function addVariable!(dfg::NavAbilityDFG, variable::AbstractDFGVariable; await::Int = 150)::String
    context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
    sdkVariable = convert(variable)
    requestId = addVariable(dfg.navabilityClient, context, sdkVariable)
    for _ in 1:await
      savedVariable = getVariable(dfg.navabilityClient, context, sdkVariable.label)
      if !(savedVariable == nothing)
        break
      end
      sleep(1)
    end
    return requestId
end