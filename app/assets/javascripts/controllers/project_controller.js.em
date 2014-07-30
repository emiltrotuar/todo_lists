class TodoLists.ProjectControllerAM extends Ember.ObjectController
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
      nt = @store.createRecord 'task',
        name: name
        project: @.get('content')
      nt.save().then ((task) ->
        console.log task
      ), (reason) =>
        console.log reason
        @switcher.switchTo('localstorage')
        @synchronizer.sync()
      @newTitle = ''

class TodoLists.ProjectControllerLS extends TodoLists.ProjectControllerAM
  actions:
    removeProject: ->
      @content.tasks.toArray().forEach (task) ->
        task.deleteRecord()
        task.save()
      super()

    createTask: ->
      name = @get('newTitle')
      return if not name
      nt = @store.createRecord 'task',
        name: name
        project: @.get('content')
      nt.save().then ((task) =>
        @content.get('tasks').addRecord(task)
        @content.save()
      ), (reason) ->
        console.log reason
      @newTitle = ''
