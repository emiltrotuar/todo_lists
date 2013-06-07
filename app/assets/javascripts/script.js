$(document).ready(function() {
	$('#check_button').click(function(){
		var toAdd = $('#task_content').val();
		$('body').append(toAdd);
		$('body').append('<br>');
		$('#tmp_area').val(toAdd);
		$('.upd_ajx').remove();
	});
	$('#edit_ajx').click(function(){
		var tmp_value = "temp value";
		$('body').append('<textarea id="tmp_area" name="comment" cols="40" rows="3"></textarea>');
		$('#tmp_area').val(tmp_value);
		$('body').append('<input class="upd_ajx" type="button" value="update">');
	});
	/*$('#tara_kender').click(function(){
		var toAdd = $.ajax({
			type: "GET",
			dataType: "json",
			success: function(data) {
				alert('Load was performed.');
			}
		});
});*/
});
