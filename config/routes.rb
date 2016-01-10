Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :wines, except: [:new, :edit]
    end
  end

  resources :wines

  # Necessary to be able to create Models associated with Wine
  resources :regions, except: [:update, :edit]
  resources :appellations, except: [:update, :edit]
  resources :vineyards, except: [:update, :edit]
  resources :varietals, except: [:update, :edit]
  resources :wine_types, except: [:update, :edit]
end
