Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end

  resources :pages  
  # In plain English you could read this as, get requests for the /pages path should go to the PagesController's index method.
#  get '/pages', to: 'pages#index'

#  post '/pages', to: 'pages#create'

#  get '/pages/new', to: 'pages#new', as: 'new_page'

#  get '/pages/:id', to: 'pages#show', as: 'page'

#  get '/pages/:id/edit', to: 'pages#edit', as: 'edit_page'

#  patch 'pages/:id', to: 'pages#update'

#  delete 'pages/:id', to: 'pages#delete',as

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
