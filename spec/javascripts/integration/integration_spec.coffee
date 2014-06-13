describe 'Integration', ->

  describe 'Project', ->

    mockTask1 =
      id: '111'
      name: 'moket'
      project: '00000'

    mockTask2 =
      id: '222'
      name: 'poket'
      project: '00000'

    mockProject1 = 
      id: '00000'
      name: 'abc'
      tasks: [mockTask1, mockTask2]
    

    mockTask3 =
      id: '333'
      name: 'rocket'
      project: '11111'

    mockTask4 =
      id: '444'
      name: 'soket'
      project: '11111'

    mockProject2 = 
      id: '11111'
      name: 'xyz'
      tasks: [mockTask3, mockTask4]
    

    mockData = { projects: [mockProject1, mockProject2] }

    it 'fetches list of mock projects', (done) ->
      idx = $.mockjax
        url: "/projects"
        responseTime: 0
        responseText: mockData

      visit('projects').then ->
        find('#projects .draggable').each (pindex) ->
          item = $(@).find('.prj_actions p.name').html()
          expect(item).toMatch mockData.projects[pindex].name
          $(@).find('.task_list').each (tindex) ->
            item = $(@).find('.task_content').html()
            expect(item).toMatch mockData.projects[pindex].tasks[tindex].name
            $.mockjaxClear idx
            done()

    it 'adds new project', (done) ->
      proData = {"project":{"id":"539b0425776d001993090000","name":"2e","tasks":[]}}
      crp = $.mockjax
        url: "/projects"
        responseTime: 0
        responseText: mockData

      fillIn '#new_project', 'dock123'
      click('#create_project').then ->
        project = find('.prj_actions p.name:contains("dock123")').length
        expect(project).toBe 1
        $.mockjaxClear crp
        done()

    xit 'edits project name', (done) ->
      click(':contains("edit")').then ->
        editProject = find('.edit_project').length
        expect(editProject).toBe 1
      fillIn('.edit_project', 'some other name')
      click('button:contains("done")').then ->
        newProjectName = find('li span:contains("some other name")').length
        expect(newProjectName).toBe 1
        done()

    xit 'does not allow to add already existing project', ->
      project = 'test12'
      already = project
      fillIn '#new_project', project
      click('button:contains("Create project")')
      fillIn '#new_project', already
      click('button:contains("Create project")').then ->
        project = find("li span:contains(#{project})").length
        expect(project).toBe 1
        alreadyNotification = find('notification_popup').length
        expect alreadyNotification toBe 1
        done()

    xit 'cancels editing project name', (done) ->
      click(':contains("edit")').then ->
        editProject = find('.edit_project').length
        expect(editProject).toBe 1
      fillIn('#edit_item', 'some_other_name')
      click('button:contains("done")').then ->
        expect(newProjectName).toBe 'some_other_name'
        done()

  xdescribe 'Task', ->

    xit 'creates task', (done) ->
      fillIn '#new_task', 'test123'
      click('#create_task').then ->
        task = find('li span:contains("test123")').length
        expect(project).toBe 1
        done()

    xit 'edits task name', ->
      click ':contains("edit")'
      expect(task).toBe true