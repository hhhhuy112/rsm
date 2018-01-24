$(document).on('change', '.apply_select', function(event){
  let element = this.nextElementSibling;
  var applyId = $(this).next().val();
  var value = $(this).val();
  var textStatus = $('#apply_status_status_step_id option:selected').text();
  $('#apply-handling-content').html('');
  swal({
    title: I18n.t('jobs.apply.confirm_change_status'),
    text: I18n.t('jobs.apply.text_change_status', {status: textStatus}),
    icon: 'warning',
    buttons: true,
    primaryMode: true,
  })
  .then(function(isConfirm){
    if (isConfirm) {
      value_scheduleds = $('#new_apply_status .scheduled_ids').val().split('');
      if(value_scheduleds.includes(value)){
        event.preventDefault();
        $.get('/employers/apply_statuses/new?status=' + value + '&&apply_id=' + applyId);
      }else{
        element.form.commit.click();
      }
    }else{
      $('#new_apply_status')[0].reset();
    }
  });
});

$(document).on('hidden.bs.modal', '.modal-apply', function () {
  var apply_id = $(this).data("id");
  $.get('/employers/applies/' +  apply_id);
})

$(document).on('click', '.btn-apply-status', function(event){
  let element = this.nextElementSibling;
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
      element.commit.click();
    }
  });
});
