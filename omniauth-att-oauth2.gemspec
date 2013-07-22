# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-att-oauth2/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'oauth2', '~> 0.8.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.0'

  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'simplecov'

  gem.authors       = ["Chad Metcalf"]
  gem.email         = ["cm0591@gmail.com"]
  gem.description   = %q{AT&T OAuth2 strategy for OmniAuth.}
  gem.summary       = %q{AT&T OAuth2 strategy for OmniAuth.}
  gem.homepage      = "https://github.com/intridea/omniauth-oauth2"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-att-oauth2"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::AttOauth2::VERSION
end
