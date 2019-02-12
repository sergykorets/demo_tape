require 'rails_helper'

describe SongFinderValidator, type: :validator do
  subject(:validator) { SongFinderValidator.new(params) }

  let(:valid_params) { { artist: 'vakarchuk', phone: '+12813181031' } }

  context 'when all params are valid' do
    let(:params) { valid_params }

    it 'should be valid' do
      expect(validator.valid?).to eq true
    end
  end

  context 'when one of params is invalid' do
    context 'when artist is invalid' do
      context 'when nil' do
        let(:params) { valid_params.merge(artist: nil) }

        it 'should be invalid' do
          expect(validator.valid?).to eq false
          expect(validator.errors.messages).to eq(artist: ["can't be blank"])
        end
      end

      context 'when blank' do
        let(:params) { valid_params.merge(artist: '') }

        it 'should be invalid' do
          expect(validator.valid?).to eq false
          expect(validator.errors.messages).to eq(artist: ["can't be blank"])
        end
      end
    end

    context 'when phone is invalid' do
      context 'when is not a phone number' do
        let(:params) { valid_params.merge(phone: 'not_a_phone') }

        it 'should be invalid' do
          expect(validator.valid?).to eq false
          expect(validator.errors.messages).to eq(phone: ['is invalid'])
        end
      end

      context 'when is not approved by Twilio' do
        let(:params) { valid_params.merge(phone: '+19160000001') }

        it 'should be invalid' do
          expect(validator.valid?).to eq false
          expect(validator.errors.messages).to eq(phone: ['is invalid'])
        end
      end
    end
  end
end