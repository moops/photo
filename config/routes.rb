Photos::Application.routes.draw do
  root :to => 'galleries#index'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  resources :users
  resources :sessions
  resources :photo_comments
  
  resources :galleries do
    resources :photos do 
      collection do
        post :remove, :add
      end
    end
  end

  match 'photos/update_field/:id/:field' => 'photos#update_field', :as => :caption
end
