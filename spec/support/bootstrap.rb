# encoding: UTF-8
RSpec.configure do |config|
  config.before :suite do
    FakeWeb.register_uri(:purge, /http:\/\/localhost/, :body => "")
  end
end
