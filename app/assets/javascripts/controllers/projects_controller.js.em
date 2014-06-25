class TodoLists.ProjectsController extends Ember.ArrayController
  isButtonNew: true

  # +observer TodoLists.authenticated
  # fetchItems: ->
  #   if TodoLists.authenticated
  #     fetch(TodoLists.authentication_token)

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
