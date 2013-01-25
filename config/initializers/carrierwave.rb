CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: 'AKIAJXI3Y2RMZJL3WOLA',
    aws_secret_access_key: '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',
    endpoint: 'https://s3.amazonaws.com'
  }
  config.fog_directory = 'raceweb.photo'
end