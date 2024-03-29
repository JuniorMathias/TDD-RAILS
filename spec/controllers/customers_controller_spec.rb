require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  context 'as a guest' do  

    it 'with valid attributes' do
      customer_params = attributes_for(:customer)
      puts customer_params
    end
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

  describe 'as logged member' do
    before do 
      @member = create(:member)
      @customer = create(:customer)
    end

    it 'Content-type' do
      customer_params = attributes_for(:customer)
      sign_in @member
      post :create, format: :json, params: {customer: customer_params}
      expect(response.content_type).to eq('application/json')
    end

    it 'flash notice' do
      customer_params = attributes_for(:customer)
      sign_in @member
      post :create, params: {customer: customer_params}
      expect(flash[:notice]).to match(/successfully created/)
    end

    it { should route(:get, '/customers').to(action: :index)}

    it 'with valid attributes' do
      customer_params = attributes_for(:customer)
      sign_in @member
      #post is a action
      expect {
        post :create, params: {customer: customer_params}
      }.to change(Customer, :count).by(1)
    end

    it 'with invalid attributes' do
      customer_params = attributes_for(:customer, address: nil)
      sign_in @member
      #post is a action
      expect {
        post :create, params: {customer: customer_params}
      }.not_to change(Customer, :count)
    end

    it '#show (member authorized)' do
      sign_in @member

      get :show, params: {id: @customer.id}
      expect(response).to have_http_status(200)
    end

    it '#show (member authorized)' do
      sign_in @member

      get :show, params: {id: @customer.id}
      expect(response).to render_template(:show)
    end
  end

end
