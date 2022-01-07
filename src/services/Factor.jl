using NavAbilitySDK

function convert(factor::AbstractDFGFActor)::NavAbilitySDK.Factor
  throw("Not implemented yet.")
end

function addFactor!(dfg::NavAbilityDFG, factor::AbstractDFGFactor; await::Int = 150)::String
    context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
    sdkFactor = convert(factor)
    requestId = addFactor(dfg.navabilityClient, context, sdkFactor)
    for _ in 1:await
      savedFactor = getFactor(dfg.navabilityClient, context, sdkFactor.label)
      if !(savedFactor === nothing)
        break
      end
      sleep(1)
    end
    return requestId
end