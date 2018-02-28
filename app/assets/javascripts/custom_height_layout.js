$(document).ready(function(){
  var min = $( window ).height() - $('#footer').outerHeight() + 'px';
  $('#content-body-custom').css('min-height', min);
});
