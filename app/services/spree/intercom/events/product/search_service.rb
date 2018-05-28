class Spree::Intercom::Events::Product::SearchService < Spree::Intercom::BaseService

  def initialize(options)
    @user = Spree::User.find_by(id: options[:user_id])
    @search_keyword = options[:search_keyword]
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
      event_name: 'search-product',
      created_at: Time.current.to_i,
      user_id: @user.intercom_user_id,
      metadata: {
        keyword: @search_keyword,
      }
    }
  end

end
