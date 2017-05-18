Rails.application.routes.draw do
  
  get "/signup" => "users#new"
  post "/users" => "users#create"
  get "users/:id/spend" => "users#spend"
  get "/users/:id" => "users#show"
  patch "/users/:id" => "users#update"

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  post "entries" => "entries#create"

  post "points" => "points#create"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
