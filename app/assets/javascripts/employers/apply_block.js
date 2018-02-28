$(document).on('click', '#myonoffswitch_email', function(){
  if ($('#myonoffswitch_email').is(':checked')){
    $('#open_email').show(1000);
    $('.first_show_email').hide();
    $('.apply-status-form .email_destroy').val(false);
  }
  else{
    $('#open_email').hide(1000);
    $('.first_show_email').show();
    $('.apply-status-form .email_destroy').val(true);
  };
});

$(document).ready(function(){
  var value = $('#myonoffswitch_email').is(':checked');
  $('.apply-status-form .email_destroy').val(!value);

  if ($('#myonoffswitch_email').is(':checked')){
    $('#open_email').show();
    $('.first_show_email').hide();
  }else{
    $('.first_show_email').show();
  }
});
