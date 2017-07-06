class TrafficDisruptionCacheJob < ActiveJob::Base
  queue_as :default

  def perform
    begin
      data = TrafficDisruptions::Parser.process
      Cache.set(TrafficDisruptions::Fetcher::CACHE_KEY, JSON.dump(data))
    rescue Faraday::ConnectionFailed
      Rails.logger.info('[Error] The XML fedd service is unavailable')
    end
  end
end
