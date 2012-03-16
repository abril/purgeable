require 'rbconfig'

class PurgeableInstallGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.file "purgeable.yml", "config/purgeable.yml"
    end
  end

  def self.gem_root
    File.expand_path('../../../', __FILE__)
  end

  def self.source_root
    File.join(gem_root, 'templates', 'install')
  end

  def source_root
    self.class.source_root
  end

  private

  def banner
    "Usage: #{$0} purgeable_install"
  end
end
