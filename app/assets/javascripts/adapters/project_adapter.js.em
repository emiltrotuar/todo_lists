class TodoLists.ProjectAdapterLS extends DS.LSAdapter
  namespace: 'todo-lists'

  findAll: (store, type) ->
    namespace = @_namespaceForType(type)
    relationModel = type.typeForRelationship('tasks')
    tasksNamespace = @_namespaceForType(relationModel)
    results = []
    for id, project of namespace.records
      if project.tasks.length
        tasks = project.tasks
        for id, task of tasksNamespace.records
          index = tasks.indexOf(task.id)
          tasks[index] = task
          results.push Ember.copy(project)
      else
        results.push Ember.copy(project)
    Ember.RSVP.resolve
      projects: results
