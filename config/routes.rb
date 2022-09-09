Rails.application.routes.draw do
  
  resources :todos 

  get "find_by_tag" , to: "todos#find_by_tag"
  
end
