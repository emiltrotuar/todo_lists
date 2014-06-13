class TodoLists.TaskController extends Ember.ObjectController
  isEditing: false

  actions:
    removeTask: ->
      @content.deleteRecord()
      @content.save()

    edit: ->
      @set 'isEditing', true

    doneEditing: ->
      @set 'isEditing', false
      @content.save()
