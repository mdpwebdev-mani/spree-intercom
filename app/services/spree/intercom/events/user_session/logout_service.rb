class Spree::Intercom::Events::UserSession::LogoutService < Spree::Intercom::BaseService

  EVENT_NAME = 'logged-out'

  def initialize(options)
    @user = Spree.user_class.find_by(id: options[:user_id])
    @time = options[:time]
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
      user_id: @user.intercom_user_id
    }
  end

end
