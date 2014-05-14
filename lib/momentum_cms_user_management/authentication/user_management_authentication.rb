module MomentumCmsUserManagement
  module Authentication
    module UserManagementAuthentication
      extend ActiveSupport::Concern

      included do
        before_action :require_login


        def not_authenticated
          redirect_to cms_admin_login_path
        end
      end

      def authenticate
      end

    end
  end
end