# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :twitter, ENV['TWITTER_ID'], ENV['TWITTER_SECRET']
#   provider :facebook, ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET']
#   provider :google_oauth2, ENV['GOOGLE_ID'], ENV['GOOGLEK_SECRET']
# end

Rails.application.config.middleware.use OmniAuth::Builder do
provider :twitter, Rails.application.secrets[:twitter][:key], Rails.application.secrets[:twitter][:secret]
provider :facebook, Rails.application.secrets[:facebook][:key], Rails.application.secrets[:facebook][:secret]
provider :google_oauth2, Rails.application.secrets[:google_oauth2][:key], Rails.application.secrets[:google_oauth2][:secret]
end