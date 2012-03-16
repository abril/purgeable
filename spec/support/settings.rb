# encoding: UTF-8
RSpec.configure do |config|
  config.before :suite do
    config = File.expand_path("../purgeable_test.yml", __FILE__)
    Purgeable.load_settings(config, "empty")
    Purgeable.load_settings(config, "empty_http_cache")
    Purgeable.load_settings(config, "test")
  end
end
