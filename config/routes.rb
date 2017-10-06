Rails.application.routes.draw do
  devise_for :users, :controllers => { :invitations => 'invitations' , 
                                  :omniauth_callbacks => 'my_devise/omniauth_callbacks'}
  

  scope "/admin" do
    resources :users do
      member do
        patch 'toggle'
      end
    end
  end
  
  resources :roles
  
  resources :groups do
    resources :posts do
      resources :comments do
        resources :comments
      end
    end
  end

  resources :events, only: [:show]
  
  
  authenticated :user do
    root :to => 'groups#index', as: :authenticated_root
  end

  root to: "welcome#index"
  get "welcome/show"

end
