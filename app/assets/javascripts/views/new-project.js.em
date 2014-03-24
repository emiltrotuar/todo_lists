class TodoLists.NewProjectView extends Ember.TextField
  create: ->
    title = @get('title')
    np = @store.createRecord 'project',
          title: title
    np.save()

  
