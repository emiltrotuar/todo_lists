class TodoLists.NotesRoute extends Ember.Route
  
  model: ->
    @store.find('note').then ((notes) ->
      TodoLists.authenticated = true
      notes
    ), =>
      @transitionTo 'login'

  setupController: (controller, model) ->
    super controller, model
    options =
      keys: [
        "content"
      ]
      id: "id"
    notes = TodoLists.rawNotes
    controller.fuse = new Fuse(notes, options)
