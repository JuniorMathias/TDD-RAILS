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
    customer = create(:customer_vip)
     expect(customer.vip).to eq(true)
  end

  it 'Herança' do
    customer = create(:customer_default)
     expect(customer.vip).to eq(false)
  end

  it 'Using the attributes_for, it brings as a hash' do
    attrs = attributes_for(:customer)
    attrs1 = attributes_for(:customer_vip)
    attrs2 = attributes_for(:customer_default)
    puts attrs
    puts attrs1
    puts attrs2
  end

  it 'Create a Customer with a gem Faker' do
    customer = create(:customer, name: "Junior")
     expect(customer.full_name).to eq("Sr. Junior")
  end
  it {expect{create(:customer)}.to change {Customer.all.size}.by(1)}
end
