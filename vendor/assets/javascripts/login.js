var Login = function() {
  var switchView = function(viewHide, viewShow, viewHash){
    viewHide.slideUp(250);
    viewShow.slideDown(250, function(){
      $('input').placeholder();
    });

    if ( viewHash ) {
      window.location = '#' + viewHash;
    } else {
      window.location = '#';
    }
  };
  return {
    init: function() {
      var formLogin = $('#form-login'),
      formReminder = $('#form-reminder'),
      formRegister = $('#form-register');

      $('#link-register-login').click(function(){
        switchView(formLogin, formRegister, 'register');
      });

      $('#link-register').click(function(){
        switchView(formRegister, formLogin, '');
      });

      $('#link-reminder-login').click(function(){
        switchView(formLogin, formReminder, 'reminder');
      });

      $('#link-reminder').click(function(){
        switchView(formReminder, formLogin, '');
      });
      if (window.location.hash === '#register') {
        formLogin.hide();
        formRegister.show();
      }
      if (window.location.hash === '#reminder') {
        formLogin.hide();
        formReminder.show();
      }
      $('#form-login').validate({
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
          'user[email]': {
            required: true,
            email: true
          },
          'user[password]': {
            required: true,
            minlength: 6
          }
        },
        messages: {
          'user[email]': {
            required: 'Please enter your account\'s email',
            email: 'Please enter the correct email format'
          },
          'user[password]': {
            required: 'Please provide your password',
            minlength: 'Your password must be at least 6 characters long'
          }
        }
      });

      $('#form-reminder').validate({
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
          'reminder-email': {
            required: true,
            email: true
          }
        },
        messages: {
          'reminder-email': 'Please enter your account\'s email'
        }
      });

      $('#form-register').validate({
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
          if (e.closest('.form-group').find('.help-block').length === 2) {
            e.closest('.help-block').remove();
          } else {
            e.closest('.form-group').removeClass('has-success has-error');
            e.closest('.help-block').remove();
          }
        },
        rules: {
          'register-firstname': {
            required: true,
            minlength: 2
          },
          'register-lastname': {
            required: true,
            minlength: 2
          },
          'register-email': {
            required: true,
            email: true
          },
          'register-password': {
            required: true,
            minlength: 5
          },
          'register-password-verify': {
            required: true,
            equalTo: '#register-password'
          },
          'register-terms': {
            required: true
          }
        },
        messages: {
          'register-firstname': {
            required: 'Please enter your firstname',
            minlength: 'Please enter your firstname'
          },
          'register-lastname': {
            required: 'Please enter your lastname',
            minlength: 'Please enter your lastname'
          },
          'register-email': 'Please enter a valid email address',
          'register-password': {
            required: 'Please provide a password',
            minlength: 'Your password must be at least 5 characters long'
          },
          'register-password-verify': {
            required: 'Please provide a password',
            minlength: 'Your password must be at least 5 characters long',
            equalTo: 'Please enter the same password as above'
          },
          'register-terms': {
            required: 'Please accept the terms!'
          }
        }
      });
    }
  };
}();
$(function(){ Login.init(); });

jQuery(document).ready(function($) {
  $(".scroll").click(function(event){
    event.preventDefault();
    $('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
  });
});
