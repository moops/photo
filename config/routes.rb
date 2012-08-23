Photo::Application.routes.draw do
  resource :photo_comments
  
  resource :galleries do
    resource :photos do 
      collection do
        post :remove, :add
      end
    end
  end

  root :to => 'galleries#index'
end
