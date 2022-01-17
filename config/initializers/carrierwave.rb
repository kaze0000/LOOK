require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'

CarrierWave.configure do |config|
    config.storage = :file
end 
