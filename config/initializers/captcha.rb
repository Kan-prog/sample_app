Recaptcha.configure do |config|
  config.site_key  = ENV['CAPTCHA_SITE_KEY']
  config.secret_key = ENV['CAPTCHA_SECRET_KEY']
  config.skip_verify_env += %w[development]
end