class TodoLists.Switcher extends Ember.Object
  switchTo: (persistencelayer) ->
    container = TodoLists.__container__
    switch persistencelayer
      when 'localstorage'
        container.unregister('adapter:application')
        container.register('adapter:application', DS.LSAdapter)
        container.unregister('adapter:project')
        container.register('adapter:project', TodoLists.ProjectAdapterLS)
        container.unregister('controller:project')
        container.register('controller:project', TodoLists.ProjectControllerLS)
        container.unregister('controller:task')
        container.register('controller:task', TodoLists.TaskControllerLS)
      when 'activemodel'
        container.unregister('adapter:project')
        container.unregister('adapter:application')
        container.unregister('controller:project')
        container.unregister('controller:task')
        container.register('adapter:application', DS.ActiveModelAdapter)
