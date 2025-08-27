Rails.application.routes.draw do
  root "explore#index"
  devise_for :users
  resources :products
  resources :courses do
    collection do
      get :search
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
