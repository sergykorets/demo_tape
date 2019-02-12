
require 'rails_helper'

describe SongFinderController, type: :controller do
  describe 'GET index' do
    it 'renders page' do
      get :index
      response.should render_template :index
    end
  end

  describe 'POST #create' do
    let(:params) { { artist: 'Arctic Monkeys', phone: '+12813181031' } }

    context 'when success' do
      it 'should return a success response' do
        post :create, params: params, format: :json
        expect(response.body).to be_json_eql(%({"success": true, "messages": ["Arctic Monkeys's top track: Do I Wanna Know?"]}))
      end
    end

    context 'when failure' do
      let(:wrong_params) { params.merge(phone: '+02813181031') }

      it 'should return response with errors' do
        post :create, params: wrong_params, format: :json
        expect(parse_json(response.body).values).to eq([false, ["Phone is invalid"]])
      end
    end
  end
end