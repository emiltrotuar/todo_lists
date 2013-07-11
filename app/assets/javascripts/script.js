function btn_view(e) {
	$(e).parent().parent().hide('slow');
}

$(function() {
	var i = 0;
	$('#addbutt').click(function() {
		var tmp = $('input').val();
		$('table').append('<tr><td width="10px"><input type="checkbox"></td><td width="205px">\
			<p>'+tmp+'</p>\
			</td>\
			<td width="35px">\
			<button class="btn btn-small btn-primary" type="button" onclick="btn_view(this)">delete</button>\
			</td></tr>');
		$('tr').last().addClass("tabr"+i);
		$('.btn-small').last().addClass("buts"+i);
		i++;
	});
	$('.edit_task').mouseenter(
		function () {
			$(this).css( "background-color", "#FFFFCC" );
			var tmp = $(this).attr( "id" );
			var lnk = $('#'+tmp).find('a').show();
		}
		).mouseleave(function(){
			$(this).css( "background-color", "inherit" );
			$(this).find('a').hide();
		});
	});


