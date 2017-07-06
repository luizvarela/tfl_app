require 'rails_helper'

RSpec.describe Request do
  describe '#get' do
    it 'calls the get method' do
      connection = double('connection', get: '')
      allow(described_class).to receive(:conn).and_return(connection)

      expect(described_class).to receive(:get)
      described_class.get
    end

    it 'returns the server response' do
      stub_request(:get, 'https://data.tfl.gov.uk/tfl/syndication/feeds/tims_feed.xml')
        .to_return(status: 200, body: '', headers: {})

      expect(described_class.get).to be_an_instance_of(Faraday::Response)
    end
  end
end
