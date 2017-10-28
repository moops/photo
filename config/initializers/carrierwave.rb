CarrierWave.configure do |config|
  if Rails.env.production?
    Rails.logger.info('production: using fog for carrierwave storage')
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_KEY'],
      aws_secret_access_key: ENV['S3_SECRET'],
      region: 'us-west-2'
    }
    config.fog_attributes = {
      'x-amz-storage-class' => 'REDUCED_REDUNDANCY'
    }
    config.fog_directory = 'raceweb-photo'
    config.storage = :fog
  end
  if Rails.env.development?
    Rails.logger.info('development: using file for carrierwave storage')
    config.storage = :file
  end
end
