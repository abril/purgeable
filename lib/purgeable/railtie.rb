# encoding: UTF-8
module Purgeable
  class Railtie < ::Rails::Railtie
    initializer "setup http cache" do
      config_file = ::Rails.root.join("config/purgeable.yml")
      Purgeable.load_settings config_file, ::Rails.env if File.exists? config_file
    end
  end
end
