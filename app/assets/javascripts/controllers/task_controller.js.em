class TodoLists.TaskController extends Ember.ObjectController
  isEditing: false
  tmpName: null

  taskId: ~>
    "task_#{@id}"

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
