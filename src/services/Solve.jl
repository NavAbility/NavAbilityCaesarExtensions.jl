using NavAbilitySDK

function solveGraph!(dfg::NavAbilityDFG)
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  solveSession(context)
end