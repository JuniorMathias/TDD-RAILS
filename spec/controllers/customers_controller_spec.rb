require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  context 'as a guest' do  

    it 'responds successfully' do
      get :index
      expect(response).to be_success
    end

    it 'responds 200 response' do
      get :index
      expect(response).to have_http_status(200)
    end

    it 'responds 302 response (not authorized)' do
      customer = create(:customer)
      get :show, params: {id: customer.id}
      expect(response).to have_http_status(302)
    end

  end

  context 'as logged member' do
    it '#show (member authorized)' do
      member = create(:member)
      customer = create(:customer)

      sign_in member

      get :show, params: {id: customer.id}
      expect(response).to render_template(:show)
    end
  end

end
