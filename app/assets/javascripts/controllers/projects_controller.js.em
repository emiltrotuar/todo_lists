class TodoLists.ProjectsController extends Ember.ArrayController

  actions:
    newProject: ->

    createProject: ->
      title = @get('newTitle')
      np = @store.createRecord 'project',
            title: title
      np.save()
      @set 'newTitle', ''
