require 'rails_helper'

RSpec.describe TrafficDisruptions::Fetcher do
  describe '.call' do
    it 'calls the Cache class' do
      double = double('traffic_disruptions_data')
      allow(Cache).to receive(:get).and_return(double)

      expect(Cache).to receive(:get)
        .with(TrafficDisruptions::Fetcher::CACHE_KEY)

      described_class.call
    end

    it 'returns an empty array when Cache.get is nil' do
      allow(Cache).to receive(:get).and_return(nil)

      expect(described_class.call).to eq []
    end
  end

  describe 'execptions' do
    it 'raises an error when Cache adapter is nil' do
      allow(Cache).to receive(:adapter).and_return(nil)

      expect{described_class.call}.to \
        raise_error(TrafficDisruptions::Fetcher::MissingCacheAdapter)
    end
  end
end
