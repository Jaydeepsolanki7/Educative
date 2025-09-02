Rails.application.routes.draw do
  root "explore#index"
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  devise_for :users
  resources :products
  resources :courses do
    collection do
      get :search
    end
  end
  resources :assessments
end
