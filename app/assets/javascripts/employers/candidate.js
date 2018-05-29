$(document).ready(function(){
  $('#cadidate-form').validate({
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
      'user[name]': {
        required: true,
        minlength: 6
      },
      'user[email]': {
        required: true,
        email: true
      },
      'user[phone]': {
        required: true,
        number: true,
        minlength: 10,
        maxlength: 13
      },
      'user[cv]': {
        extension: "pdf"
      }
    },
    messages: {
      'user[cv]': {
        extension: I18n.t("cv.only_pdf")
      }
    }
  });

  $('#cadidate-form-edit').validate({
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
      'user[name]': {
        required: true,
        minlength: 6
      },
      'user[email]': {
        required: true,
        email: true
      },
      'user[phone]': {
        required: true,
        number: true,
        minlength: 10,
        maxlength: 13
      },
      'user[cv]': {
        extension: "pdf"
      }
    },
    messages: {
      'user[cv]': {
        extension: I18n.t("cv.only_pdf")
      }
    }
  });
});
