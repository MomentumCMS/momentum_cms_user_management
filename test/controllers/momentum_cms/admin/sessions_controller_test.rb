require 'test_helper'

class MomentumCms::Admin::SessionsControllerTest < ActionController::TestCase
  def setup
    @site = MomentumCms::Site.first
    @user = momentum_cms_users(:default)
    @user.email = 'user@domain.com'
    @user.password = 'passpass'
    @user.password_confirmation = 'passpass'
    @user.save!
    @user.reload
  end

  def test_proper_template
    get :new
    assert_template layout: 'layouts/momentum_cms/admin/application_guest'
  end

  def test_login
    post :create, momentum_cms_user: { email: 'user@domain.com', password: 'passpass' }
    assert_redirected_to cms_admin_root_path
  end

  def test_login_invalid
    post :create
    assert_template :new

    post :create, momentum_cms_user: { email: 'user@domain.com' }
    assert_template :new

    post :create, momentum_cms_user: { password: 'passpass' }
    assert_template :new

    post :create, momentum_cms_user: { email: 'user@domain.com', password: 'bassbass' }
    assert_template :new
  end

  def test_logout
    login_user(@user)
    delete :destroy

    assert_redirected_to cms_admin_root_path
  end

  def test_redirect_if_logged_in
    login_user(@user)
    get :new

    assert_redirected_to cms_admin_root_path
  end


end
