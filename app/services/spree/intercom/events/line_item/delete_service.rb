class Spree::Intercom::Events::LineItem::DeleteService < Spree::Intercom::BaseService

  EVENT_NAME = 'removed-product'

  def initialize(options)
    @user = Spree.user_class.find_by(id: options[:user_id])
    @time = options[:time]
    @order = Spree::Order.find_by(number: options[:order_number])
    @sku = options[:sku]
    @name = options[:name]
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
      created_at: @time,
      user_id: @user.intercom_user_id,
      metadata: {
        order_number: {
          url: order_url,
          value: @order.number
        },
        product: @name,
        sku: @sku
      }
    }
  end

end
