class TodoLists.ProjectSerializer extends DS.RESTSerializer

  extractArray: (store, type, payload, id, requestType) ->
    tasks = []

    payload.projects.forEach (project) ->
      project.tasks.forEach (task) ->
        tasks.push task
      taskIds = project.tasks.mapBy('id')
      project.tasks = taskIds

    payload = { projects: payload.projects, tasks: tasks }

    super store, type, payload, id, requestType

  serializeHasMany: (record, json, relationship) ->
    key = relationship.key
    relationshipType = DS.RelationshipChange.determineRelationshipType(record.constructor, relationship)
    json[key] = record.get(key).mapBy("id")  if relationshipType is "manyToNone" or relationshipType is "manyToMany" or relationshipType is "manyToOne"
    return
