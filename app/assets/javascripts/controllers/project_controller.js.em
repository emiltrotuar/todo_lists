class TodoLists.ProjectController extends Ember.ObjectController

  actions:
    removeProject: ->
      @removeProject()

  removeProject: ->
    pr = @get 'model'
    pr.deleteRecord()
    pr.save()
