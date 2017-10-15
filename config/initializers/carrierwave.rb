CarrierWave.configure do |config|
  puts 'carrierwave config...'
  if Rails.env.production?
    Rails.logger.info('production: using fog for carrierwave storage')
    config.storage = :fog
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_KEY'],
      aws_secret_access_key: ENV['S3_SECRET'],
      endpoint: 'https://s3.amazonaws.com'
    }
    config.fog_directory = 'raceweb.photo'
  end
  if Rails.env.development?
    Rails.logger.info('development: using file for carrierwave storage')
    puts 'development: using file for carrierwave storage'
    config.storage = :file
  end
end
