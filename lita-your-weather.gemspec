# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'lita-your-weather'
  spec.version       = '0.0.5'
  spec.authors       = ['Zoie Carnegie']
  spec.email         = ['zoie.carnegie@gmail.com']
  spec.description   = 'lita-your-weather provides the ability to ask for the current weather conditions or for a 7 day forecast.'
  spec.summary       = 'lita-your-weather provides the ability to ask for the current weather conditions or for a 7 day forecast.'
  spec.homepage      = 'http://zoiecarnegie.com'
  spec.license       = 'MIT'
  spec.metadata      = { 'lita_plugin_type' => 'handler' }

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'lita', '>= 4.7'

  spec.add_development_dependency 'bundler', '~> 1'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '>= 3.0.0'
end
