class TodoLists.NoteController extends Ember.ObjectController

  actions:
    removeNote: ->
      @content.deleteRecord()
      @content.save()
