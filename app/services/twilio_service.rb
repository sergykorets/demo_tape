class TwilioService
  def self.send_sms(phone, message)
    client = Twilio::REST::Client.new('ACf9740b6ac694a9741c96a7a4b4adfb42', '6051d7cd115c5d52d4a61ae1e8ec083c')
    message = client.messages.create(
      from: '+18317132777',
      to: phone,
      body: message
    )
    { sid: message.sid }
  rescue Twilio::REST::TwilioError => e
    notify_warnings(e, phone)
  end

  private

  def self.notify_warnings(err, phone)
    logger = Logger.new(Rails.root.join('log', 'api_nofifier.log'))
    logger.info("SMS delivery failed to number #{phone}")
    { sid: nil, error_code: err.code, error_message: err.message }
  end
end