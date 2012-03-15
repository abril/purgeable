# encoding: UTF-8
config_file = ::Rails.root.join("config/purgeable.yml")
Purgeable.load_settings config_file, ::Rails.env if File.exists? config_file

