class TwilioService
  def self.send_sms(phone, message)
    client = Twilio::REST::Client.new(Rails.application.credentials.dig(:twilio, :username), Rails.application.credentials.dig(:twilio, :password))
    sms = client.messages.create(
      from: '+18317132777',
      to: phone,
      body: message
    )
    sms.body
  rescue Twilio::REST::TwilioError => e
    show_error(e, phone)
  end

  private

  def self.show_error(err, phone)
    puts "SMS delivery failed to number #{phone}"
    puts err
    err.message
  end
end