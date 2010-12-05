Blog::Application.routes.draw do

  # resources :posts

  match "/:year/:month/:slug" => "posts#show", :constraints => { :year => /\d{4}/, :month => /\d{2}/ }
  match "/:year(/:month)" => "posts#index", :constraints => { :year => /\d{4}/, :month => /\d{2}/ }

  root :to => 'posts#index'
end
