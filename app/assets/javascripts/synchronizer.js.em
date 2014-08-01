class TodoLists.Synchronizer extends Ember.Object
  sync: ->
    console.log 'sync'
    projects = @store.typeMapFor(TodoLists.Project).records
    projects.forEach (project) =>
      type = project.constructor
      adapter = @store.adapterFor(type)
      adapter.createRecord(@store,type,project)

    tasks = @store.typeMapFor(TodoLists.Task).records
    tasks.forEach (task) =>
      type = task.constructor
      adapter = @store.adapterFor(type)
      adapter.createRecord(@store,type,task)
