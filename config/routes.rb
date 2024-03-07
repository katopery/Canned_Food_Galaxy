Rails.application.routes.draw do
  namespace :admin do
    get 'comments/index'
    delete 'comments/destroy'
  end
  namespace :admin do
    get 'reviews/index'
    delete 'reviews/destroy'
  end
  namespace :admin do
    get 'members/index'
    get 'members/show'
    get 'members/edit'
    patch 'members/update'
  end
  namespace :admin do
    get 'canned_foods/index'
    get 'canned_foods/new'
    post 'canned_foods/create'
    get 'canned_foods/show'
    get 'canned_foods/edit'
    get 'canned_foods/search'
    patch 'canned_foods/update'
  end
  namespace :public do
    post 'favorites/create'
    get 'favorites/index'
    delete 'favorites/destroy'
  end
  namespace :public do
    post 'comments/create'
    get 'comments/index'
    delete 'comments/destroy'
  end
  namespace :public do
    get 'reviews/index'
    get 'reviews/show'
    post 'reviews/create'
    delete 'reviews/destroy'
  end
  namespace :public do
    post 'relationships/create'
    delete 'relationships/destroy'
    get 'relationships/followings'
    get 'relationships/followers'
    get 'relationships/index'
  end
  namespace :public do
    get 'members/index'
    get 'members/edit'
    patch 'members/update'
    get 'members/show'
    get 'members/unsubscribe'
    patch 'members/withdraw'
  end
  namespace :public do
    get 'canned_foods/index'
    get 'canned_foods/search'
    get 'canned_foods/show'
  end
  scope module: :public do
    root to: "homes#top"
  end
  
  #会員用
  devise_for :members, skip: [:passwords], controllers: 
  {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  
  devise_for :admin, skip: [:registrations, :passwords], controllers:
  {
    sessions: "admin/sessions"
  }


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
