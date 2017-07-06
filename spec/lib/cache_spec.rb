require 'rails_helper'

RSpec.describe Cache do
  let(:adapter) { double('RedisAdapter') }
  let!(:original_adapter) { described_class.adapter }
  let(:cache_key) { 'some_key' }
  let(:data) { { foo: 123 } }

  before do
    described_class.adapter = adapter
  end

  after do
    described_class.adapter = original_adapter
  end

  describe '.get' do
    it 'returns the cached data' do
      allow(adapter).to receive(:get).with(cache_key).and_return(data)

      expect(described_class.get(cache_key)).to eq data
    end
  end

  describe '.set' do
    it 'sets the data with the key passed' do
      allow(adapter).to receive(:set)

      expect(adapter).to receive(:set).with(cache_key, data)

      described_class.set(cache_key, data)
    end
  end
end
