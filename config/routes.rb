Rails.application.routes.draw do
  if MomentumCms.configuration.admin_panel_style == :html5
    namespace :momentum_cms, as: :cms, path: MomentumCms.configuration.admin_panel_mount_point do
      namespace :admin, as: :admin, except: :show, path: '' do
        resources :password_resets, only: [:new, :create, :edit, :update]
        resources :sessions, only: [:new, :create, :destroy]
        get 'login' => 'sessions#new', :as => :login
        get 'logout' => 'sessions#destroy', :as => :logout
        resources :users, only: [] do
          member do
            get :activate
          end
        end
        resources :sites do
          resources :users
        end
      end
    end
  end
end