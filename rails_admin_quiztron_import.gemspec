$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'rails_admin_quiztron_import/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'rails_admin_quiztron_import'
  s.version     = RailsAdminQuiztronImport::VERSION
  s.authors     = ['Andy Chase']
  s.email       = ['theandychase@gmail.com']
  s.summary     = 'Adds a quiztron import action to gojimo admin server'
  s.description = 'Adds a quiztron import action to gojimo admin server'

  s.files = Dir['{app,config,db,lib}/**/*', 'README.rdoc']
  s.add_dependency "rails", "~> 4.2.6"

end
