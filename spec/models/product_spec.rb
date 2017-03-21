require 'rails_helper'

RSpec.describe Product, type: :model do

  before(:all) do
    @category = Category.create(name: 'Phones')
  end

  describe 'Validations' do
    context 'when creating a product' do

      it 'is valid with all parameters' do
        @product = Product.new(name: 'iPhone 8', price: 1000, quantity: 2, category: @category)
        expect(@product).to be_valid
      end

      it 'is not valid without a name' do
        @product = Product.new(name: nil, price: 1000, quantity: 2, category: @category)
        expect(@product).to_not be_valid
        expect(@product.errors).to have_key(:name)
      end

      it 'is not valid without a price' do
        @product = Product.new(name: 'iPhone 8', price: nil, quantity: 2, category: @category)
        expect(@product).to_not be_valid
        expect(@product.errors).to have_key(:price)
      end

      it 'is not valid without a quantity' do
        @product = Product.new(name: 'iPhone 8', price: 1000, quantity: nil, category: @category)
        expect(@product).to_not be_valid
        expect(@product.errors).to have_key(:quantity)
      end

      it 'is not valid without a category' do
        @product = Product.new(name: 'iPhone 8', price: 1000, quantity: 2, category: nil)
        expect(@product).to_not be_valid
        expect(@product.errors).to have_key(:category)
      end

    end
  end

end
