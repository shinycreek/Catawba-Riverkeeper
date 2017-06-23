Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  namespace :api do
    namespace :v1 do
      resources :websites, only: [] do
        collection do
          get 'basin_map'
          get 'crf'
        end
      end
      resources :user_settings, only: [] do
        collection do
          post 'show'
          post 'setting'
        end
      end
    end
  end

end
