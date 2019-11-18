Rails.application.routes.draw do
  resources :site_iso_codes
  resources :site_states
  resources :sites
  resources :iso_codes
  resources :states
  resources :categories
  resources :regions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
