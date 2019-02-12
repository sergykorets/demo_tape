require 'rails_helper'

describe TwilioService do
  describe '#send_sms' do
    context 'when send successfully' do
      subject(:send_sms) do
        TwilioService.send_sms('+18022425759', 'Test sms')
      end

      it 'should send SMS' do
        expect(send_sms).to eq 'Test sms'
      end
    end

    context 'when send to fake phone' do
      subject(:send_sms) do
        TwilioService.send_sms('+95505550000', 'Test sms')
      end

      let(:error_message) do
        "[HTTP 400] 21614 : Unable to create record\nTo number: +95505550000, "\
        "is not a mobile number\nhttps://www.twilio.com/docs/errors/21614\n\n"
      end

      it 'should not send SMS' do
        expect(send_sms).to eq error_message
      end
    end
  end
end