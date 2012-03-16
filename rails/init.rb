# encoding: UTF-8
config_file = ::Rails.root.join("config/purgeable.yml")
if File.exists? config_file
  Purgeable.load_settings config_file, ::Rails.env
else
  puts "Purgeable config not found. Create a config file at: config/purgeable.yml"
  puts "to generate one run: script/generate purgeable_install"
end

