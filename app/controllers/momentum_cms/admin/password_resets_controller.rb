class MomentumCms::Admin::PasswordResetsController < MomentumCms::Admin::UserManagementBaseController
  skip_before_filter :require_login

  before_action :build_moment_cms_user, only: [:new, :create]

  def new
  end

  # request password reset.
  # you get here when the user entered his email in the reset password form and submitted it.
  def create
    @momentum_cms_user = MomentumCms::User.where(email: params[:momentum_cms_user][:email]).first

    # This line sends an email to the user with instructions on how to reset their password (a url with a random token)
    @momentum_cms_user.deliver_reset_password_instructions! if @momentum_cms_user

    # Tell the user instructions have been sent whether or not email was found.
    # This is to not leak information to attackers about which emails exist in the system.
    flash[:success] = 'Instructions have been sent to your email.'
    redirect_to cms_admin_root_path
  end

  # This is the reset password form.
  def edit
    @momentum_cms_user = MomentumCms::User.load_from_reset_password_token(params[:id])
    @token = params[:id]

    if @momentum_cms_user.blank?
      not_authenticated
      return
    end
  end

  # This action fires when the user has sent the reset password form.
  def update
    @token = params.fetch(:momentum_cms_user, {}).fetch(:token, nil)

    @momentum_cms_user = MomentumCms::User.load_from_reset_password_token(@token)

    if @momentum_cms_user.blank?
      not_authenticated
      return
    end

    # the next line makes the password confirmation validation work
    @momentum_cms_user.password_confirmation = params.fetch(:momentum_cms_user, {}).fetch(:password_confirmation, nil)
    # the next line clears the temporary token and updates the password
    if @momentum_cms_user.change_password!(params.fetch(:momentum_cms_user, {}).fetch(:password, nil))
      flash[:success] = 'Password was successfully updated.'
      redirect_to cms_admin_root_path
    else
      render action: :edit
    end
  end

  private
  def build_moment_cms_user
    @momentum_cms_user = MomentumCms::User.new
  end
end
