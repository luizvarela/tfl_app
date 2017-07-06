class Request
  class << self
    TFL_URL = 'https://data.tfl.gov.uk/tfl/syndication/feeds/tims_feed.xml'.freeze

    def get
      conn.get
    end

    def conn
      Faraday.new TFL_URL do |conn|
        conn.use FaradayMiddleware::ParseXml,  :content_type => /\bxml$/
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
