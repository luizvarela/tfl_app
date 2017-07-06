class DisruptionsParser
  def self.process
    new.process
  end

  def process
    Rails.cache.fetch('disruptions_parser', expires_in: 5.minutes) do
      disruptions.map do |disruption|
        geolocation_node = disruption["CauseArea"]["DisplayPoint"]["Point"]["coordinatesEN"]

        {
          lat: latitude(geolocation_node),
          long: longitude(geolocation_node),
          comments: disruption["comments"]
        }
      end
    end
  end

  private

  def longitude(node)
    node.split(",").first
  end

  def latitude(node)
    node.split(",").last
  end

  def disruptions
    return [] if body.empty?

    body["Root"]["Disruptions"]["Disruption"]
  end

  def body
    @body ||= connection.body
  end

  def connection
    @connection ||= Request.get
  end
end
