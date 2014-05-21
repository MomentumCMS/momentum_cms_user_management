require 'momentum_cms_user_management/engine'
require 'momentum_cms_user_management/authentication/user_management_authentication'

module MomentumCmsUserManagement
  class <<self
    MomentumCms::Service::ViewHookStore.get_view_hook(:admin_left_menu).register(:user_management, 'momentum_cms/admin/partials/user_management_left_side_bar')
  end
end