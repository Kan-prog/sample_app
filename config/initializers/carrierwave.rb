# require 'carrierwave/storage/abstract'
# require 'carrierwave/storage/file'
# require 'carrierwave/storage/fog'
if Rails.env.production?
  CarrierWave.configure do |config|
    # config.fog_provider = 'fog/aws'
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.fog_credentials = {
      # Amazon S3用の設定
      :provider              => 'AWS',
      :region                => ENV['S3_REGION'], # 例: 'ap-northeast-1'
      :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY'],
      path_style: true
    }
    config.fog_directory     =  ENV['S3_BUCKET']
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
    config.asset_host = "https://s3.us-east-1.amazonaws.com/tradents"
    # config.cache_storage = :fog
  end
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

# 下記の三行は入れていた方がいいらしい
# require 'carrierwave/storage/abstract'
# require 'carrierwave/storage/file'
# require 'carrierwave/storage/fog'

# if Rails.env.production?
#   CarrierWave.configure do |config|
#     config.fog_provider = 'fog/aws'
#     config.fog_credentials = {
#       # Amazon S3用の設定
#       provider: 'AWS',
#       region: ENV['AWS_S3_REGION'],
#       aws_access_key_id: ENV['AWS_IAM_ACCESS_KEY_ID'],
#       aws_secret_access_key: ENV['AWS_IAM_ACCESS_KEY'],
#     }
#     config.fog_directory     =  ENV['AWS_S3_BUCKET']
#     config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
#   end

#   # 日本語ファイル名の設定
#   CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
# end