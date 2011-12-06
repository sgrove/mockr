source "http://rubygems.org"

# Core framework
gem "rake", "0.9.2"
gem "rdoc", "2.4.3"
gem "rails", "~> 2.3.14"
gem 'pg'

# User auth
gem "devise", "1.0.9"
gem 'devise_bushido_authenticatable', :git=>"git://github.com/Bushido/devise_cas_authenticatable.git"

# Image processing and storage
gem 'rmagick', :require => "RMagick"
gem 'paperclip'
gem 'aws-s3'

# Misc.
gem 'bushido', :git => "git://github.com/Bushido/bushidogem.git"
gem 'hoe', '~> 1.5.1' # Heroku's rubygems is too old for hoe 2.9.1 as of 28 Mar 2011
gem 'json'
gem 'action_mailer_tls'

# In 'all group' because rake tasks rely on this for now
gem 'test-unit', '1.2.3'

group :development do
  gem 'factory_girl', '1.2.4'
  gem 'rspec-rails', "1.3.4"
  gem 'remarkable_activerecord'
  gem 'remarkable_rails'
  gem 'tane', :git => "git://github.com/Bushido/tane.git"
  gem 'awesome_print'
end



gem 'thin', '>=1.2.7'
