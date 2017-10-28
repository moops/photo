source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'
gem 'rails', '5.1.4'

gem 'bootstrap'
gem 'pg'                        # postgres as the database for Active Record

gem 'carrierwave'               # file uploads to s3
gem 'fog-aws'
gem 'mini_magick'

gem 'jbuilder'                  # https://github.com/rails/jbuilder
gem 'jquery-rails'
gem 'json'                      # json api
gem 'kaminari'                  # pagination
gem 'uglifier'                  # javascript compressor

gem 'bcrypt-ruby'               # needed for has_secure_password
gem 'pundit'                    # authorization

gem 'byebug',             group: %i[development test]
gem 'factory_girl_rails', group: %i[development test]
gem 'rspec-rails',        group: %i[development test]

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry'
  gem 'pry-byebug'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
