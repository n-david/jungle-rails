class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true
  validates :stripe_charge_id, presence: true
  after_create :decrease_quantity

  def decrease_quantity
    self.line_items.each do |line_item|
      line_item.product.decrement!(:quantity, line_item.quantity)
    end
  end

end
