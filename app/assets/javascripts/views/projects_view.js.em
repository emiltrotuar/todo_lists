class TodoLists.ProjectsView extends Ember.View

  didInsertElement: ->
    $(".sortable").sortable
      axis: "y"
      revert: 200
      containment: "parent"
      items: '> .draggable'
      start: (event, ui) ->
        unless ui.item.prev().length is 0
          ui.item.css "left", ui.item.prev().offset().left + "px"
        else
          ui.item.css "left", ui.item.next().offset().left + "px"
      update: (event, ui) ->
        dt = $(".sortable").sortable "serialize",
          attribute: 'class'
          key: 'project[]'
        $.ajax
          type: "post"
          data: dt
          dataType: "script"
          url: "/projects/sortp"
