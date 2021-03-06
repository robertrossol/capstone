Rails.application.routes.draw do
  
  get "/users/:id" => "users#show"
  get "/signup" => "users#new"
  get "/users" => "users#index"
  post "/users" => "users#create"
  patch "/users/:id" => "users#update"
  get "users/:id/spend" => "users#spend"



  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  post "entries" => "entries#create"

  post "points" => "points#create"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
