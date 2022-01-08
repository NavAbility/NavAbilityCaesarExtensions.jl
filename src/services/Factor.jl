using NavAbilitySDK
using JSON

function addFactor!(dfg::NavAbilityDFG, variables::Any, factor::Any; await::Int = 150)::String
    context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
    sdkFactor = packFactor(dfg, factor)
    requestId = NavAbilitySDK.addPackedFactor(dfg.navabilityClient, context, json(sdkFactor))
    for _ in 1:await
      savedFactor = NavAbilitySDK.getFactor(dfg.navabilityClient, context, factor.label)
      if !(savedFactor === nothing)
        break
      end
      sleep(1)
    end
    return requestId
end