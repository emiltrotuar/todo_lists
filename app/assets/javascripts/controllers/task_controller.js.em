class TodoLists.TaskController extends Ember.ObjectController
  isEditing: false

  actions:
    removeTask: (task) ->
      task.deleteRecord()
      task.save()

    edit: ->
      @set 'isEditing', true

    doneEditing: ->
      @set 'isEditing', false
      @content.save()
