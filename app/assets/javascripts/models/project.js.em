class TodoLists.Project extends DS.Model
  title: DS.attr 'string'
  tasks: DS.hasMany 'task', async: true

TodoLists.Project.FIXTURES = [
  {
    id: 1
    title: 'Big brother is watching you!'
    tasks: [1, 2]
  }
  {
    id: 2
    title: 'Novus ordo seclorum'
    tasks: [3, 4, 5]
  }
]

