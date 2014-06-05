class TodoLists.ProjectController extends Ember.ObjectController
  isEditing: false

  tasks: ~>
    @store.filter 'task', {}, (task) =>
      task.get('project') is @.content

  actions:
    removeProject: (project) ->
      # project.tasks.each (task) ->
      #   task.deleteRecord()
      project.deleteRecord()
      project.save()

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
      nt.save()
      tasks = @content.get('tasks')
      tasks.pushObject nt
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
