$(document).on('change', '#form-apply-status-main input[type=radio]', function(event){
  event.preventDefault();
  var applyId = $('#form-apply-status-main #apply_status_apply_id').val();
  var is_prev_step = $('#area-form-status #is_prev_step').val();
  var current_apply_status_id = $('#area-form-status #current_apply_status_id').val();
  var current_status_step_id = $('#area-form-status #current_status_step_id').val();
  var value = $('#form-apply-status-main input[type=radio]:checked').val();
  var stepId = $('#area-form-status #step_main_id').val();
  if ($(this).is(':checked')) {
    $('.loading').fadeIn('slow');
    if(is_prev_step == 'true'){
      $.get('/employers/steps/' + stepId + '?status_step_id=' + value + '&&apply_id=' + applyId);
    }else{
      if(current_status_step_id === value){
        $.get('/employers/apply_statuses/new?status_step_id=' + value + '&&apply_id=' + applyId + '&&apply_status_id=' + current_apply_status_id);
      }else{
        $.get('/employers/apply_statuses/new?status_step_id=' + value + '&&apply_id=' + applyId);
      }
    }
  }
});

$(document).on('hidden.bs.modal', '.modal-apply', function () {
  var apply_id = $(this).data("id");
  $.get('/employers/applies/' +  apply_id);
})

$(document).on('click', '.btn-apply-status', function(event){
  var element = this.nextElementSibling;
  var textStep = $(this).next().children('.step-value').val();
  swal({
    title: I18n.t('jobs.apply.confirm_change_status'),
    text: I18n.t('jobs.apply.text_change_status_button', {step: textStep}),
    icon: 'warning',
    buttons: true,
    primaryMode: true,
  })
  .then(function(isConfirm){
    if (isConfirm) {
      $('.loading').fadeIn('slow');
      element.commit.click();
    }
  });
});

$(document).on('click', '.btn-submit-apply-status-form', function(event){
  var apply_status_form = document.getElementById('new_apply');
  var textStatus = $('#form-apply-status-main input[type=radio]:checked').next().text();
  swal({
    title: I18n.t('jobs.apply.confirm_change_status'),
    text: I18n.t('jobs.apply.text_change_status', {status: textStatus}),
    icon: 'warning',
    buttons: true,
    primaryMode: true,
  })
  .then(function(isConfirm){
    if (isConfirm) {
      $('.loading').fadeIn('slow');
      apply_status_form.commit.click();
    }
  });
});

$(document).on('click', '#pagination-history-apply .pagination a', function (event) {
  event.preventDefault();
  var page = $(this).attr('href').split('?').pop();
  var jobID = parseInt($('#job_id').val());
  var applyID = parseInt($('#apply_id').val());
  $.getScript('/employers/jobs/' + jobID + '/applies/' + applyID + '?' + page);
  return false;
});

$(document).on('click', '#cancel-apply-email', function (event) {
  $('#apply-handling-content').html('');
  $('#form-apply-status-main')[0].reset();
});

$(document).on('click', '#btn-block-apply', function(event){
  var is_block = $('.overcast-custom').hasClass('overcast-div');
  var title;
  if (is_block) {
    title = I18n.t('employers.applies.block_apply.title_unblock');
  } else {
    title = I18n.t('employers.applies.block_apply.title_block');
  }
  swal({
    title: title,
    text: '',
    icon: 'warning',
    buttons: true,
    primaryMode: true,
  })
  .then(function(isConfirm){
    if (isConfirm) {
      $('.loading').fadeIn('slow');
      $.ajax({
        type: 'PATCH',
        url: '/employers/applies/' + $('#apply_status_apply_id').val(),
        data: {authenticity_token: $('[name="csrf-token"]')[0].content},
        dataType: 'json',
        success: function(data){
          alertify.success(data.message);
          $('#apply-handling-content').html('');
          $('.btn-handling').html(data.html_data);
          if (is_block) {
            $('.overcast-custom').removeClass('overcast-div');
          } else {
            $('.overcast-custom').addClass('overcast-div');
          }
          $('.loading').fadeOut('slow');
        },
        error: function(data){
          $('.loading').fadeOut('slow');
          alertify.error(data.message);
        }
      });
    }
  });
});

$(document).on('click', '.send_email', function(event){
  event.preventDefault();
  var element = this.nextElementSibling;
  var step = $('#val_step').val();
  swal({
    title: I18n.t('jobs.apply.confirm_change_status'),
    text: I18n.t('jobs.apply.mail_sure', {step: step}),
    icon: 'warning',
    buttons: true,
    primaryMode: true,
  })
  .then(function(isConfirm){
    if (isConfirm) {
      $('.loading').fadeIn('slow');
      element.click();
    }
  });
});
