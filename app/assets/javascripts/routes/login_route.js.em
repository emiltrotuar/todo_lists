class TodoLists.LoginRoute extends Ember.Route

  enter: ->
    if TodoLists.authenticated
      @transitionTo 'projects'
