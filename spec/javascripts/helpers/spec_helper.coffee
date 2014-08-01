document.write """
               <div id="ember-testing-container">
                 <div id="ember-testing"></div>
               </div>
               """
document.write """
               <style>
                 #ember-testing-container {
                   position: absolute; 
                   background: white; 
                   bottom: 0; 
                   right: 0; 
                   width: 640px; 
                   height: 384px; 
                   overflow: auto; 
                   z-index: 888; 
                   border: 1px solid #ccc; 
                 } 
                 #ember-testing { 
                   zoom: 50%; 
                   height: 100%
                 }
               </style>
               """

Ember.Test.adapter = Ember.Test.Adapter.create()

TodoLists.rootElement = '#ember-testing'

TodoLists.Router.reopen
  location: 'none'

# TodoLists.ProjectAdapter = DS.LSAdapter.extend
#   namespace: 'todo-lists-test'

#   findAll: (store, type) ->
#     namespace = @_namespaceForType(type)
#     relationModel = type.typeForRelationship('tasks')
#     tasksNamespace = @_namespaceForType(relationModel)
#     results = []
#     for id, project of namespace.records
#       if project.tasks.length
#         tasks = project.tasks
#         for id, task of tasksNamespace.records
#           index = tasks.indexOf(task.id)
#           tasks[index] = task
#           results.push Ember.copy(project)
#       else
#         results.push Ember.copy(project)
#     Ember.RSVP.resolve
#       projects: results

# TodoLists.TaskAdapter = DS.LSAdapter.extend
#   namespace: 'todo-lists-test'

TodoLists.injectTestHelpers()
