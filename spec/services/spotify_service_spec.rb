require 'rails_helper'

describe SpotifyService do
  before do
    allow(RSpotify::Artist).to receive(:search).and_call_original
  end

  context 'when artist present' do
    let(:top_track) do
      SpotifyService.get_top_track('vakarchuk')
    end

    it 'should find artist' do
      expect(top_track).to eq({top_track: "Така, як ти",artist:"Svyatoslav Vakarchuk"})
      expect(RSpotify::Artist).to have_received(:search).with('vakarchuk')
    end
  end

  context 'when artist absent' do
    let(:top_track) do
      SpotifyService.get_top_track('aabbccdd')
    end

    it 'should find artist' do
      expect(top_track).to be_nil
      expect(RSpotify::Artist).to have_received(:search).with('aabbccdd')
    end
  end
end