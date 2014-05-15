require_relative '../../test_helper'

class MomentumCms::UserTest < ActiveSupport::TestCase

  def setup
  end

  def test_fixtures_are_valid
    MomentumCms::User.find_each do |user|
      assert user.persisted?
    end
  end

  def test_create
    assert_difference 'MomentumCms::User.count' do
      MomentumCms::User.create!(
        email: 'test@test.host',
        password: 'passpass',
        password_confirmation: 'passpass'
      )
    end
  end
end
