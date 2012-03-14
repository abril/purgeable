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
    res = @client.purge(["http://www.example.com/test/index.html"])
    res.should be_kind_of(Array)
    res.size.should be 1
    res.first.should be_kind_of(Array)
    res.first.size.should be 2
    res.first.first.should be_kind_of(::Net::HTTPOK)
    res.first.last.should be_kind_of(::Net::HTTPOK)
  end
end
