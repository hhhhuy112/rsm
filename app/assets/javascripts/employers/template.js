$(document).ready(function() {
<<<<<<< HEAD
<<<<<<< HEAD
  $('#area_apply_appointment').on('change', '.template', function(){
=======
  $('#area_apply_appointment').on('click', '.template',function(){
>>>>>>> bbf4e01... fix status apply
=======
  $('#area_apply_appointment').on('change', '.template', function(){
>>>>>>> fa774d8... fix status applies 1
    var template = $(this).val();
    $.get('/employers/templates/' + template);
  });
});

$(document).ready(function() {
<<<<<<< HEAD
<<<<<<< HEAD
  $('#area_apply_appointment').on('change', '.template_user', function(){
=======
  $('#area_apply_appointment').on('click', '.template_user',function(){
>>>>>>> bbf4e01... fix status apply
=======
  $('#area_apply_appointment').on('change', '.template_user', function(){
>>>>>>> fa774d8... fix status applies 1
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
