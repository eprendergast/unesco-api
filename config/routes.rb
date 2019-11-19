Rails.application.routes.draw do

  get '/sites', to: 'sites#index'
  get '/sites/:id', to: 'sites#show'
  get '/sites/search/:query', to: 'sites#search'

end
