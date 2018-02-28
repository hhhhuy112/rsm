$(document).ready(function() {
  var formLogin = $('#form-login').parent();
  var formRegister = $('#form-register').parent();
  var formForgotPassword = $('#form-forgot-password').parent();

  function switchView(viewHide, viewShow){
    viewHide.slideUp(250);
    viewShow.slideDown(250);
    removeError();
  };

  function removeError(){
    $('#login-ajax .help-block').remove();
    $('#login-ajax .form-group').removeClass('has-success has-error');
    $('#login-ajax input:not([type="hidden"]):not([type="submit"])').val('');
    $('span.close-error').closest('.form-group').hide();
  };

  $.validator.addMethod('regex', function(value, element, regexp){
    if (regexp.constructor != RegExp)
      regexp = new RegExp(regexp);
    else if (regexp.global)
      regexp.lastIndex = 0;
    return this.optional(element) || regexp.test(value);
  });

  $(document).on('click', '.btn-login', function(){
    $('.opacity').animate({'width': 'show'}, 300);
    $('#login-ajax').animate({'height': 'show'}, 300);
    $('html, body').css({overflow: 'hidden'});
    $('#login-email').focus();
  });

  $(document).on('click', '.close-form-login', function(){
    $('.opacity').animate({'width': 'hide'}, 300);
    $('#login-ajax').animate({'height': 'hide'}, 300);
    $('html, body').css({overflow: 'auto'});
    $('#login-ajax').animate({top: '20%', width: '500px'}, 400);
    formLogin.fadeIn();
    formRegister.fadeOut();
    formForgotPassword.fadeOut();
    removeError();
  });

  $(document).on('click', 'span.close-error', function(){
    $(this).closest('.form-group').slideUp();
  });

  $(document).on('click', '.link-register', function(){
    $('#login-ajax').animate({top: '10%', width: '800px'}, 400);
    switchView(formLogin, formRegister);
  });

  $(document).on('click', '.link-login', function(){
    $('#login-ajax').animate({top: '20%', width: '500px'}, 400);
    switchView(formRegister, formLogin);
  });

  $(document).on('click', '.link-forgot-login', function(){
    switchView(formForgotPassword, formLogin);
  });

  $(document).on('click', '.link-forgot-password', function(){
    switchView(formLogin, formForgotPassword);
  });

  $(document).on('click', '#resend-confirmation', function(){
    var email = $(this).data('user-email');
    $('.loading-ajax').fadeIn();
    $('.login-error').slideUp();
    $.ajax({
      type: 'POST',
      url: '/devises/confirmation',
      data: {email: email},
      dataType: 'json',
      success: function(response){
        $('.loading-ajax').hide();
        $('.login-error p').html(response.message);
        $('.login-error').slideDown();
      }
    });
  });

  $(document).on('submit', '#form-login', function(e){
    e.preventDefault();
    $('.loading-ajax').fadeIn();
    $('.login-error').slideUp();
    var url = $(this).attr('action');
    $.ajax({
      type: 'POST',
      url: url,
      data: $(this).serialize(),
      dataType: 'json',
      success: function(response){
        if (response.success){
          window.location.href = response.link_redirect;
        } else {
          $('.loading-ajax').hide();
          $('.login-error p').html(response.message);
          $('.login-error').slideDown();
        }
      }
    });
  });

  $(document).on('submit', '#form-forgot-password', function(e){
    e.preventDefault();
    $('.loading-ajax').fadeIn();
    var url = $(this).attr('action');
    $.ajax({
      type: 'POST',
      url: url,
      data: $(this).serialize(),
      dataType: 'json',
      success: function(response){
        $('.loading-ajax').hide();
        $('.forgot-error p').html(response.message);
        $('.forgot-error').slideDown();
      }
    });
  });

  $('#form-register').bind('submit', function(){
    if ($(this).valid()) $('.loading-ajax').fadeIn();
  });

  $('#form-login').validate({
    errorClass: 'help-block animation-slideDown',
    errorElement: 'div',
    errorPlacement: function(error, e){
      e.parents('.form-group > div').append(error);
    },
    highlight: function(e){
      $(e).closest('.form-group').removeClass('has-success has-error').addClass('has-error');
      $(e).closest('.help-block').remove();
    },
    success: function(e){
      e.closest('.form-group').removeClass('has-success has-error');
      e.closest('.help-block').remove();
    },
    rules: {
      'user[email]': {
        required: true,
        email: true,
        regex: /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{1,})$/
      },
      'user[password]': {
        required: true,
        minlength: 6,
        maxlength: 128
      }
    },
    messages: {
      'user[email]': {
        required: 'Please enter your account\'s email',
        email: 'Please enter the correct email format',
        regex: 'Please enter the correct email format'
      },
      'user[password]': {
        required: 'Please provide your password',
        minlength: 'Your password must be at least 6 characters long',
        maxlength: 'Maximum password is 128 characters'
      }
    }
  });

  $('#form-forgot-password').validate({
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
        email: true,
        regex: /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{1,})$/
      }
    },
    messages: {
      'user[email]': {
        required: 'Please enter your account\'s email',
        email: 'Please enter the correct email format',
        regex: 'Please enter the correct email format'
      }
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
      'user[name]': {
        required: true,
        minlength: 5
      },
      'user[email]': {
        required: true,
        email: true,
        regex: /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{1,})$/
      },
      'user[password]': {
        required: true,
        minlength: 6,
        maxlength: 128
      },
      'user[password_confirmation]': {
        required: true,
        equalTo: '#user_password'
      },
      'user[phone]': {
        regex: /^(\+\d{2,4})?\s?(\d{10,15})$/
      }
    },
    messages: {
      'user[name]': {
        required: 'Please enter your name',
        minlength: 'Your name at least 5 characters'
      },
      'user[email]': {
        required: 'Please enter your account\'s email',
        email: 'Please enter the correct email format',
        regex: 'Please enter the correct email format'
      },
      'user[password]': {
        required: 'Please provide your password',
        minlength: 'Your password must be at least 6 characters long',
        maxlength: 'Maximum password is 128 characters'
      },
      'user[password_confirmation]': {
        required: 'Please enter password confirmation',
        equalTo: "Password confirmation does not match password"
      },
      'user[phone]': {
        regex: 'Please enter the correct phone format'
      }
    }
  });
})
