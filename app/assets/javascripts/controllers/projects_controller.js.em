class TodoLists.ProjectsController extends Ember.ArrayController

  actions:
    newProject: ->

    createProject: ->
      name = @get('newTitle')
      np = @store.createRecord 'project',
            name: name
      np.save()
      @set 'newTitle', ''
