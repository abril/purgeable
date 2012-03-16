# encoding: UTF-8
module Purgeable
  version = nil
  version_file = ::File.expand_path('../../../GEM_VERSION', __FILE__)
  version = File.read(version_file) if version.nil? && ::File.exists?(version_file)
  version = $1 if version.nil? && ::File.expand_path('../..', __FILE__) =~ /\/purgeable-(\d+(?:\.\d+)+)/
  if version.nil? && ::File.exists?(::File.expand_path('../../../.git', __FILE__))
    begin
      require 'step-up'
      version = ::StepUp::Driver::Git.new.last_version_tag("HEAD", true)
    rescue
      version = "v0.0.0"
    end
    ::File.open(version_file, "w"){ |f| f.write version }
  end
  VERSION = version.gsub(/^v?([^\+]+)\+?\d*$/, '\1')
end
