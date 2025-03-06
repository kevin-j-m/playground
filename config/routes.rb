Rails.application.routes.draw do
  resources :flash_quizzes, only: [:index, :show, :edit]
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
