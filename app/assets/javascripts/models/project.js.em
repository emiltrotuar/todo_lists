class TodoLists.Project extends DS.Model
  name: DS.attr 'string'
  tasks: DS.hasMany 'task'
