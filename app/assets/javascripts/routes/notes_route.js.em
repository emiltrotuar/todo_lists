class TodoLists.NotesRoute extends Ember.Route
  
  model: ->
    @store.find 'note'
