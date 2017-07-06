class TrafficDisruptionCacheJob < ActiveJob::Base
  queue_as :default

  def perform
    data = TrafficDisruptions::Parser.process
    Cache.set('traffic_disruptions_data', JSON.dump(data))
  end
end
