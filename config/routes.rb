Rails.application.routes.draw do
  root "explore#index"
  devise_for :users
  resources :products
  resources :courses

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
