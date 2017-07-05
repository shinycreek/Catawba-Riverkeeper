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
      resources :user_settings, only: [:create] do
        collection do
          post 'show'
          put 'update'
        end
      end
      resources :trash_loggers, only: [:create]
    end
  end

end
