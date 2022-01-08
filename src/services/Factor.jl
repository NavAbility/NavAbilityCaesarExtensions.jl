using NavAbilitySDK
using JSON
using RoME
using Caesar
using IncrementalInference

nothingDFG = DefaultDFG()

function addFactor!(dfg::NavAbilityDFG, variables, factor; await::Int = 150)::String
    context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
    sdkFactor = packFactor(nothingDFG, factor)
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