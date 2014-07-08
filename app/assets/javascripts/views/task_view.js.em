class TodoLists.TaskView extends Ember.View
  tagName: 'tr'
  classNameBindings: ['taskId']

  taskId: ~>
    @controller.taskId

  doubleClick: ->
    @controller.send('edit')
