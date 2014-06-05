TodoLists.ProjectSerializer = DS.RESTSerializer.extend
  normalizeHash:
    projects: (hash) ->
      hash.id = hash.id.$oid
      hash