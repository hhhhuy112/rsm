$(document).ready(function() {
  (function() {
    App.notifications = App.cable.subscriptions.create({
      channel: 'NotificationChannel'
    },
    {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        current_user = parseInt($('#current-user-id').val());
        if (data.list_received != null && data.list_received.includes(current_user))
        {
          $('.notificationList').prepend('' + data.notification);
          $counter = $('.counter-notification').text();
          val = parseInt($counter);
          val++;
          $('.counter-notification').text(val);
        }
      },
    });
  }).call(this);
});
