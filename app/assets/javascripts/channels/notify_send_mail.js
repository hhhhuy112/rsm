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
            $counter = $('.counter-notify-mail').text();
            val = parseInt($counter);
          if ($('#status-email-' + data.id).length === 0) {
            val++;
            $('.counter-notify-mail').text(val);
            $('.notify-mail-list').prepend(data.notify_mail);
          } else {
            val--;
            if(val < 0){
              val = 0;
            }
            $('.counter-notify-mail').text(val);
            $('#status-email-' + data.id).attr('class', 'time pull-right color-success');
            $('#status-email-' + data.id).attr('id', 'status-email-' + data.id);
            $('#status-email-' + data.id).text(I18n.t('employers.email_sents.success'));
          }
          if (data.status === 'success') {
            $('#status-sent-inbox' + data.id).attr('class', 'text-success msg-read-btn');
            $('#cell-button-resend' + data.id).html('');
            alertify.success(data.message);
          } else {
            alertify.error(data.message);
          }
        }
      },
    });
  }).call(this);
});
