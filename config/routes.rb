Rails.application.routes.draw do
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  resources :users
  resources :sessions

  resources :galleries, shallow: true do
    get 'count', on: :member
    resources :photos do
      collection do
        put 'bulkupdate'
      end
      resources :comments
    end
  end

  # match 'photos/update_field/:id/:field' => 'photos#update_field', :as => :caption
  post 'photos/increment'

  root to: 'galleries#index'
end
