Rails.application.routes.draw do
  resources :wines

  resources :regions, except: [:update, :edit]
end
