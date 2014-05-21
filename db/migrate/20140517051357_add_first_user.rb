class AddFirstUser < ActiveRecord::Migration
  def up
    MomentumCms::User.create!(email: 'admin@localhost',
                              password: 'password',
                              password_confirmation: 'password')

    MomentumCms::User.first.activate!
  end

  def down
  end
end
