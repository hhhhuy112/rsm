$(document).on('click', '#myonoffswitch', function(){
  if ($('#myonoffswitch').is(':checked')){
    $('#open').show(1000);
    $('.first_show').hide();
  }
  else{
    $('#open').hide(1000);
    $('.first_show').show();
  };
});

$(document).on('click', '#myonoffswitch_branch', function(){
  if ($('#myonoffswitch_branch').is(':checked')){
    $('#open_branch').show(1000);
    $('.first_show_branches').hide();
  }
  else{
    $('#open_branch').hide(1000);
    $('.first_show_branches').show();
  };
});

$(document).on('click', '#myonoffswitch_category', function(){
  if ($('#myonoffswitch_category').is(':checked')){
    $('#open_category').show(1000);
    $('.first_show_category').hide();
  }
  else{
    $('#open_category').hide(1000);
    $('.first_show_category').show();
  };
});

$(document).ready(function(){
  if ($('#myonoffswitch').is(':checked')){
    $('#open').show(1000);
    $('.first_show').hide();
  }

  if ($('#myonoffswitch_branch').is(':checked')){
    $('#open_branch').show(1000);
    $('.first_show_branches').hide();
  }

  if ($('#myonoffswitch_category').is(':checked')){
    $('#open_category').show(1000);
    $('.first_show_category').hide();
  }
});
