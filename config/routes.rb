Photos::Application.routes.draw do
  root :to => 'galleries#index'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  resources :users
  resources :sessions

  
  resources :galleries do
    resources :photos, :name_prefix => "gallery_"
  end

  resources :photos do
    collection do
      post :remove, :add
    end
    resources :comments, :name_prefix => "photop_"
  end

  resources :comments

  match 'photos/update_field/:id/:field' => 'photos#update_field', :as => :caption
  post 'photos/increment'
end
