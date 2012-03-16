# encoding: UTF-8
lib = File.expand_path('../lib', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "purgeable"

Gem::Specification.new do |s|
  s.name        = "purgeable"
  s.version     = Purgeable::VERSION
  s.authors     = ["Marcelo Manzan"]
  s.email       = ["manzan@gmail.com"]
  s.homepage    = "http://github.com/abril/"
  s.summary     = %q{HTTP Purge utility}
  s.description = %q{Purge contents from shared caches easily by sending a HTTP method "PURGE".}

  s.required_rubygems_version = ">= 1.3.6"

  s.add_runtime_dependency "methodize", ">= 0.2.0"

  s.add_development_dependency "rspec", "~> 2.6.0"
  s.add_development_dependency "mocha", "~> 0.10"
  s.add_development_dependency "fakeweb", "~> 1.3.0"

  excepts = %w[
    .gitignore
    purgeable.gemspec
    Gemfile
    Rakefile
  ]
  tests = `git ls-files -- {script,spec}/*`.split("\n")
  s.files              = `git ls-files`.split("\n") - excepts - tests + %w[GEM_VERSION]
  # s.test_files         = tests
end
