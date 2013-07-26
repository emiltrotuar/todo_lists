$(function() {
	var tmp;	

	$('.edit_task').submitOnCheck();

	$('.draggable').draggable({ containment: "parent" });

	$(document).on('keypress', '.ed_prj_inp', function(event) { /* change project name */
		if (event.keyCode === 13) {
			$(this).closest('.draggable').find('.task_input').focus();
			$(this).parent().submit();
		} else if (event.keyCode === 27) {
			$(this).closest('.draggable').find('.task_input').focus();
			$(this).parent().prevAll().show();
			$(this).parent().remove();
		}
	});

	$(document).on('keypress', '.ed_task_inp', function(event) { /* change task name */
		if (event.keyCode === 13) {
			$(this).closest('.draggable').find('.task_input').focus();
			$(this).closest('tr').find('td:nth-child(3) > img').after(tmp);
			$(this).parent().submit();
		} else if (event.keyCode === 27) {
			$(this).closest('.draggable').find('.task_input').focus();
			$(this).closest('tr').find('td:nth-child(3) > img').after(tmp);
			$(this).parent().prev().show();
			$(this).parent().remove();
		}
	});

	$(document).on('keypress', '#project_name', function(event) { /* unfold todo list */
		if (event.keyCode === 27) {
			$(this).closest('div[align=center]').prev().find('.draggable:first-child').find('.task_input').focus();
			$(this).closest('form').prev().show();
			$(this).parent().remove();
		}

	});

	$(document).on('click', '.del_prj', function(){  /* delete project */
		$(this).closest('.draggable').fadeOut('slow', function() { this.closest('.draggable').remove(); });
	});

	$(document).on('click', '.ed_task', function() { /* delete task */
		tmp = $(this).detach(); 
	});

	$(document).on('click', '.del_task', function() { /* delete task */
		$(this).closest('tr').fadeOut('slow', function() { $(this).closest('tr').remove(); }); 
	});

	$(document).on('mouseenter', '.reorder', function(){
		$(this).closest('tbody').sortable({
			axis: "y",
			revert: 200,
			opacity: 0.5,
			containment: "parent",
			sort: function(event, ui) {
				ui.item.find('td:nth-child(2)').width(ui.item.siblings('tr').find('td:nth-child(2)').width());
			},
			stop: function(event, ui) { 
				ui.item.find('td:nth-child(3)').find('*').hide();
			}
		});
	});

	$(document).on('mousedown', 'tbody td:nth-child(1), tbody td:nth-child(2)', function(){
		$(this).closest('tbody').sortable('destroy');
	});

	$(document).on('mouseenter', 'tr', function(){
		$(this).find('td:nth-child(3)').find('*').show();
	}).on('mouseleave', 'tr', function(){
		$(this).find('td:nth-child(3)').find('*').hide();
	});

});

jQuery.fn.submitOnCheck = function(){
	this.find('input[type=checkbox]').click(function() {
		$(this).parent('form').submit();
	});
	return this;
}