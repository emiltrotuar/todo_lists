class TodoLists.ProjectsController extends Ember.ArrayController
  isButtonNew: true

  actions:
    toggleNew: ->
      @isButtonNew = not @isButtonNew
      false

    createProject: ->
      name = @get('newTitle')
      np = @store.createRecord 'project',
            name: name
      np.save()
      @set 'newTitle', ''
