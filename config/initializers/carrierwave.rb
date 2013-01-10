CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: 'AKIAJXI3Y2RMZJL3WOLA',
    aws_secret_access_key: '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'
  }
  config.fog_directory = 'raceweb.photo.development'
end