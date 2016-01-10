Rails.application.routes.draw do
  resources :wines

  # Necessary to be able to create Models associated with Wine
  resources :regions, except: [:update, :edit]
  resources :appellations, except: [:update, :edit]
  resources :vineyards, except: [:update, :edit]
  resources :varietals, except: [:update, :edit]
end
