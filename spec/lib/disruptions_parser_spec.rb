require 'rails_helper'

RSpec.describe DisruptionsParser do
  describe '.process' do
    let(:parser) { described_class.new }

    before do
      allow(described_class).to receive(:new).with(any_args).and_return(parser)
      allow(parser).to receive(:process).and_return("")
    end

    it "creates a new DisruptionsParser instance" do
      expect(described_class).to receive(:new)
      described_class.process
    end

    it "calls #process" do
      expect(parser).to receive(:process).and_return("")
      described_class.process
    end
  end

  describe '#process' do
    let(:body) do
      {
        "Root" => {
          "Disruptions" => {
            "Disruption" => [
              {
                "CauseArea" => {
                  "DisplayPoint" => {
                    "Point" => {
                      "coordinatesEN" => '-.08721,51.510316'
                    }
                  }
                },
                "comments" => "foo bar"
              }
            ]
          }
        }
      }
    end
    let(:response) { double('response', body: body) }
    let(:expected_result) do
      [
        {
          lat: '51.510316',
          long: '-.08721',
          comments: 'foo bar'
        }
      ]
    end

    it 'returns the response in a json format' do
      allow(Request).to receive(:get).and_return(response)

      expect(described_class.process).to eq expected_result
    end

    it 'returns an empty array when request is empty' do
      allow(Request).to receive(:get).and_return(double('response', body: {}))

      expect(described_class.process).to eq []
    end
  end
end
