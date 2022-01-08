using NavAbilitySDK
using Caesar
using JSON

function addVariable!(dfg::NavAbilityDFG, label::Symbol, varType::Union{Type{T}, T}; maxWaitSeconds::Int=150) where T<:InferenceVariable
  context = Client(dfg.userId,dfg.robotId,dfg.sessionId)
  variable = Variable(string(label), string(varType))
  requestId = NavAbilitySDK.addVariable(dfg.navabilityClient, context, variable)
  for _ in 1:maxWaitSeconds
    savedVariable = NavAbilitySDK.getVariable(dfg.navabilityClient, context, string(label))
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