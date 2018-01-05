$(document).ready(function() {
  $('#area_apply_appointment').on('click', '.template',function(){
    var template = $(this).val();
    var id = $(this).closest('.parents').find('#example-chosen-multiple').data('id');
    $.ajax({
      url: '/employers/templates/' + template ,
      data: {apply: id}
    });
  });
});

$(document).ready(function() {
  $('#area_apply_appointment').on('click', '.template_user',function(){
    var template = $(this).val();
    var id = $(this).closest('.parents').find('#example-chosen-multiple').data('id');
    $.ajax({
      url: '/employers/templates/' + template ,
      data: {apply: id}
    });
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
