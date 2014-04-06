class TodoLists.TaskController extends Ember.ObjectController
  isEditing: false

  actions:
    removeTask: (task) ->
      @removeTask(task)

    edit: ->
      @set 'isEditing', true

    doneEditing: ->
      @set 'isEditing', false

  removeTask: (task) ->
    task.deleteRecord()
    task.save()