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
      project = @content.get('project')
      @content.deleteRecord()
      @content.save().then (task) ->
        project.get('tasks').removeRecord(task)
        project.save()

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
