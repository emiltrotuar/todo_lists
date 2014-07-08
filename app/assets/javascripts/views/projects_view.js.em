class TodoLists.ProjectsView extends Ember.View
  classNames: ['sortable', 'projects']

  didInsertElement: ->
    $(".sortable").sortable
      axis: "y"
      revert: 200
      containment: "parent"
      items: '> .draggable'
      start: (event, ui) ->
        ui.item.css "left", ui.item.parent().offset().left + "px"
      update: (event, ui) =>
        dt = $(".sortable").sortable "serialize",
          attribute: 'class'
          key: 'project[]'
        $.ajax
          type: "post"
          data: dt
          dataType: "script"
          url: "/projects/sortp"
