Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/auth", to: "authentications#create"
      resources :folders, only: %i[index create destroy]
      resources :bookmarks, only: %i[index create destroy]

      get '/health_check', to: "health_check#index"
    end
  end
end
