describe 'Integration', ->
  
  describe 'online', ->

    describe 'Project', ->

      mockProjects = []

      for i in [1..3]
        mockProjects.push
          project:
            id: "pid#{i}"
            name: "project#{i}"
            tasks: []

      it 'creates 3 new empty projects', (done) ->
        localStorage.removeItem('todo-lists-test')

        $.mockjax
          url: '/projects'
          dataType: 'json'
          responseTime: 0
          responseText:
            projects: []

        visit('projects').then ->
          $.mockjaxClear();
          for project in mockProjects
            do (project) ->
              click(':contains("New Project")')
              fillIn('#project_name', project.project.name)
              
              $.mockjax
                url: '/projects'
                responseTime: 0
                dataType: 'json'
                responseText: mockProjects[_i]
              click(':contains("Create project")')
          andThen ->
            $.mockjaxClear();
            projects = find('.draggable').length
            expect(projects).toBe 3
            for project in mockProjects
              p = find(".prj_actions p.name:eq(#{_k})").html()
              expect(p).toMatch project.project.name
            done()

      it 'updates project name', (done) ->
        edpi = -> find('.project_name_input').length
        click('.edit_project:eq("-1")').then ->
          expect(edpi()).toBe 1
        fillIn('.project_name_input','some other name')
        $.mockjax
          url: '/projects/pid3'
          status: 204
          responseTime: 0
          responseText: 'nothing'
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

      mockTasks = []

      for i in [1..2]
        mockTasks.push
          task:
            id: "tid#{i}"
            name: "task#{i}"
            done: false
            project: 'pid2'

      it 'creates 2 tasks', (done) ->
        tasksOnPage = -> find('p.task_content').length
        for task in mockTasks
          do (task) ->
            fillIn('.task_input:eq("-1")', task.task.name)
            _task = -> find("p:contains(#{task.task.name})").length
            expect(_task()).toBe 0
            click('span:contains("Create Task"):eq("-1")').then ->
              expect(_task()).toBe 1
              if tasksOnPage() is mockTasks.length
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
        click('.remove_task:eq("-1")').then ->
          expect(task()).toBe 0
          done()
