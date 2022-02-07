using .NavAbilityCaesarExtensions
using NavAbilitySDK

function addDataEntry!(dfg::NavAbilityDFG, label::Symbol, entry::AbstractDataEntry)
  throw("Not yet implemented.")
end

function addDataBlob!(blobstore::NavAbilityBlobStore{T}, entry::AbstractDataEntry, blob::Vector{UInt8})
  throw("Not yet implemented.")
end

function getDataEntry(dfg::NavAbilityDFG, label::Symbol, key::Symbol)
  throw("Not yet implemented.")
end

function getDataBlob(blobstore::NavAbilityBlobStore{T}, entry::AbstractDataEntry) where T
  throw("Not yet implemented.")
end
