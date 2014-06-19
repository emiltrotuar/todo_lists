class TodoLists.ProjectController extends Ember.ObjectController
  isEditing: false

  projectId: ~>
    "project_#{@id}"

  actions:
    removeProject: ->
      @content.deleteRecord()
      @content.save()

    edit: ->
      @set 'isEditing', true

    doneEditing: ->
      @set 'isEditing', false
      @content.save()

    createTask: ->
      name = @get('newTitle')
      nt = @store.createRecord 'task',
        name: name
        project: @.get('content')

      nt.save() # check if successful

      @set 'newTitle', ''
