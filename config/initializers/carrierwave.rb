CarrierWave.configure do |config|
  region = Rails.env.production? ? 'us-west-2' : 'us-east-1'
  bucket = Rails.env.production? ? 'raceweb.photo' : 'raceweb.photo.dev'
  config.storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['S3_KEY'],
    aws_secret_access_key: ENV['S3_SECRET'],
    region: region,
    endpoint: 'https://s3.amazonaws.com'
  }
  config.fog_directory = bucket
end
