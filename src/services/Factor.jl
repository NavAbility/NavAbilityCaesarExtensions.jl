using NavAbilitySDK

function convert(dfg::NavAbilityDFG, factor::AbstractDFGFActor)::NavAbilitySDK.Factor
  packFactor(dfg, factor)
end

function addFactor!(dfg::NavAbilityDFG, factor::AbstractDFGFactor; await::Int = 150)::String
    context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
    sdkFactor = convert(dfg, factor)
    requestId = addPackedFactor(dfg.navabilityClient, context, sdkFactor)
    for _ in 1:await
      savedFactor = getFactor(dfg.navabilityClient, context, factor.label)
      if !(savedFactor === nothing)
        break
      end
      sleep(1)
    end
    return requestId
end