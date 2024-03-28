require 'rails_helper'

RSpec.describe Customer, type: :model do
  # fixtures :customers

  # it 'Create a Customer' do
  #   subject.name = "Junior"
  #   subject.email = "junior@mathias.com"
  #   subject.save
  #   expect(subject.full_name).to eq("Sr. Junior")
  # end
  it 'Sequences' do
    customer = create(:customer, name: "Junior")
    puts customer.email
    expect(customer.full_name).to eq("Sr. Junior")
  end

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

  it 'Herança with a def on factories' do
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

  it 'Customer Male' do
    customer = create(:customer_male_vip)
    expect(customer.gender).to eq('M')
    expect(customer.vip).to eq(true)
  end

  it 'Customer FeMale' do
    customer = create(:customer_female_vip)
    expect(customer.gender).to eq('F')
    expect(customer.vip).to eq(true)
  end

  it 'Travel_to' do
    travel_to Time.zone.local(2004, 11, 24, 01, 04, 44) do
      @customer = create(:customer_vip)
      # Time.current
    end
    puts @customer.created_at
    expect(@customer.created_at).to eq(Time.new(2004, 11, 24, 1, 4, 44, '-02:00'))
    expect(@customer.created_at).to be <Time.now
  end

  it 'Atributo Transitório' do
    customer = create(:customer_default, upcased: true)
    expect(customer.name.upcase).to eq(customer.name)
  end
end
