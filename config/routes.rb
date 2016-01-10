Rails.application.routes.draw do
  # API
  namespace :api do
    namespace :v1 do
      resources :wines, except: [:new, :edit]
      resources :regions, except: [:new, :edit]
      resources :appellations, except: [:new, :edit]
      resources :vineyards, except: [:new, :edit]
      resources :varietals, except: [:new, :edit]
      resources :wine_types, except: [:new, :edit]
    end
  end

  resources :wines
  resources :regions, except: [:update, :edit]
  resources :appellations, except: [:update, :edit]
  resources :vineyards, except: [:update, :edit]
  resources :varietals, except: [:update, :edit]
  resources :wine_types, except: [:update, :edit]
end
