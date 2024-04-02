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

    it "show JSON pure" do
      get "/customers/1.json"
      response_body = JSON.parse(response.body)
      expect(response_body.fetch("id")).to eq(1)
      expect(response_body.fetch("name")).to be_kind_of(String)
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


    it "Update with JSON" do
      member = create(:member)
      login_as(member, scope: :member)

      headers = { "ACCEPT" => 'application/json'}
      customers = Customer.first
      customers.name += "Atualizado"
      put "/customers/#{customers.id}.json", params: {customer: customers.attributes}, headers: headers
      expect(response.body).to include_json(
        id: /\d/,
        name:customers.name,
        email: customers.email
      )
    end

    it "Delete with JSON" do
      member = create(:member)
      login_as(member, scope: :member)

      headers = { "ACCEPT" => 'application/json'}
      customers = Customer.first

      expect { delete "/customers/#{customers.id}.json", headers: headers }.to change(Customer, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
