Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "1061679306247-oih0cv0hr1nt1ckrm69cha5opk6m2m7c.apps.googleusercontent.com", "OulcCKGUYefc3mO5j9AfkTZV", {
  scope: ['email',
    'https://mail.google.com/'],
    access_type: 'offline'}
end

