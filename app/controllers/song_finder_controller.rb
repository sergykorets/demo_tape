class SongFinderController < ApplicationController

  def index; end

  def create
    spotify = SpotifyService.get_top_track(params[:artist])
    if spotify
      message = "#{spotify[:artist]}'s top track: #{spotify[:top_track]}"
      sms_status = TwilioService.send_sms(params[:phone], message)
      unless sms_status.is_a?(Twilio::REST::TwilioError)
        render json: {success: true, message: message}
      else
        render json: {success: false, message: sms_status}
      end
    else
      render json: {success: false, message: 'Top track not found'}
    end
  end
end