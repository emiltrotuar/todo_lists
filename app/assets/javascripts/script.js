$(document).ready(function() {
   $('#button').click(function(){
      var toAdd = $('input[name=checkListItem]').val();
      $('.list').append(toAdd);
      $('.list').append('<br>');
       });
   });