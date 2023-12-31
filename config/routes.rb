Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :genres, only: %i[index show create update destroy]
      resources :authors, only: %i[index show create update destroy]
      resources :books, only: %i[index show create update destroy] do
        collection do
          post 'search', to: 'books#search'
        end
      end
    end
  end
end
