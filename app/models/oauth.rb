class Oauth < ApplicationRecord
  belongs_to :user

  def self.from_omniauth omniauth_auth
   omniauth_credentials = omniauth_auth[:credentials]
   access_token = omniauth_credentials[:token]
   {
    access_token: omniauth_credentials[:token],
    expires_at: omniauth_credentials[:expires_at]
   }
  end

  def to_params
    { refresh_token: self.access_token,
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET'],
      grant_type: 'refresh_token'}
  end

  def request_token_from_google
    url = URI("https://accounts.google.com/o/oauth2/token")
    Net::HTTP.post_form(url, self.to_params)
  end

  def refresh!
    data = JSON.parse(request_token_from_google.body)
    update_attributes(
      access_token: data[:access_token],
      expires_at: Time.now + data[:expires_in].to_i.seconds
    )
  end

  def check_access_token
    binding.pry
    self.refresh! if self.expires_at < Time.now
  end
end
