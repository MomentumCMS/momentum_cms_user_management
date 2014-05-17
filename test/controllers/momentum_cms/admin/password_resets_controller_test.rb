require 'test_helper'

class MomentumCms::Admin::PasswordResetsControllerTest < ActionController::TestCase

  def setup
    @site = MomentumCms::Site.first
    @user = momentum_cms_users(:default)
    @user.email = 'user@domain.com'
    @user.password = 'passpass'
    @user.password_confirmation = 'passpass'
    @user.save!
    @user.reload
  end

  def test_index
    get :new
    assert_response :ok
  end

  def test_create
    assert_difference 'ActionMailer::Base.deliveries.length' do
      post :create, momentum_cms_user: { email: 'user@domain.com' }
    end
  end

  def test_create_invalid
    assert_no_difference 'ActionMailer::Base.deliveries.length' do
      post :create, momentum_cms_user: { email: 'user2@domain.net' }
    end
  end

  def test_edit
    post :create, momentum_cms_user: { email: 'user@domain.com' }

    @user.reload
    get :edit, id: @user.reset_password_token

    assert_response :ok
  end

  def test_edit_invalid
    post :create, momentum_cms_user: { email: 'user@domain.com' }

    @user.reload
    get :edit, id: 'testtest'

    assert_response :redirect
    assert_redirected_to cms_admin_login_path
  end

  def test_update
    @user.deliver_reset_password_instructions!

    put :update, id: 'testtest'
    assert_response :redirect
    assert_redirected_to cms_admin_login_path

    put :update, id: 'testtest', momentum_cms_user: { token: @user.reset_password_token }
    assert_template :edit

    put :update, id: 'testtest', momentum_cms_user: { token: @user.reset_password_token, password: 'password' }
    assert_template :edit

    put :update, id: 'testtest', momentum_cms_user: { token: @user.reset_password_token, password: 'password', password_confirmation: 'password' }
    assert_redirected_to cms_admin_root_path
  end

end
