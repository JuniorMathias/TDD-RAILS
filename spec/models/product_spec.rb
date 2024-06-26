require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'it is valid with description, price and category' do
    product = create(:product)
    expect(product).to be_valid
  end

  context 'Validates' do
    it {is_expected.to validate_presence_of(:description)}
    it {is_expected.to validate_presence_of(:price)}
    it {is_expected.to validate_presence_of(:category)}
  end
  context 'Associations' do
    it {is_expected.to belong_to(:category)}
  end
  ## é a mesma coisa que abaixo só que acima é mais resulmido
  context 'Instance Methods without should' do
    it 'it is invalid without description' do
      product = build(:product, description: nil)
      product.valid?
      expect(product.errors[:description]).to include("can't be blank")
    end

    it 'it is invalid without price' do
      product = build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("can't be blank")
    end

    it 'it is invalid without category' do
      product = build(:product, category: nil)
      product.valid?
      expect(product.errors[:category]).to include("can't be blank")
    end

    it 'Return a product with a full description' do
      product = create(:product)
      product.valid?
      expect(product.full_description).to eq("#{product.description} - #{product.price}")
    end
  end
end
