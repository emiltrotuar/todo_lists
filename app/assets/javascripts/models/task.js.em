class TodoLists.Task extends DS.Model
  title: DS.attr 'string'
  project: DS.belongsTo 'project'
  