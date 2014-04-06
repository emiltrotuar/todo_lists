class TodoLists.TasksRoute extends Ember.Route
  
  model: ->
    @store.find 'task'