class TodoLists.Task extends DS.Model
  title: DS.attr 'string'
  project: DS.belongsTo 'project'

TodoLists.Task.FIXTURES = [
  {
    id: 1
    title: 'I cant believe it!'
  }
  {
    id: 2
    title: 'Hey dude, we’re in the 21st century!'
  }
  {
    id: 3
    title: 'Hey, I think I saw it somewhere!'
  }
  {
    id: 4
    title: 'WTF?!'
  }
  { 
    id: 5
    title: 'We’re doomed!'
  }
]