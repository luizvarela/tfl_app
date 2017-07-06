require 'rails_helper'

RSpec.describe 'Disruptions', type: :request do
  let(:body) do
    {
      'Root' => {
        'Disruptions' => {
          'Disruption' => [
            {
              'CauseArea' => {
                'DisplayPoint' => {
                  'Point' => {
                    'coordinatesLL' => '-.08721,51.510316'
                  }
                }
              },
              'comments' => 'foo bar',
              'location' => 'baz bar'
            }
          ]
        }
      }
    }
  end
  let(:feed_response) { double('response', body: body) }
  let(:expected_result) do
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
    it 'returns all disruptions parsed from the TFL feed' do
      allow(Request).to receive(:get).and_return(feed_response)

      get '/disruptions'

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq expected_result
    end

    it 'returns an empty JSON when there is no data' do
      allow(Request).to receive(:get).and_return(double('response', body: []))

      get '/disruptions'

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq []
    end
  end
end
