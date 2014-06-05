class TodoLists.Task extends DS.Model
  name: DS.attr 'string'
  project: DS.belongsTo 'project'
  