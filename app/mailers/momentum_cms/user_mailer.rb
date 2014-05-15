class MomentumCms::UserMailer < ActionMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.momentum_cms.user_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
    @user = user
    @url = edit_cms_admin_password_reset_url(user.reset_password_token)
    mail(:to => user.email,
         :subject => "Your password has been reset")
  end


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.momentum_cms.user_mailer.activation_needed_email.subject
  #
  def activation_needed_email(user)
    @user = user
    @url = activate_cms_admin_user_url(user.activation_token)
    mail(:to => user.email,
         :subject => "Welcome to My Awesome Site")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.momentum_cms.user_mailer.activation_success_email.subject
  #
  def activation_success_email(user)
    @user = user
    @url = cms_admin_login_url
    mail(:to => user.email,
         :subject => "Your account is now activated")
  end
end
