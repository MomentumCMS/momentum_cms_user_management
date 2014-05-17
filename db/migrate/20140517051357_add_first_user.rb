class AddFirstUser < ActiveRecord::Migration
  def up
    MomentumCms::User.create!(email: 'admin@localhost',
                              password: 'password',
                              password_confirmation: 'password',
                              activation_state: 'active')
  end

  def down
  end
end
