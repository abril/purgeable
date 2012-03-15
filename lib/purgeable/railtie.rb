# encoding: UTF-8
module Purgeable
  class Railtie < ::Rails::Railtie
    initializer "setup http cache" do
      require File.expand_path("../../../rails/init.rb", __FILE__)
    end
  end
end
