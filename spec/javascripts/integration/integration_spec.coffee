describe 'Integration', ->

  describe 'Project', ->

    # mockTask1 =
    #   id: 't1'
    #   name: 'task1'
    #   project: 'p1'

    # mockTask2 =
    #   id: 't2'
    #   name: 'task2'
    #   project: 'p1'

    # mockTask3 =
    #   id: 't3'
    #   name: 'task3'
    #   project: 'p2'

    # mockTask4 =
    #   id: 't4'
    #   name: 'task4'
    #   project: 'p2'

    # mockProject1 =
    #   id: "p1"
    #   name: "one"
    #   tasks: [
    #     mockTask1
    #     mockTask2
    #   ]

    # mockProject2 =
    #   id: "p2"
    #   name: "two"
    #   tasks: [
    #     mockTask3
    #     mockTask4
    #   ]

    # FIXTURES =
    #   project:
    #     records: [
    #       mockProject1
    #       mockProject2
    #     ]

    # localStorage.setItem('todo-lists', JSON.stringify(FIXTURES));

    it 'creates 2 new empty projects', (done) ->
      visit('projects')

      for proname in ['abc','xyz','dof']
        do (proname) ->
          click(':contains("New Project")')
          fillIn('#project_name', proname)
          click(':contains("Create project")')

      andThen ->
        projects = find('.draggable').length
        expect(projects).toBe 3
        done()

    it 'updates project name', (done) ->
      edpi = -> find('.project_name_input').length
      click('.edit_project:eq("-1")').then ->
        expect(edpi()).toBe 1
      fillIn('.project_name_input','some other name')
      keyEvent('.project_name_input', 'keyup.ember', 13).then ->
        expect(edpi()).toBe 0
        done()

    it 'deletes project', (done) ->
      project = -> $('.draggable .name:contains("some other name")').eq('-1').length
      expect(project()).toBe 1
      click('.remove_project:eq("-1")')
      andThen ->
        expect(project()).toBe 0
        done()

  describe 'Task', ->

    it 'creates task', (done) ->
      fillIn '.task_input:eq("-1")', 'test123'
      task = -> find('p:contains("test123")').length
      expect(task()).toBe 0
      click('span:contains("Create Task"):eq("-1")').then ->
        expect(task()).toBe 1
        done()

    it 'updates task', (done) ->
      edti = -> find('.task_name_input').length
      click('.edit_task:eq("-1")').then ->
        expect(edti()).toBe 1
      fillIn('.task_name_input','some other task')
      keyEvent('.task_name_input', 'keyup.ember', 13).then ->
        expect(edti()).toBe 0
        done()

    it 'deletes task', (done) ->
      task = -> $('.task_list .task_content:contains("some other task")').length
      expect(task()).toBe 1
      click('.remove_task:eq("-1")')
      andThen ->
        expect(task()).toBe 0
        done()

  # it 'fetches projects from local storage', (done) ->
  #   visit('projects').then ->
  #     projects = FIXTURES.project.records
  #     find('.projects .draggable').each (pindex) ->
  #       item = $(@).find('.prj_actions p.name').html()
  #       expect(item).toMatch projects[pindex].name
  #       $(@).find('.task_list tr').each (tindex) ->
  #         item = $(@).find('.task_content').html()
  #         expect(item).toMatch projects[pindex].tasks[tindex].name
  #         if pindex is 1 and tindex is 1
  #           done()

  it 'removes test data from localStorage', ->
    expect(localStorage['todo-lists-test']).toBeDefined()
    localStorage.removeItem('todo-lists-test')
    expect(localStorage['todo-lists-test']).not.toBeDefined()
