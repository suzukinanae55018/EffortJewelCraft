Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  get 'admin' => 'admin/homes#top'
    namespace :admin do
      resources :users, only: [:index, :show, :edit, :update, :destroy]
      resources :groups, only: [:index, :destroy]
      resources :diary_record_comments, only: [:index, :destroy]
    end
    
  root to: 'public/homes#top'
  get 'about', to: 'public/homes#about', as: 'about'
  get 'policies', to: 'public/policies#index', as: 'policies'

  scope module: :public do
    resources :users, only: [:index, :show, :edit, :update, :destroy]

    resources :diary_records, only: [:new, :create, :index, :show, :edit, :destroy, :update] do
      resources :diary_record_comments, only: [:create, :destroy]
        resource :favorite, only: [:create, :destroy]
  end

    resources :groups, only: [:new, :create, :index, :show, :edit, :destroy, :update]  do
      resources :group_users, only: [:create, :destroy]
  end


  get '/search' => 'public/searches#search'
  get '/tag_search' => 'public/tag_searches#tag_search'

  devise_scope :user do
      post "users/guest_sign_in", to: "public/users/sessions#guest_sign_in"
    end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
end