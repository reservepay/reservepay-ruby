# frozen_string_literal: true

require_relative "lib/reservepay/version"

Gem::Specification.new do |spec|
  spec.name = "reservepay"
  spec.version = Reservepay::VERSION
  spec.authors = ["Reservepay"]

  spec.summary = "Typed Ruby clients for the Reservepay APIs"
  spec.description = "Typed Ruby clients for the Reservepay Merchant, SDK and Terminal APIs, with RBS type signatures. Generated with the WebFunction CLI tool and built on the web_function gem."
  spec.homepage = "https://github.com/reservepay/reservepay-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.files = Dir["lib/**/*.rb", "sig/**/*.rbs", "LICENSE.txt", "README.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency "web_function", "~> 0.8"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"
end
