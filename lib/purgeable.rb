# encoding: UTF-8
module Purgeable
  autoload :HttpResource, "purgeable/http_resource"
  autoload :Client, "purgeable/client"
  autoload :VERSION, "purgeable/version"
end

require "purgeable/http/purge"
require "purgeable/settings"
require "purgeable/railtie" if defined?(::Rails) && defined?(::Rails::Railtie)
