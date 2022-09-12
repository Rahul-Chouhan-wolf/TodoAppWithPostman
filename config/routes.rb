Rails.application.routes.draw do
  
  resource :todos 

  get "find_by_tag" , to: "todos#find_by_tag"
  
  get 'show_all' , to: 'todos#show_all'

  get "undo_id" , to: 'todos#undo_id'
end
