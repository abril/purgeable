require 'rbconfig'

module Purgeable
  class InstallGenerator < ::Rails::Generators::Base

    def generate
      copy_file "purgeable.yml", "config/purgeable.yml"
    end

    def self.gem_root
      File.expand_path("../../../../", __FILE__)
    end

    def self.source_root
      File.join(gem_root, 'templates/install')
    end

  end
end
