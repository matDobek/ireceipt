$:.push File.expand_path('../lib', __FILE__)
require 'ireceipt/version'

Gem::Specification.new do |s|
  s.name        = 'ireceipt'
  s.authors     = ['Mateusz Dobek']
  s.email       = 'mat.dobek@gmail.com'
  s.summary     = 'TODO: add summary'
  s.description = 'TODO: add description'
  s.homepage    = 'TODO: add rubygems address'
  s.license     = 'The Beer-ware lincense'
  s.version     = Ireceipt::VERSION
  s.platform    = Gem::Platform::RUBY

  s.add_dependency 'json'

  s.add_development_dependency 'rspec', '~> 3.3.0'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake'

  s.files         = Dir['./**/*'].reject { |file| file =~ /\.\/(bin|log|pkg|script|spec|test|vendor)/ }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split('\n')
  s.require_paths = ['lib']
end
