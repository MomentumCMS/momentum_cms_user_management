class MomentumCms::Admin::UserManagementBaseController < MomentumCms::Admin::BaseController
  layout :set_layout

  protected
  def set_layout
    if logged_in?
      'momentum_cms/admin/application'
    else
      'momentum_cms/admin/application_guest'
    end
  end
end
