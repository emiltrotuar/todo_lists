describe 'Integration', ->

  describe 'Project', ->

    it 'creates project', (done) ->
      visit '/projects'
      fillIn '#new_project', 'testproject'
      click('#create_project').then ->
        project = find('li span:contains("testproject")').length
        expect(project).toBe 1
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

  describe 'Task', ->

    it 'creates task', (done) ->
      fillIn '#new_task', 'test123'
      click('#create_task').then ->
        task = find('li span:contains("test123")').length
        expect(project).toBe 1
        done()

    xit 'edits task name', ->
      click ':contains("edit")'
      expect(task).toBe true