require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'Tem 1 pedido belongs_to' do
    # order = create(:order)
    # puts order.customer
    order = create(:order)
    puts order.customer
    expect(order.customer).to be_kind_of(Customer)
  end

  it 'Tem 3 pedido - create_list' do
    # order = create(:order)
    # puts order.customer
    orders = create_list(:order, 3)
    puts orders.inspect #to see the 3 orders
    expect(orders.count).to eq(3)
  end

  it 'Tem 2 pedido - create_pair' do
    # order = create(:order)
    # puts order.customer
    orders = create_pair(:order)
    expect(orders.count).to eq(2)
  end

  it 'has_many' do
    customer = create(:customer, :with_orders)
    #customer = create(:customer, :with_orders, qtt_orders: 6) #overwritting 
    puts customer.inspect
    puts customer.orders.inspect
    expect(customer.orders.count).to eq(3)
  end

end
