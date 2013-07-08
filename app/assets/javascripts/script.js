jQuery.fn.submitOnCheck = function(){
	this.find('input[type=submit]').remove();
	this.find('input[type=checkbox]').click(function() {
		$(this).parent('form').submit();
	});
	return this;
}



$(function() {
	$('.edit_task').submitOnCheck();
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