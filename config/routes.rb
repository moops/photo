Photos::Application.routes.draw do
  resources :photo_comments
  
  resources :galleries do
    resources :photos do 
      collection do
        post :remove, :add
      end
    end
  end

  match 'photos/update_field/:id/:field' => 'photos#update_field', :as => :caption
  
  root :to => 'galleries#index'
end
