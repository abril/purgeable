# encoding: UTF-8
module Purgeable
  class Client
    def purge(urls)
      if urls.is_a?(String)
        cache_locations_for(urls).map{ |location| perform_purge(location, urls) }
      elsif urls.is_a?(Array)
        urls.map{ |url| purge(url) }
      end
    end

  private

    def perform_purge(location, url)
      ip, port = location.split(/:/)
      port = 80 if port.nil? || port.empty?
      protocol, host, path = split_url(url)
      req = HTTP::Purge.new(path)
      req["Host"] = host
      Net::HTTP.new(ip, port).start do |http|
        http.request req
      end
    end

    def split_url(url)
      url.scan(/^([^\/]+)?\/\/([^\/ ]+) ?(.*)?$/).flatten
    end

    def cache_locations_for(url)
      uri_host = split_url(url)[1]
      SETTINGS.http_cache.each do |config|
        return config.cache_locations if config.resource_hosts.any?{ |host| uri_host == host }
      end
      []
    end
  end
end
