using NavAbilitySDK

function solveGraph!(dfg::NavAbilityDFG; maxWaitSeconds::Int = 300)
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  solveSession(dfg.navabilityClient, context)
end