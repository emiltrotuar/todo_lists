class TodoLists.ProjectsRoute extends Ember.Route
  
  model: ->
    @store.find 'project'
