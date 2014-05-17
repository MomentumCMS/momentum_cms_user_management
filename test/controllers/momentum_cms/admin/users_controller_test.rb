require_relative '../../../test_helper'

class MomentumCms::Admin::UsersControllerTest < ActionController::TestCase
  def setup
    @site = MomentumCms::Site.first
    @user = momentum_cms_users(:default)
    @user.password = 'passpass'
    @user.password_confirmation = 'passpass'
    @user.save!
    @user.reload
  end

  def test_unauthenticated
    get :index, site_id: @site

    assert_redirected_to cms_admin_login_path

    get :edit, site_id: @site, id: @user

    assert_redirected_to cms_admin_login_path
  end

  def test_index
    login_user(@user)

    get :index, site_id: @site

    assert assigns(:momentum_cms_users)
  end

  def test_create
    login_user(@user)

    assert_difference 'MomentumCms::User.count' do
      post :create, site_id: @site, momentum_cms_user: {
        email: 'user@test.domain',
        password: 'passpass',
        password_confirmation: 'passpass'
      }
    end
  end

  def test_create_invalid
    login_user(@user)

    assert_no_difference 'MomentumCms::User.count' do
      post :create, site_id: @site, momentum_cms_user: {
        email: 'user@test.domain',
        password: 'passpass',
      }
    end
  end

  def test_activate
    login_user(@user)
    @user = MomentumCms::User.create(email: 'user2@test.domain',
                                     password: 'passpass',
                                     password_confirmation: 'passpass')
    @user.reload
    assert_equal @user.activation_state, 'pending'

    get :activate, id: 0
    assert_redirected_to cms_admin_login_path

    get :activate, id: @user.activation_token
    assert_redirected_to cms_admin_login_path
  end

  def test_update
    login_user(@user)

    email = 'new@test.domain'

    put :update, site_id: @site, id: @user, momentum_cms_user: {
      email: email,
      password: 'passpass',
      password_confirmation: 'passpass'
    }

    @user.reload
    assert_equal email, @user.email
  end

  def test_update_invalid
    login_user(@user)

    email = 'new@test.domain'

    put :update, site_id: @site, id: @user, momentum_cms_user: {
      email: email,
      password: 'passpass',
    }

    @user.reload
    refute_equal email, @user.email
  end

  def test_destroy
    login_user(@user)
    assert_difference 'MomentumCms::User.count', -1 do
      delete :destroy, site_id: @site, id: @user
    end
  end

  def test_destroy_invalid
    login_user(@user)
    assert_no_difference 'MomentumCms::User.count' do
      delete :destroy, site_id: @site, id: 0
    end
  end

end
