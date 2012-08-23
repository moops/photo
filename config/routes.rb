Photos::Application.routes.draw do
  resources :photo_comments
  
  resources :galleries do
    resources :photos do 
      collection do
        post :remove, :add
      end
    end
  end

  root :to => 'galleries#index'
end
