class TodoLists.ProjectController extends Ember.ObjectController
  isEditing: false
  tmpName: null

  projectId: ~>
    "project_#{@id}"

  actions:
    removeProject: ->
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
      @set 'newTitle', ''
      nt = @store.createRecord 'task',
        name: name
        project: @.get('content')
      nt.save().then => , (reason) =>
        console.log reason
        @switcher.switchTo('localstorage')


class TodoLists.ProjectControllerLS extends TodoLists.ProjectController
  actions:
    removeProject: ->
      @content.tasks.toArray().forEach (task) ->
        task.deleteRecord()
        task.save()
      super()

    createTask: ->
      super().then ((task) =>
        @content.get('tasks').addRecord(task)
        @content.save()
      ), (reason) =>
        console.log reason
        # retry()
