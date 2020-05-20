class Spree::Intercom::UpdateUserService < Spree::Intercom::BaseService

  def initialize(id)
    @user = Spree.user_class.find_by(id: id)
    super()
  end

  def perform
    user = @intercom.users.find(user_id: @user.intercom_user_id)
    user_data = Spree::Intercom::UserSerializer.new(@user).serializable_hash

    user_data.each do |key, value|
      user.public_send "#{key}=", value
    end

    @intercom.users.save(user)
  end

  def update
    send_request

    if @response.try(:success?)
      Spree::Intercom::Events::User::UpdateService.new(@user.id).register
    end
  end

end
