class TrafficDisruptions::Parser
  def self.process
    new.process
  end

  def process
    disruptions.map do |disruption|
      geolocation_node = disruption.dig('CauseArea', 'DisplayPoint', 'Point', 'coordinatesLL')

      next unless geolocation_node

      {
        lat: latitude(geolocation_node),
        long: longitude(geolocation_node),
        location: disruption['location'],
        comments: disruption['comments']
      }
    end.compact
  end

  private

  def longitude(node)
    node.split(',').first
  end

  def latitude(node)
    node.split(',').last
  end

  def disruptions
    return [] if body.empty?

    body.dig('Root', 'Disruptions', 'Disruption') || []
  end

  def body
    @body ||= connection.body
  end

  def connection
    @connection ||= Request.get
  end
end
