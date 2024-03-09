Rails.application.routes.draw do
  # 会員用
  devise_for :members, skip: [:passwords], controllers: 
  {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers:
  {
    sessions: "admin/sessions"
  }
  
  scope module: :public do
    root to: "homes#top"
    
    get '/canned_foods/search' => 'canned_foods#search'
    resources :canned_foods, only: [:index, :show]
    
    get '/members/my_page' => 'members#index'
    get '/members/information/edit' => 'members#edit'
    patch '/members/information' => 'members#update'
    get '/members/unsubscribe' => 'members#unsubscribe'
    patch '/members/withdraw' => 'members#withdraw'
    get '/members/:member_id' => 'members#show'
    
    post '/members/:member_id/relationships' => 'relationships#create'
    delete '/members/:member_id/relationships' => 'relationships#destroy'
    get '/members/:member_id/followings' => 'relationships#followings', as: "followings"
    get '/members/:member_id/followers' => 'relationships#followers', as: "followers"
    get '/members/followers' => 'relationships#index'
    
    get '/members/:member_id/reviews' => 'reviews#show'
    resources :reviews, only: [:index, :create, :destroy]
    
    post '/reviews/:review_id/comments' => 'comments#create'
    get '/reviews/:review_id/comments' => 'comments#index'
    delete '/reviews/:review_id/comments/:id' => 'comments#destroy'
    
    resources :favorites, only: [:index, :create, :destroy]
  end
  
  namespace :admin do
    get '/canned_foods/search' => 'canned_foods/search'
    resources :canned_foods, only: [:index, :new, :create, :show, :edit, :update]
    
    resources :members, only: [:index, :show, :edit, :update]
    
    resources :reviews, only: [:index, :destroy]
    
    get '/reviews/:review_id/comments' => 'comments#index'
    delete '/reviews/:review_id/comments/:id' => 'comments#destroy'
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
