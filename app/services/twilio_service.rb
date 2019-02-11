class TwilioService
  def self.send_sms(phone, message)
    client = Twilio::REST::Client.new('ACf9740b6ac694a9741c96a7a4b4adfb42', '6051d7cd115c5d52d4a61ae1e8ec083c')
    client.messages.create(
      from: '+18317132777',
      to: phone,
      body: message
    )
  rescue Twilio::REST::TwilioError => e
    show_error(e, phone)
  end

  private

  def self.show_error(err, phone)
    puts "SMS delivery failed to number #{phone}"
    puts err
    err
  end
end