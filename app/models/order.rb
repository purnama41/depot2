class Order < ApplicationRecord
  enum pay_type: {
    "Check" => 0,
    "Credit card" => 1,
    "Purchase order" => 2
  }

  has_many :line_items, dependent: :destroy
  # ...
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def total_order
    line_items.to_a.sum { |item| item.quantity }
  end

  def total_price
    line_items.to_a.sum {|item| item.total_price}
  end
end
