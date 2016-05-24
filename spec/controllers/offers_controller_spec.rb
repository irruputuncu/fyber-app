require 'rails_helper'

RSpec.describe OffersController, type: :controller do

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'POST #search' do
    context 'with valid paramters' do
      it 'returns matching offers' do
        post :search, { user_id: 'player1', pub0: 'campaign2', page: 1, format: :js}
        expect(response).to render_template(:search)
      end
    end

    context 'with invalid parameters' do
      it 'renders an error message' do
        post :search, { pub0: 'campaign2', page: 1 , format: :js}
        expect(response).to render_template(:failure)
      end
    end
  end
end
