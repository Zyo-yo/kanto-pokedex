Rails.application.routes.draw do
  root "pokemon#index"
  resources :pokemon, only: [:show] do
    get :map, action: :encounter_map, on: :member
  end
  resources :elemental_types, path: "types", only: [:index, :show]
  get "about", to: "pages#about"
end
