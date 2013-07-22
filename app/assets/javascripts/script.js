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
			$('#prj_actions').prepend(tmp);
			$('#ed_prj_inp').select();
			$('#ed_prj, #name').hide();
		}
	});

	$('#prj_actions').on('keypress', '#ed_prj_inp', function(event) { /* update project name etc. */
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

	$('#del_prj').click(function(){
		$(this).parent().parent().fadeOut('slow', function() { $(this).parent().parent().remove(); });
	});

	$('.task_input').keypress(function(event) { /* on press enter */
		if (event.keyCode === 13) {
			event.preventDefault();
			AddTask();
		}
	});

	$('tbody').sortable();

	$('.draggable').draggable({ containment: "window" });

	function AddTask(params) {
		if ($('.task_input').val() === "") return;
		else {
			var task = $('.task_input').val();
			$('table').append('<tr id="<%= project.id %>_<%= task.id %>"><td width="10px"><input type="checkbox"></td>\
				<td width="205px">\
				<p>'+task+'</p>\
				</td>\
				<td width="35px">\
				<button class="btn btn-small btn-primary" type="button" onclick="edit_task(this)">edit</button>\
				</td>\
				<td width="35px">\
				<button class="btn btn-small btn-primary" type="button" onclick="del_task(this)">delete</button>\
				</td>	\
				</tr>');
			$('tr').last().addClass("tabr"+i).hide().fadeIn(500);
			$('.btn-small').last().addClass("buts"+i);
			$('.task_input').val('').focus();
			i++;
		}

	}
});

/*function subm_form(e) {
	var dt = $(e).parent().serialize();
	$.ajax({
		url: "/tasks",
		dataType: "html",
		type: "post",
		data: dt,
		//success: function(){ alert(dt);},
		error: function(){ alert("fuck");}
	});
	return false;
}*/

jQuery.fn.edit_task = function(e) {
	var tmp = $(e).parent().parent().attr('class');
	var tmp2 =  '.'+tmp+' td:nth-child(2) p';
	var val = $(tmp2).html();
	$(tmp2).detach();
	tmp2 = '<input type="text" id="ed_tsk_inp" value="'+val+'">';
	$('.'+tmp+' td:nth-child(2)').append(tmp2);
}

jQuery.del_task = function(e) {
	$(e).parent().parent().hide('slow', function() { $(e).parent().parent().remove(); });
}

jQuery.fn.submitOnCheck = function(){
	this.find('input[type=checkbox]').click(function() {
		$(this).parent('form').submit();
	});
	return this;
}