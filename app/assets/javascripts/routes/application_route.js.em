class TodoLists.ApplicationRoute extends Ember.Route

  enter: ->
    setTimeout (=>
      if TodoLists.authenticated
        @transitionTo 'projects'
      else
        @transitionTo 'login'
    ), 100
