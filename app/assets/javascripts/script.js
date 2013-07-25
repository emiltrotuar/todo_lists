$(function() {
	var i = 0;

	$('.edit_task').submitOnCheck();

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
			$(this).parent().submit();
		} else if (event.keyCode === 27) {
			$(this).closest('.draggable').find('.task_input').focus();
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

	$(document).on('click', '.del_task', function() { /* delete task */
		$(this).closest('tr').fadeOut('slow', function() { $(this).closest('tr').remove(); }); 
	});
	
	$(document).on('mouseover', '.draggable', function(){
		$(this).draggable({ containment: "parent" });
		$(this).find('tbody').sortable();
	});

	$(document).on('mouseover', 'tr', function(){
		$(this).find('td:nth-child(3)').find()
	});
});


jQuery.fn.submitOnCheck = function(){
	this.find('input[type=checkbox]').click(function() {
		$(this).parent('form').submit();
	});
	return this;
}