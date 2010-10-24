Snipet::Application.routes.draw do
  devise_for :users

  root :to => "snippets#index"
  get "snippets/mine" => 'snippets#mine'
  get 'languages',:controller => "languages", :action => "index"
  get "tags/(index)", :controller => "tags", :action => "index"
  resources :snippets  
end
