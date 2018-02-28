$('.next').click(function(){
  $('#form-apply').hide(700);
  $('.survey').show(700);
  $('.btn-step-1').attr('disabled', true);
  $('.btn-step-2').attr('disabled', false);
  $('.next').attr('disabled', true);
  $('.previous').attr('disabled', false);
});
$('.previous').click(function(){
  $('#form-apply').show(700);
  $('.survey').hide(700);
  $('.btn-step-2').attr('disabled', true);
  $('.btn-step-1').attr('disabled', false);
  $('.next').attr('disabled', false);
  $('.previous').attr('disabled', true);
});
$('#survey-checkbox').click(function(){
  if ($('#survey-checkbox:checkbox:checked').length > 0) {
    $('.no-survey').hide(700);
    $('.has-survey').show(700);
  } else {
    $('.has-survey').hide(700);
    $('.no-survey').show(700);
  }
});
