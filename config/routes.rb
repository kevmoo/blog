Blog::Application.routes.draw do

  resources :posts do
    collection do
      get 'new/scratch', :action => 'new_scratch'
      get 'scratch', :action => 'scratch'
    end
  end

  match ':year(/:month)', :controller => 'posts', :action => 'index', :constraints => { :year => /\d+/, :month => /\d{1,2}/ }

  root :to => 'posts#index'

end
