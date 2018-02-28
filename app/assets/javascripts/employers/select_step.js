$(document).ready(function () {
  $('#select-step').change(function() {
    var dataform = {
      step_id: $('#select-step').val()
    };
    $.ajax('/employers/status_steps', {
      type: 'GET',
      data: dataform,
      success: function(result) {
        if (result.error === undefined) {
          $('.form-search-applies').html(result.content);
          $('#select-step').val(result.step_current);
        } else {
          alertify.error(result.error);
        }
      },
      error: function (result) {
        alertify.error(I18n.t('employers.status_steps.transmission_error'));
      }
    });
  });
});
