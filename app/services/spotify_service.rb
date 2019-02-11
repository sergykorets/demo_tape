class SpotifyService
  def self.get_top_track(artist_name)
    RSpotify.authenticate("3a6010e0d5eb491996b9b10ec5722bae", "6b4b95f225134775a2beb8de051b55b6")
    artist = RSpotify::Artist.search(artist_name).first
    return unless artist

    top_track = artist.top_tracks(:US).first
    TwilioService.send_sms('+380935997182', "#{artist.name}'s top track: #{top_track.name}")
  end
end