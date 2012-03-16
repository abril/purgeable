# encoding: UTF-8
require "spec_helper"

describe "The purgeable client" do

  before { @client = ::Purgeable::Client.new }

  {
    "http://www.example.com/test/index.html" => ["http:", "www.example.com", "/test/index.html"],
    "http://www2.example.com .*" => ["http:", "www2.example.com", ".*"],
    "http://www3.example.com ^others" => ["http:", "www3.example.com", "^others"]
  }.each_pair do |url, matches|
    it "should split url: #{url.inspect}" do
      @client.send(:split_url, url).should == matches
    end
  end

  {
    "http://www.example.com/test/index.html" => ["localhost:80", "localhost2:80"],
    "http://www2.example.com .*" => ["localhost:80", "localhost2:80"],
    "http://www3.example.com ^others" => []
  }.each_pair do |url, locations|
    it "should find cache locations for url: #{url.inspect}" do
      @client.send(:cache_locations_for, url).should == locations
    end
  end

  it "should purge urls" do
    urls = ["http://www.example.com/test/index.html"]
    res = @client.purge(urls)
    res.should be_kind_of(Hash)
    res.keys.should == urls
    res[urls.first].keys == ["localhost2:80", "localhost:80"]
    response = res[urls.first]["localhost:80"]
    response.should be_kind_of(Net::HTTPOK)
    response.code.should == "200"
  end
end
