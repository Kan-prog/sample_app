if Rails.env.production?
  Recaptcha.configure do |config|
    config.site_key  = ENV['CAPTCHAV3_SITE_KEY']
    config.secret_key = ENV['CAPTCHAV3_SECRET_KEY']
    config.skip_verify_env += %w[development]
  end
end  