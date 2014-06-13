TodoLists.ProjectSerializer = DS.RESTSerializer.extend

  extractArray: (store, type, payload, id, requestType) ->
    tasks = []

    payload.projects.forEach (project) ->
      tasks = project.tasks
      taskIds = tasks.mapBy('id')
      project.tasks = taskIds

    payload = { projects: payload.projects, tasks: tasks }

    super store, type, payload, id, requestType
