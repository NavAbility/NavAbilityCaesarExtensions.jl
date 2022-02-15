using .NavAbilityCaesarExtensions
using NavAbilitySDK

function addDataEntry!(dfg::NavAbilityDFG, label::Symbol, entry::BlobStoreEntry)
  throw("Not yet implemented.")
end

function addDataBlob!(blobstore::NavAbilityBlobStore, entry::BlobStoreEntry, blob::Vector{UInt8})
  throw("Not yet implemented.")
end

function getDataEntry(dfg::NavAbilityDFG, label::Symbol, key::Symbol)
  throw("Not yet implemented.")
end

function getDataBlob(blobstore::NavAbilityBlobStore, entry::BlobStoreEntry) where T
  throw("Not yet implemented.")
end
