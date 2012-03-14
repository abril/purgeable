# encoding: UTF-8
require "erb"
require "yaml"
require "methodize"

module Purgeable
  SETTINGS = {}.extend ::Methodize

  def self.load_settings file_path, env
    raise "Invalid config location: #{file_path.inspect}" unless File.exists? file_path
    config = YAML.load(ERB.new(File.read(file_path)).result)[env]
    SETTINGS.merge! config if config.is_a?(Hash)
    if defined? ::MethodizedHash
      SETTINGS.http_cache.each do |cfg|
        cfg.extend ::Methodize unless cfg.kind_of?(MethodizedHash)
      end
    end
  end

  if defined? ::Rails
    config_file = ::Rails.root.join("config/purgeable.yml")
    load_settings config_file, ::Rails.env if File.exists? config_file
  end
end
