class TodoLists.NewProjectView extends Ember.TextField
  create: ->
    name = @get('name')
    np = @store.createRecord 'project',
          name: name
    np.save()

  
