$(document).ready(function(){
  $('#new_apply').validate({
    errorClass: 'help-block animation-slideDown',
    errorElement: 'div',
    errorPlacement: function(error, e) {
      e.parents('.form-group > div').append(error);
    },
    highlight: function(e) {
      $(e).closest('.form-group').removeClass('has-success has-error').addClass('has-error');
      $(e).closest('.help-block').remove();
    },
    success: function(e) {
      e.closest('.form-group').removeClass('has-success has-error');
      e.closest('.help-block').remove();
    },
    rules: {
      'apply[information][name]': {
        required: true,
        minlength: 6
      },
      'apply[information][email]': {
        required: true,
        email: true
      },
      'apply[information][phone]': {
        required: true,
        number: true,
        minlength: 10,
        maxlength: 13
      },
      'apply[cv]': {
        required: true
      }
    }
  });
});
