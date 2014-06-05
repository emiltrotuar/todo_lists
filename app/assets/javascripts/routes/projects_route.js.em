class TodoLists.ProjectsRoute extends Ember.Route
  
  model: ->
    # @store.find 'task'
    @store.find 'project'