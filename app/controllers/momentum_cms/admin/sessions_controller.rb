class MomentumCms::Admin::SessionsController < MomentumCms::Admin::UserManagementBaseController
  before_action :redirect_if_logged_in, except: [:destroy]
  skip_before_filter :require_login, only: [:new, :create]
  skip_before_filter :require_login, except: [:destroy]
  before_action :build_moment_cms_user, only: [:new, :create]

  def new
  end

  def create
    momentum_cms_user = params.fetch(:momentum_cms_user, nil)
    username = momentum_cms_user.fetch(:email, nil)
    password = momentum_cms_user.fetch(:password, nil)

    if username.blank? || password.blank?
      flash[:warning] = 'Login failed'

      render action: :new and return
    end

    if @momentum_cms_user = login(username, password)
      flash[:success] = 'Logged successful!'
      redirect_back_or_to(cms_admin_root_path)
    else
      flash[:warning] = 'Login failed'
      render action: :new
    end
  end

  def destroy
    logout
    flash[:success] = 'Logged out!'

    redirect_to cms_admin_root_path
  end

  private
  def build_moment_cms_user
    @momentum_cms_user = MomentumCms::User.new
  end

  def redirect_if_logged_in
    if logged_in?
      redirect_to cms_admin_root_path
    end
  end
end