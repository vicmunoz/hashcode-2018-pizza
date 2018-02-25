# encoding: utf-8
$:.push(File.expand_path('../lib',__FILE__))

require 'hashcode-pizza/version'

Gem::Specification.new do |s|
  s.name        = 'hashcode-pizza'
  s.version     = HashCodePizza::VERSION
  s.licenses    = ['MIT']
  s.summary     = 'Ruby exercise for Google Hash Code'
  s.description = 'Ruby exercise for Google Hash Code'
  s.authors     = ['Victor Muñoz']
  s.email       = ['vmunoz@gmail.com']
  s.files       = Dir['lib/**/*.rb']
  s.files       += Dir['spec/**/*']
  s.files       -= Dir['spec/reports/**/*']
  s.files       += Dir['features/**/*']
  s.files       -= Dir['features/reports/**/*']

  # Testing
  s.add_development_dependency 'rspec','~>2.14'
end
