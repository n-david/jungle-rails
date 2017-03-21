require 'rails_helper'

RSpec.describe Order, type: :model do

  describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      @category = Category.create!(name: 'Phones')
      @product1 = Product.create!(name: 'iPhone 8', price: 1000, quantity: 8, category: @category)
      @product2 = Product.create!(name: 'Google Pixel C', price: 900, quantity: 13, category: @category)
      # Setup at least one product that will NOT be in the order
      @product3 = Product.create!(name: 'Samsung Galaxy Note 8', price: 950, quantity: 21, category: @category)
    end
    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(total_cents: @product1.price + @product2.price, stripe_charge_id: 123)
      # 2. build line items on @order
      @order.line_items.new(product: @product1, quantity: 2, item_price: @product1.price, total_price: @product1.price * @product1.quantity)
      @order.line_items.new(product: @product2, quantity: 3, item_price: @product2.price, total_price: @product2.price * @product2.quantity)
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      # @product1.reload
      # @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect { @product1.reload }.to change { @product1.quantity }.by(-LineItem.find_by(product: @product1).quantity)
      expect { @product2.reload }.to change { @product2.quantity }.by(-LineItem.find_by(product: @product2).quantity)
    end
    # pending test 2
    it 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints in previous test
      @order = Order.new(total_cents: @product1.price + @product2.price, stripe_charge_id: 123)
      @order.line_items.new(product: @product1, quantity: 2, item_price: @product1.price, total_price: @product1.price * @product1.quantity)
      @order.line_items.new(product: @product2, quantity: 3, item_price: @product2.price, total_price: @product2.price * @product2.quantity)
      @order.save!
      expect { @product3.reload }.to_not change { @product3.quantity }
    end
  end
end
