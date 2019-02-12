class SongFinderController < ApplicationController

  def index; end

  def create
    validation_params = {artist: params[:artist], phone: params[:phone]}
    validator = SongFinderValidator.new(validation_params)
    if validator.valid?
      spotify = SpotifyService.get_top_track(params[:artist])
      if spotify
        message = "#{spotify[:artist]}'s top track: #{spotify[:top_track]}"
        TwilioService.send_sms(validator.phone, message)
        render json: {success: true, messages: [message]}
      else
        render json: {success: false, messages: ['Top track not found']}
      end
    else
      render json: {success: false, messages: validator.errors.full_messages}
    end
  end
end