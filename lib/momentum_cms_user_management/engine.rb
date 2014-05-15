require 'sorcery'
require 'haml-rails'
require 'sass-rails'
require 'simple_form'

module MomentumCmsUserManagement
  class Engine < ::Rails::Engine
    config.action_mailer.default_url_options = { :host => 'localhost' }
  end
end
