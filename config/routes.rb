Rails.application.routes.draw do
  root "pokemon#index"
  resources :pokemon, only: [:show]
  resources :elemental_types, path: "types", only: [:index, :show]
  get "about", to: "pages#about"
end
