$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "momentum_cms_user_management/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "momentum_cms_user_management"
  s.version     = MomentumCmsUserManagement::VERSION
  s.authors     = ['Emerson', 'Bill']
  s.email       = ['emerson@twg.ca', 'bill@twg.ca']
  s.homepage    = 'https://github.com/MomentumCMS/momentum_cms'
  s.summary     = 'MomentumCms is a Content Management System'
  s.description = 'MomentumCms is a Content Management System.'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'pg'

  s.add_dependency 'rails',                    '~> 4.0.0'
  s.add_dependency 'sorcery',                  '~> 0.8.5'
end
