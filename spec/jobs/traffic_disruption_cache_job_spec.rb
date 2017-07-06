require 'rails_helper'

RSpec.describe TrafficDisruptionCacheJob, type: :job do
  let(:data) { { foo: '123' } }
  let(:cache_key) { TrafficDisruptions::Fetcher::CACHE_KEY }

  describe 'perform' do
    it 'calls the Cache store class' do
      allow(TrafficDisruptions::Parser).to receive(:process).and_return(data)
      expect(Cache).to receive(:set).with(cache_key, JSON.dump(data))

      described_class.new.perform
    end

    describe 'receiving a ConnectionFailed error' do
      before do
        allow(TrafficDisruptions::Parser).to \
          receive(:process).and_raise(Faraday::ConnectionFailed.new('error'))
      end

      it 'logs the error on Rails logger' do
        expect(Rails.logger).to \
          receive(:info).with('[Error] The XML fedd service is unavailable')

        described_class.new.perform
      end

      it 'no store anything in the cache' do
        expect(Cache).to_not receive(:set)

        described_class.new.perform
      end
    end
  end
end
