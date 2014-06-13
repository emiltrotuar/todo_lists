class TodoLists.ProjectController extends Ember.ObjectController
  isEditing: false

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

# store = TodoLists.__container__.lookup('store:main')
# store.findAll('task').then(function(record){
#   record.content.forEach(function(rec) {
#     Ember.run.once(this, function() {
#        rec.deleteRecord();
#        rec.save();
#     });
#   }, this);
# });
