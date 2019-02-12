class SpotifyService
  def self.get_top_track(artist_name)
    RSpotify.authenticate(Rails.application.credentials.dig(:spotify, :cliend_id), Rails.application.credentials.dig(:spotify, :client_secret))
    artist = RSpotify::Artist.search(artist_name).first
    return unless artist
    {top_track: artist.top_tracks(:US).first.name, artist: artist.name}
  end
end