# encoding: UTF-8
require "erb"
require "yaml"
require "methodize"

module Purgeable
  SETTINGS = {}.extend ::Methodize

  def self.load_settings(file_path, env)
    raise "Invalid config location: #{file_path.inspect}" unless File.exists? file_path
    config = YAML.load(ERB.new(File.read(file_path)).result)[env]
    SETTINGS.merge! config if config.is_a?(Hash)
    normalize_settings
  end

  private

  def self.normalize_settings
    SETTINGS["http_cache"] = [] unless SETTINGS.http_cache.is_a?(Array)
    SETTINGS.http_cache.each do |cfg|
      next unless cfg.is_a?(Hash)
      cfg.extend ::Methodize if defined?(::MethodizedHash) && !cfg.kind_of?(MethodizedHash)
      cfg["cache_locations"] =
        case cfg["cache_locations"]
        when String then [cfg["cache_locations"]]
        when Array then cfg["cache_locations"]
        else []
        end
      cfg["resource_hosts"] =
        case cfg["resource_hosts"]
        when String then [cfg["resource_hosts"]]
        when Array then cfg["resource_hosts"]
        else []
        end
    end
  end
end
