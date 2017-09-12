source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'
gem 'rails', '5.1.4'

gem 'pg'                        # postgres as the database for Active Record
gem 'sass-rails'                # scss stylesheets
gem 'bootstrap-sass'
gem 'uglifier'                  # javascript compressor
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'                # https://github.com/rails/turbolinks
gem 'jbuilder'                  # https://github.com/rails/jbuilder
gem 'bcrypt-ruby'               # needed for has_secure_password
gem 'pundit'                    # authorization
gem 'simple_form'               # form builder
gem 'kaminari'                  # pagination
gem 'factory_girl_rails'        # test data generation

gem 'jquery-fileupload-rails'
gem 'json'                    # json api
gem 'carrierwave'             # file uploads to s3
gem 'rmagick'                 # imagemagick
gem 'fog'

gem 'byebug',      group: [:development, :test]
gem 'rspec-rails', group: [:development, :test]
