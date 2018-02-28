$(document).on('click', '#cancel_achievement_edit', function(){
  var achievement_id = $('#cancel_achievement_edit').val();
  $('#edit_achievement_' + achievement_id).remove();
  $('#info_achievement_' + achievement_id).show();
});

$(document).on('click', '#cancel_achievement_new', function(){
  $('#new_achievement').remove();
  $('#btn-add-achievements').show();
});

$(document).on('click', '#cancel_user_edit', function(){
  var user_id = $('#cancel_user_edit').val();
  $('#edit_user_' + user_id).remove();
  $('#show-user').show(1000);
});

$(document).on('click', '#cancel_club_new', function(){
  $('#new_club').remove();
  $('#btn-add-club').show();
});

$(document).on('click', '#cancel_club_edit', function(){
  var club_id = $('#cancel_club_edit').val();
  $('#edit_club_' + club_id).remove();
  $('#info_club_' + club_id).show();
});

$(document).on('click', '#club_current', function(){
  if ($('#club_end_time').attr('disabled')) {
    $('#club_end_time').removeAttr('disabled');
  }
  else {
    $('#club_end_time').attr({disabled:'disabled'});
  }
  $('#club_end_time').val('');
});

$(document).on('turbolinks:load', function() {
  $('.datepick').datepicker( {
    format: 'dd-mm-yyyy',
    startView: 'months'
  });
});

$(document).on('click', '#cancel_certificate_new', function(){
  $('#new_certificate').remove();
  $('#btn-add-certificate').show();
});

$(document).on('click', '#cancel_certificate_edit', function(){
  var certificate_id = $('#cancel_certificate_edit').val();
  $('#edit_certificate_' + certificate_id).remove();
  $('#info_certificate_' + certificate_id).show();
});

$(document).on('click', '#cancel_experience_new', function(){
  $('#new_experience').remove();
  $('#btn-add-experience').show();
});

$(document).on('click', '#cancel_experience_edit', function(){
  var experience_id = $('#cancel_experience_edit').val();
  $('#edit_experience_' + experience_id).remove();
  $('#info_experience_' + experience_id).show();
});

$(document).on('click', '#checkcv', function(){
  if ($("#checkcv").is(':checked')){
    $('.cv-your').hide();
    $('.files_field').show();
  }
  else{
    $('.cv-your').show();
    $('.files_field').hide();
  }
});
$(document).on('click', '.load-page', function(){
  $('#img-loading ').show();
  $('.opacity-apply').css('opacity' ,0.8);
});

$(document).on('click', '#cv-file', function(){
  $('#radio-2').prop('checked', true);
});
