require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'
if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage :fog
    # config.fog_provider = 'fog/aws'
    config.fog_directory  = 'unitra'
    config.asset_host = 'https://unitra.s3.amazonaws.com'
    config.fog_credentials = {
      # Amazon S3用の設定
      :provider              => 'AWS',
      :region                => ENV['S3_REGION'], # 例: 'ap-northeast-1'
      :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY'],
      path_style: true
    }
    config.fog_directory     =  ENV['S3_BUCKET']
    config.fog_directory  = 'rails-photo-123'
    config.cache_storage = :fog
  end
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/