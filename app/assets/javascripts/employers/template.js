$(document).ready(function() {
  $('#apply-handling-content').on('change', '.template_member', function(){
    var template = $(this).val();
    $.get('/employers/templates/' + template);
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

$(document).on('click', '.show-inter', function(){
  var id = $(this).val();
  $('#body_template_'+id).modal('show');
});

$(document).on('change', '.template-user', function(){
  var template = $(this).val();
  var status_apply = document.getElementById('new_apply');
  var data_apply = new FormData(status_apply);
  var data = {
    step_id: data_apply.get('step_id'),
    address: data_apply.get('apply_status[appointment_attributes][address]'),
    start_time: data_apply.get('apply_status[appointment_attributes][start_time]'),
    end_time: data_apply.get('apply_status[appointment_attributes][end_time]'),
    name: data_apply.get('user_name'),
    salary: data_apply.get('apply_status[offers_attributes][0][salary]'),
    offer_address: data_apply.get('apply_status[offers_attributes][0][address]'),
    requirement: data_apply.get('apply_status[offers_attributes][0][requirement]'),
    date_offer: data_apply.get('apply_status[offers_attributes][0][start_time]')
  };
  $.ajax('/employers/templates/' + template, {
    type: 'GET',
    data: data
  });

//   for(var pair of data_apply.entries()) {
//    console.log(pair[0]+ ', '+ pair[1]);
// }
});

$(document).on('click', '#check-template', function(){
  if ($('#check-template').is(':checked')){
    $('#content-note').show();
  }else{
    $('#content-note').hide();
  }
});

function htmlDecode(value){
  return $('<div/>').html(value).text();
}
$(document).on('click', '.view_mail', function(){
  var step_id = $(this).val();
  var content_mail = CKEDITOR.instances['content-template-user-'+ step_id ].getData();
  $('#contentmail-'+ step_id).text(htmlDecode(content_mail));
  $('#review_template_'+ step_id).modal('show');
});

$(window).on('load', function () {
  $('.loading').fadeOut('slow');
});

$(document).on('change', '#template_type_of', function(){
  var value = $(this).val();
  if(value == 'template_member'){
    CKEDITOR.instances['template_template_body'].setData(I18n.t('employers.templates.show.offer_content'));
  }else{
    CKEDITOR.instances['template_template_body'].setData(I18n.t('employers.templates.show.content_template'));
  }
});

$(document).on('change', '#expire_on', function(){
  if ($(this).is(':checked')) {
    $('.job-form > form .display-job-end-time').slideDown();
  } else {
    $('.job-form > form .display-job-end-time').slideUp();
  }
});
