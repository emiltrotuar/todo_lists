$(function() {
	var tmp;

	$('.edit_task').submitOnCheck();

	$( ".sortable" ).sortable({
		axis: "y",
		revert: 200,
		containment: "parent"
	});

	$(document).on('mouseenter', '#scroll_up', function() {
		if ($(document).scrollTop() > 150)
			$(this).animate({ opacity: 1 }, 300);
	}).on('mouseleave', '#scroll_up', function() {
		$(this).animate({ opacity: 0 }, 300);
	});

	$(document).on('click', '#scroll_up', function() {
		$('html').animate(
			{ scrollTop: "0px" }, 100,
			function() {
				$('#scroll_up').animate({ opacity: 0 }, 500);
			}
			);
	});

	$(document).on('click', '.unfold, .fold', function() { /* unfold task list */
		$(this).parent().find('.fold').toggle();
		$(this).parent().find('.unfold').toggle();
		$(this).closest('.draggable').find('.task_list').slideToggle("slow");
	});

	$(document).on('dblclick', '.prj_actions', function(event) { /* unfold task list */
		var d = $(this).closest('.draggable')
		if (d.find('.unfold').css('display') === 'none'){
			d.find('.fold').click();
		} else {
			d.find('.unfold').click();
		}
	});
	$('body').on('dblclick', '.ed_prj', function(event) {
		event.stopPropagation();
	});

	$(document).on('keypress', '.ed_prj_inp', function(event) { /* change project name */
		if (event.keyCode === 13) {
			$(this).closest('.draggable').find('.task_input').focus();
			$(this).parent().submit();
		} else if (event.keyCode === 27) {
			$('.prj_actions > img').css('margin-bottom', '0px');
			$(this).closest('.draggable').find('.task_input').focus();
			$(this).parent().prevAll().show();
			$(this).parent().remove();
		}
	});

	$(document).on('keypress', '.ed_task_inp', function(event) { /* change task name */
		if (event.keyCode === 13) {
			$(this).closest('.draggable').find('.task_input').focus();
			$.each($('tr'), function(i,v) {
				$('tr:eq('+i+')').find('td:nth-child(3) > img').after(tmp[i]);
			});
			$('.ed_task').hide();
			if ($(this).closest('tr').find('td:nth-child(3):hover').length != 0) {
				$(this).closest('tr').find('.ed_task').show();
			}
			$(this).parent().submit();
		} else if (event.keyCode === 27) {
			$(this).closest('.draggable').find('.task_input').focus();
			$.each($('tr'), function(i,v) {
				$('tr:eq('+i+')').find('td:nth-child(3) > img').after(tmp[i]);
			});
			$('.ed_task').hide();
			if ($(this).closest('tr').find('td:nth-child(3):hover').length != 0) {
				$(this).closest('tr').find('.ed_task').show();
			}
			$(this).parent().prev().show();
			$(this).parent().remove();
		}
	});

	$(document).on('keypress', '#project_name', function(event) {
		if (event.keyCode === 27) {
			$(this).closest('div[align=center]').prev().find('.draggable:first-child').find('.task_input').focus();
			$(this).closest('form').prev().show();
			$(this).parent().remove();
		}
	});

	$(document).on('click', '.del_prj', function(){  /* delete project */
		var h1 = $('#projects').height();
		var h2 = $('.draggable:last-child').height();
		var d = $(this).closest('.draggable');
		d.animate({ opacity: 0 }, 500, function() { 
			d.slideUp('slow', function(){ d.remove(); });
		});
	});

	$(document).on('click', '.ed_task', function() { /* edit task */
		tmp = $('.ed_task').detach();
	});

	$(document).on('dblclick', 'td:nth-child(2)', function() { /* edit task */
		$(this).closest('tr').find('.ed_task').click();
	});

	$(document).on('click', '.del_task', function() { /* delete task */
		var t = $(this).closest('.task_list');
		$(this).closest('tr').fadeOut('slow', function() {
			$(this).closest('tr').detach(); 
			$(this).closest('.draggable').find('.task_input').focus();
			if (t.find('tr').length === 0){
				t.find('table').remove();
				t.append('<p>no records</p>');
			}
		});
	});

	$('.task_list tbody').sortable({
		axis: "y",
		revert: 200,
		opacity: 0.5,
		handle: '.reorder',
		containment: 'parent',
		helper: function(e, ui) {
			ui.children().each(function() {
				$(this).width($(this).width());
			});
			return ui;
		},
		sort: function(event, ui) {
			$('table').css('table-layout', 'auto');
		},
		stop: function(event, ui) { 
			ui.item.find('td:nth-child(3)').find('*').hide();
			$('table').css('table-layout', 'fixed');
		}
	});

	$(document).on('mouseenter', 'tr', function(){				/* show task options if cursor over the 3rd column */
		$(this).find('td:nth-child(3)').find('*').show();
	}).on('mouseleave', 'tr', function(){
		$(this).find('td:nth-child(3)').find('*').hide();
		// $(this).find('textarea:last-child').trigger(jQuery.Event('keypress', {keyCode: 27}));
		$(this).find('.ed_task').hide();
	});

	$(document).on('mouseleave', '.prj_actions', function(){
		// $(this).find('.ed_prj_inp').trigger(jQuery.Event('keypress', {keyCode: 27}));
	});

});

jQuery.fn.submitOnCheck = function(){ 									/* save checked state of task in db */
	this.find('input[type=checkbox]').click(function() {
		$(this).parent('form').submit();
	});
	return this;
}