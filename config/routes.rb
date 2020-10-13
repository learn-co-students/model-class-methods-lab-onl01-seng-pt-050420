Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :boats, only: %w(index show create edit  new update destroy)
end
