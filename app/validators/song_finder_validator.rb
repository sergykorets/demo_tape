class SongFinderValidator < BaseValidator
  attr_accessor :artist, :phone

  validates_presence_of :artist, :phone

  validate :validate_phone

  private

  def validate_phone
    response = Twilio::REST::Client.new(Rails.application.credentials.dig(:twilio, :username), Rails.application.credentials.dig(:twilio, :password)).lookups.v1.phone_numbers(phone).fetch(type: 'carrier')
    @phone = response.phone_number
    rescue Twilio::REST::RestError
      errors.add(:phone, :invalid)
  end
end