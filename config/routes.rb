Rails.application.routes.draw do
  root to: "homes#top"
  
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
