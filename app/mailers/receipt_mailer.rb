class ReceiptMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def order_email(order)
    @order = order
    @line_items = LineItem.where(order_id: @order.id)
    mail(to: @order.email, subject: "Your order from the Jungle (Order ##{@order.id})")
  end

end
