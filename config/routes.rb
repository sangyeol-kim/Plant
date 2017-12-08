Rails.application.routes.draw do
  root "home#index"
  
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  
  devise_for :users
  
  #devise_for :users로 인해 별도의 라우터 설정 필요 171012 상열
  resources :users, :only => [:show]
  
  get "/flowers/haemaria"
  get "/flowers/stuckyi"
  get "/flowers/tillandsia"
  
end
