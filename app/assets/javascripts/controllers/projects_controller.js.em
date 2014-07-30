class TodoLists.ProjectsControllerAM extends Ember.ArrayController
  isButtonNew: true

  actions:
    toggleNew: ->
      @isButtonNew = not @isButtonNew
      false

    createProject: ->
      name = @get('newTitle')
      return if not name
      np = @store.createRecord 'project',
            name: name
      np.save().then ((project) ->
        console.log project
      ), (reason) =>
        console.log reason
        @switcher.switchTo('localstorage')
      @newTitle = ''
      @isButtonNew = true
      false

class TodoLists.ProjectsControllerLS extends TodoLists.ProjectsControllerAM
  actions:
    createProject: ->
      name = @get('newTitle')
      return if not name
      np = @store.createRecord 'project',
            name: name
      np.save().then ((project) ->
        console.log project
      ), (reason) =>
        console.log reason
      @newTitle = ''
      @isButtonNew = true
      false
