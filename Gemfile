source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'
gem 'rails', '5.1.4'

gem 'pg'                        # postgres as the database for Active Record
gem 'bootstrap'
gem 'uglifier'                  # javascript compressor
gem 'jquery-rails'
gem 'jbuilder'                  # https://github.com/rails/jbuilder
gem 'bcrypt-ruby'               # needed for has_secure_password
gem 'pundit'                    # authorization
gem 'kaminari'                  # pagination
gem 'factory_girl_rails'        # test data generation

gem 'json'                    # json api
gem 'carrierwave'             # file uploads to s3
gem 'mini_magick'
gem 'fog'

gem 'byebug',      group: [:development, :test]
gem 'rspec-rails', group: [:development, :test]

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry'
  gem 'pry-byebug'
  gem 'rubocop', require: false
end
