class TrafficDisruptions::Fetcher
  def self.call
    Cache.get('traffic_disruptions_data') || []
  end
end
