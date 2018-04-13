$(document).ready(function() {
  (function() {
    App.notify_send_mail = App.cable.subscriptions.create({
      channel: 'NotifySendMailChannel'
    },
    {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        current_user = parseInt($('#current-user-id').val());
        if (data.user === current_user)
        {
          if ($('#status-email-' + data.id).length === 0) {
            $counter = $('.counter-notify-mail').text();
            val = parseInt($counter);
            val++;
            $('.counter-notify-mail').text(val);
            $('.notify-mail-list').prepend(data.notify_mail);
          } else {
            $('#status-email-' + data.id).attr('class', 'time pull-right color-success');
            $('#status-email-' + data.id).attr('id', 'status-email-' + data.id);
            $('#status-email-' + data.id).text(I18n.t('employers.email_sents.success'));
          }
          if (data.status === 'success') {
            $('.send_email').attr('class', 'send_email btn btn-xs btn-primary pull-right l-5');
            alertify.success(data.message);
          } else {
            alertify.error(data.message);
          }
        }
      },
    });
  }).call(this);
});
