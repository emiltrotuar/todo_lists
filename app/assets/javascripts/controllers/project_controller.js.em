class TodoLists.ProjectController extends Ember.ObjectController
  isEditing: false
  tmpName: null

  projectId: ~>
    "project_#{@id}"

  actions:
    removeProject: ->
      @content.tasks.toArray().forEach (task) ->
        task.deleteRecord()
        task.save()
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

    createTask: ->
      name = @get('newTitle')
      return if not name
      nt = @store.createRecord 'task',
        name: name
        project: @.get('content')
      nt.save()
      nt.save().then (task) =>
        @content.get('tasks').addRecord(task)
        @content.save()
      @set 'newTitle', ''
