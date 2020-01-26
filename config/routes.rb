Rails.application.routes.draw do

  get '/sites', to: 'sites#index'
  get '/sites/:id', to: 'sites#show'
  get '/sites/search/:query', to: 'sites#search'

  get '/categories', to: 'categories#index'

  get '/regions', to: 'regions#index'

  get '/states', to: 'states#index'

  get '/iso_codes', to: 'iso_codes#index'

end
