require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'
# require self.fog_provider

if Rails.env.production?
  CarrierWave.configure do |config|
    # config.fog_use_ssl_for_aws = true
    config.fog_provider =       'fog-aws'
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.fog_credentials = {
      # Amazon S3用の設定
      :provider              => 'AWS',
      :region                => ENV['S3_REGION'], # 例: 'ap-northeast-1'
      :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY'],
      path_style: true
    }
    # config.fog_provider =       'fog/aws'
    config.fog_directory     =  ENV['S3_BUCKET']
    config.fog_attributes =     { 'Cache-Control' => "max-age=#{365.day.to_i}" }
    # config.asset_host =         "https://s3.us-east-1.amazonaws.com/tradents"
    config.asset_host = 'https://tradents1.s3.amazonaws.com' #このように修正
    config.cache_storage =      :fog
    config.fog_public =         true
  end
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/


module CarrierWave
  module MiniMagick
    def fix_exif_rotation
      manipulate! do |img|
        img.auto_orient
        img = yield(img) if block_given?
        img
      end
    end
  end
end