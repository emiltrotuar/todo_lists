class TodoLists.ProjectController extends Ember.ObjectController
  isEditing: false

  actions:
    removeProject: (project) ->
      @removeProject(project)

    edit: ->
      @set 'isEditing', true

    doneEditing: ->
      @set 'isEditing', false

    createTask: ->
      title = @get('newTitle')
      nt = @store.createRecord 'task',
            title: title
      nt.save()
      @set 'newTitle', ''

  removeProject: (project) ->
    project.deleteRecord()
    project.save()
