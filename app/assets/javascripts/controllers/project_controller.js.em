class TodoLists.ProjectController extends Ember.ObjectController
  isEditing: false

  tasks: ~>
    @store.filter 'task', {}, (task) =>
      task.get('project') is @.content

  actions:
    removeProject: (project) ->
      project.deleteRecord()
      project.save()

    edit: ->
      @set 'isEditing', true

    doneEditing: ->
      @set 'isEditing', false
      @content.save()

    createTask: ->
      title = @get('newTitle')
      nt = @store.createRecord 'task',
        title: title
        project: @.get('content')
      nt.save()
      tasks = @content.get('tasks')
      tasks.pushObject nt
      @set 'newTitle', ''

# store.findAll('task').then(function(record){
#   record.content.forEach(function(rec) {
#     Ember.run.once(this, function() {
#        rec.deleteRecord();
#        rec.save();
#     });
#   }, this);
# });
