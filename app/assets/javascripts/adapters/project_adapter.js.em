# class TodoLists.ProjectAdapter extends DS.LSAdapter
#   namespace: 'todo-lists'

#   findAll: (store, type) ->
#     namespace = @_namespaceForType(type)
#     relationModel = type.typeForRelationship('tasks')
#     tasksNamespace = @_namespaceForType(relationModel)
#     results = []
#     for id, project of namespace.records
#       if project.tasks.length
#         tasks = project.tasks
#         for id, task of tasksNamespace.records
#           index = tasks.indexOf(id)
#           tasks[index] = task
#           results.push Ember.copy(project)
#       else
#         results.push Ember.copy(project)
#     Ember.RSVP.resolve
#       projects: results

#   createRecord: (store, type, record) ->
#     namespaceRecords = @_namespaceForType(type)
#     recordHash = @serializeHasMany(record, json, relationship)
#     recordHash = record.serialize(includeId: true)
#     namespaceRecords.records[recordHash.id] = recordHash
#     @persistData type, namespaceRecords
#     Ember.RSVP.resolve()
