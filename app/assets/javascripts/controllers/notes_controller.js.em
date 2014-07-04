class TodoLists.NotesController extends Ember.ArrayController

  fuse: null

  searchResults: (request, response) ->
    console.log 'searchResults', @, arguments
    res = @fuse.search request.term
    notes = []
    for id in res
      notes.push TodoLists.normalizedNotes[id]
    response notes