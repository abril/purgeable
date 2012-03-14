# encoding: UTF-8
require "spec_helper"

describe "The resource model" do
  class FakeModel
    attr_accessor :slug, :uuid
    include ::Purgeable::HttpResource

    http_purge { "http://varnish.example.com/#{slug}" }
    http_purge :resource_url
    # after_save :perform_purge

    def resource_url
      "http://varnish.example.com/id/#{uuid}" unless uuid.nil?
    end
  end

  before { @model = FakeModel.new }

  it "should has purgeable urls" do
    @model.slug = "teste"
    @model.purgeable_urls.should == ["http://varnish.example.com/teste"]
    @model.uuid = 10
    @model.purgeable_urls.should ==
      ["http://varnish.example.com/teste", "http://varnish.example.com/id/10"]
  end
end
