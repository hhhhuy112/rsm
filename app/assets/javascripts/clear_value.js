$(document).ready(function(){
  $('#post-job-btn').on('click',function(){
    $('.help-block').hide();
    $('.has-error .control-label').css('color','#394263');
    $('.has-error .form-control').css('border-color','#dbe1e8');
    $('#new_job')[0].reset();
  });

  $('#reset-job').on('click',function(){
    $('#new_apply')[0].reset();
  });
});
