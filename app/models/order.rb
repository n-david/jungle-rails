class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true
  validates :stripe_charge_id, presence: true
  after_create :decrease_quantity

  def decrease_quantity
    line_items = LineItem.where(order_id: self.id)
    line_items.each do |line_item|
      product = Product.find(line_item.product_id)
      product.decrement!(:quantity, line_item.quantity)
    end
  end

end
