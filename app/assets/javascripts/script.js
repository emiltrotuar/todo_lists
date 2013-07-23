$(function() {
	var i = 0;

	$('.edit_task').submitOnCheck();

	$('#ed_prj').click(function(){ /* edit project name etc. */
		var val = $('#name').html();
		if ($('#ed_prj_inp').length){
			$('#ed_prj_inp').show().val(val).select();
			$('#ed_prj, #name').hide();
		}
		else {
			var tmp = '<input type="text" id="ed_prj_inp" value="'+val+'">';
			$('.prj_actions').prepend(tmp);
			$('#ed_prj_inp').select();
			$('#ed_prj, #name').hide();
		}
	});

	$('td').on('click', '.del_task', function(e) {
		$(this).parent()
					 .parent()
					 .fadeOut('slow', function() { $(e).parent()
																						 .parent()
																						 .remove(); }); 
	});

	$('.prj_actions').on('keypress', '#ed_prj_inp', function(event) { /* update project name etc. */
		if (event.keyCode === 13) {
			var val = $('#ed_prj_inp').val();
			var tmp = '<p id="name" style="display: inline-block">'+val+'</p>\
			<img id="ed_prj" src="edit.png" width="12px" height="12px" style="display: none">';
			event.preventDefault();
			$('#ed_prj_inp').hide();
			$('#ed_prj, #name').show();
			$('.task_input').focus();
			$('#name').html(val);
		} 
		else if (event.keyCode === 27){
			event.preventDefault();
			$('#ed_prj_inp').hide();
			$('#ed_prj, #name').show();
			$('.task_input').focus();
		}
	});

	$(document).on('click', '.del_prj', function(){
		$(this).closest('.draggable').fadeOut('slow', function() { this.closest('.draggable').remove(); });
	});

	$('.new_task').on('keypress', 'input[type=text]', function(event) { /* on press enter */
		if (event.keyCode === 13) {
			this.parent().submit();
		}
	});

	$('tbody').sortable();

	$('.draggable').draggable({ containment: "window" });

	$(document).on('click', '.del_prj', function () {
    // deleteProject($(this).closest('.draggable')); 
    deleteProject($(this).parent().parent().parent());
  });
});

jQuery.fn.edit_task = function(e) {
	var tmp = $(e).parent().parent().attr('class');
	var tmp2 =  '.'+tmp+' td:nth-child(2) p';
	var val = $(tmp2).html();
	$(tmp2).detach();
	tmp2 = '<input type="text" id="ed_tsk_inp" value="'+val+'">';
	$('.'+tmp+' td:nth-child(2)').append(tmp2);
}

jQuery.fn.submitOnCheck = function(){
	this.find('input[type=checkbox]').click(function() {
		$(this).parent('form').submit();
	});
	return this;
}

// function deleteProject(prj) {
// 	$.ajax({
// 		url: "/projects/destroy",
// 		method: "post",
// 		data: {"id": prj.attr('id')},
// 		dataType: "json",
// 		success: function(prj){
// 			alert('ok');
// 			prj.fadeOut('slow', function() {prj.remove()});
// 		},
// 		error: function() {
// 			alert(prj.attr('id'))
//       //alert("failed to delete item.");
//     }
//   });
// }
