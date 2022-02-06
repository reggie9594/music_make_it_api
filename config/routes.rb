Rails.application.routes.draw do
  get 'customers/create'
  get 'product_categories/create'
  get 'sales/create'

  #Product endpints
  post 'products/create'
  get 'products/products'

  # Users endpoints
  post 'users/create';
  get 'users/users';
  get 'users/login';
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
