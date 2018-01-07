$(document).ready(function() {
  $('#area_apply_appointment').on('change', '.template', function(){
    var template = $(this).val();
    $.get('/employers/templates/' + template);
  });
});

$(document).ready(function() {
  $('#area_apply_appointment').on('change', '.template_user', function(){
    var template = $(this).val();
    $.get('/employers/templates/' + template );
  });
});

$(document).on('click', '.open', function(){
  var id = $(this).val();
  if ($('.open').is(':checked')){
    $('.view_' + id).show();
  }else{
    $('.view_' + id).hide();
  }
});
