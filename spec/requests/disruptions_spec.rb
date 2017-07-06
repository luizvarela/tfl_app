require 'rails_helper'

RSpec.describe 'Disruptions', type: :request do
  let(:traffic_disruptions_data) do
    [
      {
        'lat' => '51.510316',
        'long' => '-.08721',
        'comments' => 'foo bar',
        'location' => 'baz bar'
      }
    ]
  end

  describe '/disruptions' do
    describe 'when there is data available' do
      before { allow(Cache).to receive(:get).and_return(traffic_disruptions_data) }

      it 'calls the Fetcher class' do
        expect(TrafficDisruptions::Fetcher).to receive(:call).and_return(traffic_disruptions_data)

        get '/disruptions'
      end

      it 'returns all disruptions' do
        get '/disruptions'

        expect(JSON.parse(response.body)).to eq traffic_disruptions_data
      end

      it 'returns a status 200' do
        get '/disruptions'
        
        expect(response.status).to eq(200)
      end
    end

    describe 'when there is no data' do
      it 'returns an empty JSON' do
        get '/disruptions'

        expect(JSON.parse(response.body)).to eq []
      end

      it 'returns a status 200' do
        get '/disruptions'

        expect(response.status).to eq(200)
      end
    end
  end
end
