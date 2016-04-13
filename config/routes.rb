Rails.application.routes.draw do

  root :to => 'home#index', as: 'home'
  get '/dashboard' => 'dashboard#index'

  resources :cities
  resources :companies
  resources :contract_changes
  resources :contracts
  resources :f_contracts
  resources :i_contracts
  resources :party_as
  resources :party_bs
  resources :stations
  resources :users

  controller :sessions do
    post 'login' => :create
    delete 'logout' => :destroy
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      
      post  'login'                    => 'sessions#create'

      # contracts routes
      post  'contracts'                => 'contracts#create'
      patch 'contracts/:contract_no'   => 'contracts#modify_contract'

      post  'contracts/:contract_no/transform' => 'contracts#signing_formal_contract'
      get   'contracts'                => 'contracts#list_contracts'

      get   'contracts/:contract_no'   => 'contracts#show'
      delete 'contracts/:id'           => 'contracts#destroy'
      
      # List cities
      get   'cities'                   => 'cities#index'
      get   'cities/:id/companies'     => 'cities#list_companies'

      # List changes of all contracts
      get   'contract_changes'                    => 'contract_changes#index'

      # Version
      get   'versions/last'            => 'versions#show'

      # Analysis
      get    'analysis/contracts'      => 'analysis#contracts'
    end
  end

end
