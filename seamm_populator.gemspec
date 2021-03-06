# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'seamm_populator/version'

Gem::Specification.new do |spec|
  spec.name          = 'seamm_populator'
  spec.version       = SeammPopulator::VERSION
  spec.authors       = ['Kryptykfysh']
  spec.email         = ['kryptykfysh@kryptykfysh.co.uk']

  spec.summary       = %q{Gem to add test data to SEAMM database.}
  spec.description   = File.read('README.md')
  spec.homepage      = 'https://github.com/kryptykfysh/seamm_populator'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = 'TODO: Set to 'http://mygemserver.com''
  # else
  #   raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'

  spec.add_runtime_dependency 'activerecord', '~> 4.2', '>= 4.2.4'
  spec.add_runtime_dependency 'activerecord-import', '~> 0.10', '>= 0.10.0'
  spec.add_runtime_dependency 'faker', '~> 1.5', '>= 1.5.0'
  spec.add_runtime_dependency 'pg', '~> 0.18', '>= 0.18.3'
end
