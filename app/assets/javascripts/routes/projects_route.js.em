class TodoLists.ProjectsRoute extends Ember.Route
  
  beforeModel: ->


  model: ->
    @store.find 'project'