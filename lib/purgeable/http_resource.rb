# encoding: UTF-8
module Purgeable
  module HttpResource
    def self.included(base)
      base.extend ClassMethods
    end

    def purgeable_urls
      purge_generators.map{ |p| [p.is_a?(Symbol) ? send(p) : instance_eval(&p)] }.flatten.compact.uniq
    end

  protected

    def perform_purge!
      ::Purgeable::Client.new.purge(purgeable_urls)
    end

    def perform_purge
      perform_purge! rescue {}
    end

  private

    def purge_generators
      self.class.instance_variable_get(:@purge_generators) || []
    end

    module ClassMethods
      def http_purge(method = nil, &block)
        (@purge_generators ||= []) << (block_given? ? block : method)
      end
    end
  end
end
