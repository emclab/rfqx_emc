RfqxEmc::Engine.routes.draw do

  mount ProductxEmcIt::Engine => "/productx_emc_it"  #, :as => "authentify_engine"
  mount Authentify::Engine => "/authentify"  #, :as => "authentify_engine"
  
  resources :rfqs
  resources :categories
  
  #root :to => 'rfqs#index'
  root :to => 'categories#index'
  #match '/signin',  :to => 'authentify/sessions#new'
  
  match '/view_handler', :to => 'self.class.helpers.authentify_utility#view_handler'
end
