require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'look-backet'
    config.asset_host = 'https://s3.amazonaws.com/look-backet'
    config.fog_public = true
    config.cache_storage = :fog 
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_DEFAULT_REGION'],
      path_style: true
    }
  else
    config.storage = :file
  end
end 
