source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby '2.0.0'
gem 'rails', '4.1.5'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
#
# Use postgresql as the database for Active Record
gem 'pg'
#
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
gem 'unicorn'

gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'

# Use Mina for Deployment
gem 'mina'

# Use debugger
# gem 'debugger', group: [:development, :test]


group :development, :test do
  gem 'minitest-reporters'
  gem 'guard-minitest'

  gem 'pry-rails'
  gem 'jazz_hands'
end

group :production do
  gem 'rails_12factor'
end

# SMS 발송하기 ( API Store > 대용량 SMS 발송 )
# POST 방식으로 발송하기 때문에 필요
gem 'rest-client'

# SMS 전송 결과 받아오기 ( API Store > 대용량 SMS 발송 )
# GET 방식으로 받아오기 때문에 필요
gem 'addressable'

# 환경변수를 저장하기 위해서 필요
gem 'figaro'

# HTML 템플릿 라이브러리
gem 'underscore-rails', '~> 1.7.0'

gem 'asset_sync'

# assets:precompile without md5
gem "non-stupid-digest-assets"