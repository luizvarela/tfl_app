class TrafficDisruptions::Fetcher
  class MissingCacheAdapter < StandardError; end

  CACHE_KEY = 'traffic_disruptions_data'.freeze

  def self.call
    raise MissingCacheAdapter if Cache.adapter.nil?
    
    Cache.get(CACHE_KEY) || []
  end
end
