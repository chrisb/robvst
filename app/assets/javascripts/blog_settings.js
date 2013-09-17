$(function(){
  $('.dominant-color').click(function(){
    $('#blog_background_color').val($(this).data('color'));
  });
});