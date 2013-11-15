$ ->
  tmp = undefined

  ct = (th) ->
    th.closest(".draggable").find(".task_input").focus()
    $.each $("tr"), (i, v) ->
      $("tr:eq(" + i + ")").find("td:nth-child(3) > img").after tmp[i]
    $(".ed_task").hide()
    th.closest("tr").find(".ed_task").show()  unless th.closest("tr").find("td:nth-child(3):hover").length is 0
    th.closest("tr").find("#task_complete").prop "disabled", true
    th.parent().submit()

  esc = (th) ->
    th.closest(".draggable").find(".task_input").focus()
    $.each $("tr"), (i, v) ->
      $("tr:eq(" + i + ")").find("td:nth-child(3) > img").after tmp[i]
    $(".ed_task").hide()
    th.closest("tr").find(".ed_task").show()  unless th.closest("tr").find("td:nth-child(3):hover").length is 0
    if th.closest("form").find(".dp").val() is ""
      th.closest("td").find(".date").css "display", "none"
    else
      th.closest("td").find(".date").css "display", "inline"
    th.closest("tr").find("#task_complete").prop "disabled", false
    th.parent().prev().show()
    th.parent().remove()

  $(".edit_task").submitOnCheck()

  $(".sortable").sortable
    axis: "y"
    revert: 200
    containment: "parent"
    start: (event, ui) ->
      unless ui.item.prev().length is 0
        ui.item.css "left", ui.item.prev().offset().left + "px"
      else
        ui.item.css "left", ui.item.next().offset().left + "px"
    update: (event, ui) ->
      dt = $(this).sortable("serialize")
      $.ajax
        type: "post"
        data: dt
        dataType: "script"
        url: "/projects/sortp"

  $(document).on("mouseenter", "#scroll_up", ->
    if $(document).scrollTop() > 150
      $(this).animate
        opacity: 1
      , 300
  ).on "mouseleave", "#scroll_up", ->
    $(this).animate
      opacity: 0
    , 300

  $(document).on "click", "#scroll_up", ->
    $("html").animate
      scrollTop: "0px"
    , 100, ->
      $("#scroll_up").animate
        opacity: 0
      , 500

  $(document).on "click", ".unfold, .fold", ->
    $(this).parent().find(".fold").toggle()
    $(this).parent().find(".unfold").toggle()
    $(this).closest(".draggable").find(".task_list").slideToggle "slow"

  $(document).on "dblclick", ".prj_actions", (event) ->
    d = $(this).closest(".draggable")
    if d.find(".unfold").css("display") is "none"
      d.find(".fold").click()
    else
      d.find(".unfold").click()

  $("body").on "dblclick", ".ed_prj", (event) ->
    event.stopPropagation()

  $(document).on "keydown", ".ed_prj_inp", (event) ->
    if event.keyCode is 13
      $(this).closest(".draggable").find(".task_input").focus()
      $(this).parent().submit()
    else if event.keyCode is 27
      $(".prj_actions > img").css "margin-bottom", "0px"
      $(this).closest(".draggable").find(".task_input").focus()
      $(this).parent().prevAll().show()
      $(this).parent().remove()

  $(document).on "keydown", ".ed_task_inp, .dp", (event) ->
    if event.keyCode is 13
      ct $(this)
    else esc $(this)  if event.keyCode is 27

  $(document).on "click", ".ed_task_buttons", ->
    if $(this).html() is "save"
      ct $(this)
    else
      esc $(this)

  $(document).on "click", ".x", ->
    $(this).closest(".draggable").find(".task_input").focus()
    $.each $("tr"), (i, v) ->
      $("tr:eq(" + i + ")").find("td:nth-child(3) > img").after tmp[i]
    $(".ed_task").hide()
    $(this).closest("tr").find(".ed_task").show()  unless $(this).closest("tr").find("td:nth-child(3):hover").length is 0
    $(this).closest("tr").find("#task_complete").prop "disabled", false
    $(this).next().val ""
    $(this).parent().submit()

  $(document).on "keydown", "#project_name", (event) ->
    if event.keyCode is 27
      $(this).closest("div[align=center]").prev().find(".draggable:first-child").find(".task_input").focus()
      $(this).closest("form").prev().show()
      $(this).parent().remove()

  $(document).on "click", ".del_prj", ->
    h1 = $("#projects").height()
    h2 = $(".draggable:last-child").height()
    d = $(this).closest(".draggable")
    d.animate
      opacity: 0
    , 500, ->
      d.slideUp "slow", ->
        d.remove()

  $(document).on "click", ".ed_task", ->
    tmp = $(".ed_task").detach()

  $(document).on "dblclick", "td:nth-child(2)", ->
    $(this).closest("tr").find(".ed_task").click()

  $(document).on "click", ".del_task", ->
    t = $(this).closest(".task_list")
    $(this).closest("tr").fadeOut "slow", ->
      $(this).closest("tr").detach()
      $(this).closest(".draggable").find(".task_input").focus()
      if t.find("tr").length is 0
        t.find("table").remove()
        t.append "<p>no records</p>"

  $(".task_list tbody").sortable
    axis: "y"
    revert: 200
    opacity: 0.5
    handle: ".reorder"
    containment: "parent"
    start: (event, ui) ->
      $("table").css "table-layout", "auto"
    update: (event, ui) ->
      ui.item.find("td:nth-child(3)").find("*").hide()
      $("table").css "table-layout", "fixed"
      pid = "&prj_id=" + $(this).closest(".draggable").attr("id").match(/\d+$/)
      dt = $(this).sortable("serialize") + pid
      $.ajax
        type: "post"
        data: dt
        dataType: "script"
        url: "/projects/sort"

  $(document).on("mouseenter", "tr", ->
    $(this).find("td:nth-child(3)").find("*").show()
  ).on "mouseleave", "tr", ->
    $(this).find("td:nth-child(3)").find("*").hide()
    $(this).find(".ed_task").hide()

  $.each $("tr"), (i, v) ->
    task_content = $("tr:eq(" + i + ")").find("td:nth-child(2) p").html()
    link = task_content.match(/https?:\/\/\w+\.\S*/)
    if link
      task_content_with_link = task_content.replace(link, "<a href=\"" + link + "\">" + link + "</a>")
      $("tr:eq(" + i + ")").find("td:nth-child(2) p").html task_content_with_link

jQuery.fn.submitOnCheck = -> 
  @find("input[type=checkbox]").click ->
    $(this).parent("form").submit()
  this