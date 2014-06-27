class TodoLists.LoginRoute extends Ember.Route

  enter: ->
    setTimeout (=>
      if TodoLists.authenticated
        @transitionTo 'projects'
    ), 100