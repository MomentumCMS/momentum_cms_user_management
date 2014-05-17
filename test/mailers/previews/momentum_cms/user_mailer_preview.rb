# Preview all emails at http://localhost:3000/rails/mailers/momentum_cms/user_mailer
class MomentumCms::UserMailerPreview < ActionMailer::Preview

  def setup
    @user = momentum_cms_users(:default)
  end

  # Preview this email at http://localhost:3000/rails/mailers/momentum_cms/user_mailer/reset_password_email
  def reset_password_email
    MomentumCms::UserMailer.reset_password_email(@user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/momentum_cms/user_mailerz/activation_needed_email
  def activation_needed_email
    MomentumCms::UserMailerz.activation_needed_email(@user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/momentum_cms/user_mailerz/activation_success_email
  def activation_success_email
    MomentumCms::UserMailerz.activation_success_email(@user)
  end

end
