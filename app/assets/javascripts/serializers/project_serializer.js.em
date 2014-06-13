TodoLists.ProjectSerializer = DS.RESTSerializer.extend

  extractArray: (store, type, payload, id, requestType) ->
    tasks = []

    payload.projects.forEach (project) ->
      project.tasks.forEach (task) ->
        tasks.push task
      taskIds = project.tasks.mapBy('id')
      project.tasks = taskIds

    payload = { projects: payload.projects, tasks: tasks }

    super store, type, payload, id, requestType
