class TodoLists.ApplicationRoute extends Ember.Route

  enter: ->
    if TodoLists.authenticated
      @transitionTo 'projects'
    else
      @transitionTo 'login'