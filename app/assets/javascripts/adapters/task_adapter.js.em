# class TodoLists.TaskAdapter extends DS.LSAdapter
#   namespace: 'todo-lists'

#   createRecord: (store, type, record) ->
#     namespaceRecords = @_namespaceForType(type)
#     recordHash = record.serialize(includeId: true)
#     namespaceRecords.records[recordHash.id] = recordHash
#     @persistData type, namespaceRecords, recordHash
#     Ember.RSVP.resolve()

#   persistData: (type, data, task) ->
#     modelNamespace = @modelNamespace(type)
#     @_updateProjectRelationships(super, task)
#     localStorageData = @loadData()
#     localStorageData[modelNamespace] = data
#     localStorage.setItem @adapterNamespace(), JSON.stringify(localStorageData)

#   _updateProjectRelationships: (sup, task) -> 
#     localStorageData = @loadData()
#     project = localStorageData.project.records[task.project]
#     project.tasks.push task.id
#     namespaceRecords = @_namespaceForType('project')
#     namespaceRecords.records[project.id] = project
#     sup.apply @, ['project', namespaceRecords]

#   modelNamespace: (type) ->
#     super(type) || type