class ReceiptMailer < ApplicationMailer
  default from: "lighthouse.labs@yandex.com"

  def order_email(order)
    @order = order
    mail(to: @order.email, subject: "Your order from the Jungle (Order ##{@order.id})")
  end

end
