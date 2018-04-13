class NotifySendMailChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notify_send_mail_channel"
  end
end
