class AddIntercomUserIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column Spree.user_class.table_name.to_sym, :intercom_user_id, :string
    add_index Spree.user_class.table_name.to_sym, :intercom_user_id, unique: true
  end
end
