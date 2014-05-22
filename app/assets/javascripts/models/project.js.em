class TodoLists.Project extends DS.Model
  title: DS.attr 'string'
  tasks: DS.hasMany 'task', async: true
