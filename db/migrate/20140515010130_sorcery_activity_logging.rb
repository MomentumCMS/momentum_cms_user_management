class SorceryActivityLogging < ActiveRecord::Migration
  def change
    add_column :momentum_cms_users, :last_login_at,     :datetime, default: nil
    add_column :momentum_cms_users, :last_logout_at,    :datetime, default: nil
    add_column :momentum_cms_users, :last_activity_at,  :datetime, default: nil
    add_column :momentum_cms_users, :last_login_from_ip_address, :string, default: nil

    add_index :momentum_cms_users, [:last_logout_at, :last_activity_at], name: 'momentum_cms_users_l_l_a_l_a_a'
  end
end