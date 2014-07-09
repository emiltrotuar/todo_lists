class TodoLists.TaskController extends Ember.ObjectController
  isEditing: false
  tmpName: null

  taskId: ~>
    "task_#{@id}"

  +computed done
  isDone: (key, value) ->
    if value is undefined
      @done
    else
      @done = value
      @content.save()
      value

  actions:
    removeTask: ->
      @content.deleteRecord()
      @content.save()

    edit: ->
      @set 'isEditing', true
      @tmpName = @name

    doneEditing: ->
      @set 'isEditing', false
      @content.save()
      @tmpName = null

    cancelEditing: ->
      @set 'isEditing', false
      @name = @tmpName
      @tmpName = null
