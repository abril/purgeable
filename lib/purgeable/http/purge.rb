# encoding: UTF-8
require "net/http"

module Purgeable
  module HTTP
    class Purge < Net::HTTPRequest
      METHOD = "PURGE"
      REQUEST_HAS_BODY = false
      RESPONSE_HAS_BODY = true
    end
  end
end
