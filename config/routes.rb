Rails.application.routes.draw do

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  resources :users
  resources :sessions

  resources :galleries, shallow: true do
    resources :photos do
      resources :comments
    end
  end

  # resources :photos do
  #   collection do
  #     post :remove, :add
  #   end
  #   resources :comments
  # end

  # resources :comments

  # match 'photos/update_field/:id/:field' => 'photos#update_field', :as => :caption
  post 'photos/increment'

  root to: 'galleries#index'
end
