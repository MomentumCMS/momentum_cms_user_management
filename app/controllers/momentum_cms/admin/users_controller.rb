class MomentumCms::Admin::UsersController < MomentumCms::Admin::UserManagementBaseController
  skip_before_filter :load_site, only: [:activate]
  skip_before_filter :require_login, only: [:activate]

  before_action :load_moment_cms_user, only: [:edit, :update, :destroy]
  before_action :build_moment_cms_user, only: [:new, :create]

  def index
    @momentum_cms_users = MomentumCms::MomentumCms::User.all
  end

  def new
  end

  def edit
  end

  def create
    @momentum_cms_user.save!
    flash[:success] = 'User was successfully created.'
    redirect_to action: :edit, :id => @momentum_cms_user
  rescue ActiveRecord::RecordInvalid
    render action: :new
  end

  def update
    @momentum_cms_user.update_attributes!(momentum_cms_user_params)
    flash[:success] = 'User was successfully updated.'
    redirect_to action: :edit, :id => @momentum_cms_user
  rescue ActiveRecord::RecordInvalid
    render action: :edit
  end

  def destroy
    @momentum_cms_user.destroy
    flash[:success] = 'User was successfully destroyed.'
    redirect_to action: :index
  end

  def activate
    if (@momentum_cms_user = MomentumCms::User.load_from_activation_token(params[:id]))
      @momentum_cms_user.activate!

      flash[:success] = 'User was successfully activated.'
      redirect_to cms_admin_login_path
    else
      not_authenticated
    end
  end

  private
  def load_moment_cms_user
    @momentum_cms_user = MomentumCms::MomentumCms::User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to action: :index
  end

  def build_moment_cms_user
    @momentum_cms_user = MomentumCms::MomentumCms::User.new(momentum_cms_user_params)
  end

  def momentum_cms_user_params
    params.fetch(:momentum_cms_user, {}).permit(:email, :password, :password_confirmation)
  end

end
