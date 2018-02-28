$(document).ready(function(){
  $('#send-email-apply').validate({
    errorPlacement: function (error, element) {
      error.insertAfter(element.closest('.input-group'));
    },

    rules: {
      'title':{
        required: true,
        maxlength: 20,
        minlength: 6
      },

      'template_content':{
        required: true,
      },

      'template_user' :{
        required: true,
      }
    },

    messages: {
      title:{
        required: I18n.t('jquery_validates.send_email_apply.required', {name: I18n.t('jquery_validates.send_email_apply.title')}),
      },

      template_content:{
        required: I18n.t('jquery_validates.send_email_apply.required', {name: I18n.t('jquery_validates.send_email_apply.content')}),
      },

      template_user:{
        required: I18n.t('jquery_validates.send_email_apply.required', {name: I18n.t('jquery_validates.send_email_apply.interviewer')}),
      }
    }
  });
});
