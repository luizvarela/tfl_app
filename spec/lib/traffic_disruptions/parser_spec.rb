require 'rails_helper'

RSpec.describe TrafficDisruptions::Parser do
  describe '.process' do
    let(:parser) { described_class.new }

    before do
      allow(described_class).to receive(:new).with(any_args).and_return(parser)
      allow(parser).to receive(:process).and_return('')
    end

    it 'creates a new TrafficDisruptions::Parser instance' do
      expect(described_class).to receive(:new)
      described_class.process
    end

    it 'calls #process' do
      expect(parser).to receive(:process).and_return('')
      described_class.process
    end
  end

  describe '#process' do
    let(:response) { double('response', body: body) }
    let(:expected_result) do
      [
        {
          lat: '51.510316',
          long: '-.08721',
          comments: 'foo bar',
          location: 'baz bar'
        }
      ]
    end

    describe 'when there is data' do
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

      it 'returns the parsed response' do
        allow(Request).to receive(:get).and_return(response)

        expect(described_class.process).to eq expected_result
      end
    end

    describe 'when there is not data' do
      let(:body) { {} }

      it 'returns an empty array' do
        allow(Request).to receive(:get).and_return(response)

        expect(described_class.process).to eq []
      end
    end

    describe 'when Disruption node is empty' do
      let(:body) do
        {
          'Root' => {
            'Disruptions' => {
              'Disruption' => []
            }
          }
        }
      end

      it 'returns an empty array' do
        allow(Request).to receive(:get).and_return(response)

        expect(described_class.process).to eq []
      end
    end

    describe 'when Disruptions node is empty' do
      let(:body) do
        {
          'Root' => {
            'Disruptions' => {
            }
          }
        }
      end

      it 'returns an empty array' do
        allow(Request).to receive(:get).and_return(response)

        expect(described_class.process).to eq []
      end
    end

    describe 'when Root node is empty' do
      let(:body) do
        {
          'Root' => {}
        }
      end

      it 'returns an empty array' do
        allow(Request).to receive(:get).and_return(response)

        expect(described_class.process).to eq []
      end
    end

    describe 'when CauseArea node is empty' do
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
                },
                {
                  'CauseArea' => {},
                  'comments' => 'comment test',
                  'location' => 'location test'
                }
              ]
            }
          }
        }
      end

      it 'not allow nil results in array' do
        allow(Request).to receive(:get).and_return(response)

        expect(described_class.process).to eq expected_result
      end
    end
  end
end
