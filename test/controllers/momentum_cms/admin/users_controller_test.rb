require_relative '../../../test_helper'

class MomentumCms::Admin::UsersControllerTest < ActionController::TestCase
  def setup
    @site = MomentumCms::Site.first
    @user = momentum_cms_users(:default)
    login_user(@user)
  end

  def test_index
    get :index, site_id: @site
    
    assert assigns(:momentum_cms_users)
  end
end
