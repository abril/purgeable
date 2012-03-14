# encoding: UTF-8
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

begin
  require 'rspec/core/rake_task'

  desc "Run specs"
  RSpec::Core::RakeTask.new do |t|
    t.rspec_opts = %w(--color) + %w[-fs]
    # t.ruby_opts  = %w(-w)
  end
  namespace :spec do
    desc "Run specs with rcov"
    RSpec::Core::RakeTask.new :rcov do |t|
      t.rspec_opts = %w(--color)# + %w[-fs]
      t.rcov = true
      t.rcov_opts = %w[--exclude /gems/,/Library/,/usr/,lib/tasks,.bundle,config,/lib/rspec/,/lib/rspec-,spec]
      # t.ruby_opts  = %w(-w)
    end
  end
rescue LoadError
  task :spec do
    abort "Run `rake spec:deps` to be able to run the specs"
  end

  namespace :spec do
    desc "Ensure spec dependencies are installed"
    task :deps do
      puts "run `bundle install` into project folder"
    end
  end
end

task :default => :spec
