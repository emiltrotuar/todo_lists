class TodoLists.NotesRoute extends Ember.Route
  
  model: ->
    @store.find 'note'

  setupController: (controller, model) ->
    super controller, model
    options =
      keys: [
        "content"
      ]
      id: "id"
    notes = TodoLists.rawNotes
    controller.fuse = new Fuse(notes, options)
