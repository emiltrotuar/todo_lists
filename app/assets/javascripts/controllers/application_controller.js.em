class TodoLists.ApplicationController extends Ember.ObjectController

  actions:
    signOut: ->
      TodoLists.authentication.authenticate 'unauthenticate', {},
        success: =>
          console.log 'signed out'
          TodoLists.authenticated = false
          @transitionToRoute 'login'
        error: (data) =>
          console.log data