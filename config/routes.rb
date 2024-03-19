Rails.application.routes.draw do
  # 会員用
  devise_for :members, skip: [:passwords], controllers: 
  {
    registrations: "public/registrations",
    sessions: 'public/sessions',
    passwords: 'public/passwords'
  }
  
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers:
  {
    sessions: "admin/sessions"
  }
  
  # ゲストログイン用
  devise_scope :member do
    post 'members/guest_sign_in', to: 'public/sessions#guest_sign_in', as: "members_guest_sign_in"
  end
  
  scope module: :public do
    root to: "homes#top"
    
    get '/canned_foods/search' => 'canned_foods#search'
    get "/canned_foods/search_tag" => "canned_foods#search_tag"
    resources :canned_foods, only: [:index, :show]do
      resources :reviews, only: [:index]
    end
    
    get '/members/my_page' => 'members#index'
    get '/members/information/edit' => 'members#edit'
    patch '/members/information' => 'members#update'
    get '/members/unsubscribe' => 'members#unsubscribe'
    patch '/members/withdraw' => 'members#withdraw'
    resources :members, only: [:show] do
      resource :relationships, only: [:create, :destroy]
    	get "followings" => "relationships#followings", as: "followings"
    	get "followers" => "relationships#followers", as: "followers"
    end
    
    resources :reviews, only: [:create, :update, :destroy] do
      resources :comments, only: [:create, :index, :destroy]
    end
    
    resources :favorites, only: [:index, :create, :destroy]
  end
  
  namespace :admin do
    resources :canned_foods, only: [:index, :new, :create, :show, :edit, :update] do
      resources :reviews, only: [:index]
    end
    
    resources :members, only: [:index, :show, :edit, :update] 
    
    get '/members/:member_id/reviews' => 'reviews#show', as: "reviews_member"
    resources :reviews, only: [:destroy] do
      resources :comments, only: [:index, :destroy]
    end
    
    get "search" => "searches#search"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
