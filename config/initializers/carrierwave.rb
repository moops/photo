CarrierWave.configure do |config|
  if Rails.env.production?
    Rails.logger.info('production: using fog for carrierwave storage')
    config.storage = :fog
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: 'AKIAJXI3Y2RMZJL3WOLA',
      aws_secret_access_key: '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',
      endpoint: 'https://s3.amazonaws.com'
    }
    config.fog_directory = 'raceweb.photo'
  end
  if Rails.env.development?
    Rails.logger.info('development: using file for carrierwave storage')
    config.storage = :file
  end
end