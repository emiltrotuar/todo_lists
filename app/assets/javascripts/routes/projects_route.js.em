class TodoLists.ProjectsRoute extends Ember.Route
  
  model: ->
    @store.find('project').then ((projects) ->
      TodoLists.authenticated = true
      projects
    ), =>
      @transitionTo 'login'
