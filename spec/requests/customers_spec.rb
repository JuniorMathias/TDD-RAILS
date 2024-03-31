require 'rails_helper'

RSpec.describe "Customers", type: :request do
  describe "GET /customers" do
    it "works! 200 ok" do
      get customers_path
      expect(response).to have_http_status(200)
    end
    it "index - with include JSON" do
      get "/customers.json"
      expect(response).to have_http_status(200)
      expect(response.body).to include_json([
        id: 1,
        name: "Msgr. Luigi Hermiston",
        email: "enola@thompson-lakin.org"
      ])
    end
    it "RSpec include_JSON" do
      get "/customers.json"
      expect(response).to have_http_status(200)
      expect(response.body).to include_json([
        id: /\d/,
        name: (be_kind_of String),
        email: (be_kind_of String)
      ])
    end

    it "show - with include JSON" do
      get "/customers/1.json"
      expect(response).to have_http_status(200)
      expect(response.body).to include_json(
        id: 1
      )
    end

    it "Create with JSON" do
      member = create(:member)
      login_as(member, scope: :member)

      headers = { "ACCEPT" => 'application/json'}
      customer_params = attributes_for(:customer)

      post "/customers.json", params: {customer: customer_params}, headers: headers
      expect(response.body).to include_json(
        id: /\d/,
        name:customer_params[:name],
        email: customer_params.fetch(:email)
      )
    end
    
  end
end
