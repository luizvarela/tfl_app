# require boot & environment for a Rails app
require_relative "../config/boot"
require_relative "../config/environment"

require "clockwork"

module Clockwork
  every 10.minutes, 'traffic_disruptions.job' do
    TrafficDisruptionCacheJob.perform_later
  end
end
