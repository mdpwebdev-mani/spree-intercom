class Spree::Intercom::Events::LineItem::CreateService < Spree::Intercom::BaseService

  EVENT_NAME = 'added-product'

  def initialize(options)
    @user = Spree.user_class.find_by(id: options[:user_id])
    @line_item = Spree::LineItem.find_by(id: options[:line_item_id])
    @order = Spree::Order.find_by(number: options[:order_number])
    @sku = options[:sku]
    super()
  end

  def register
    send_request
  end

  def perform
    @intercom.events.create(event_data)
  end

  def event_data
    {
      event_name: EVENT_NAME,
      created_at: @line_item.created_at,
      user_id: @user.intercom_user_id,
      metadata: {
        order_number: {
          url: order_url,
          value: @order.number
        },
        product: @line_item.name,
        sku: @sku,
        quantity: @line_item.quantity
      }
    }
  end

end
