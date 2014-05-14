# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require 'codeclimate-test-reporter'
require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter,
]
CodeClimate::TestReporter.start

SimpleCov.start 'rails' do
  add_group 'Tags', 'lib/momentum_cms/tags'
end

require File.expand_path('../dummy/config/environment.rb', __FILE__)
require 'rails/test_help'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir['#{File.dirname(__FILE__)}/support/**/*.rb'].each { |f| require f }

# Load fixtures from the engine
ActiveSupport::TestCase.fixture_path = File.expand_path('../fixtures', __FILE__)


class ActiveSupport::TestCase
  fixtures :all
  include ActionDispatch::TestProcess
end