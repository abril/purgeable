# encoding: UTF-8
module Purgeable
  class Railtie < ::Rails::Railtie
    initializer "setup http cache" do
      config_file = ::Rails.root.join("config/purgeable.yml")
      if File.exists? config_file
        Purgeable.load_settings config_file, ::Rails.env
      else
        puts "Purgeable config not found. Create a config file at: config/purgeable.yml"
        puts "to generate one run: rails generate purgeable:install"
      end
    end
  end
end
