class TodoLists.Task extends DS.Model
  name: DS.attr 'string'
  done: DS.attr 'boolean'

  project: DS.belongsTo 'project'
  