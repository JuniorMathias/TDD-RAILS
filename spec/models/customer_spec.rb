require 'rails_helper'

RSpec.describe Customer, type: :model do
  # fixtures :customers

  # it 'Create a Customer' do
  #   subject.name = "Junior"
  #   subject.email = "junior@mathias.com"
  #   subject.save
  #   expect(subject.full_name).to eq("Sr. Junior")
  # end

  # it 'Create a Customer with fixtures' do
  #  customer = customers(:jackson)
  #   expect(customer.full_name).to eq("Sr. jackson")
  # end

  # it 'Create a Customer with a factory' do
  #   customer = create(:customer)
  #    expect(customer.full_name).to eq("Sr. Junior")
  # end
  it 'Herança' do
    customer = create(:customer, vip: false, days_to_pay: 10)
     expect(customer.vip).to eq(false)
  end

  it 'Create a Customer with a gem Faker' do
    customer = create(:customer, name: "Junior")
     expect(customer.full_name).to eq("Sr. Junior")
  end
  it {expect{create(:customer)}.to change {Customer.all.size}.by(1)}
end
