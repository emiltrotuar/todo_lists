class TodoLists.ProjectView extends Ember.View
  classNames: ['draggable']
  classNameBindings: ['projectId']

  projectId: ~>
    @controller.projectId

  unFolded: true

  actions:
    toggleList: ->
      @.$(".task_list").slideToggle "slow"
      @unFolded = not @unFolded

  didInsertElement: ->
    @.$(".task_list tbody").sortable
      axis: "y"
      revert: 200
      opacity: 0.5
      handle: ".reorder"
      containment: "parent"
      start: (event, ui) ->
        $("table").css "table-layout", "auto"
      update: (event, ui) =>
        ui.item.find("td:nth-child(3)").find("*").hide()
        $("table").css "table-layout", "fixed"
        dt = @.$(".task_list tbody").sortable "serialize",
          attribute: 'class'
          key: 'task[]'
        dt += "&prj_id=#{@controller.id}"
        $.ajax
          type: "post"
          data: dt
          dataType: "script"
          url: "/projects/sort"
