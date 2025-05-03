Rails.application.routes.draw do
  resources :flash_quizzes, only: [:index, :show, :edit]
  resources :posts
  resource :tech_support_prompt, only: [:show]

  resources :contacts, only: [:index]
  resources :products, only: [:index]
  resources :flash_sales, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
