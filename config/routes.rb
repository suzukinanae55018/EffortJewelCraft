Rails.application.routes.draw do
  namespace :admin do
    get "diary_records/index"
    get "diary_records/destroy"
  end
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  get "admin" => "admin/homes#top"
  namespace :admin do
    resources :users, only: [:index, :show, :destroy]
    resources :groups, only: [:index, :destroy]
    resources :diary_records, only: [:index, :destroy] do
      resources :diary_record_comments, only: [:index, :destroy]
    end
  end

  root to: "public/homes#top"
  get "about", to: "public/homes#about", as: "about"
  get "policies", to: "public/policies#index", as: "policies"
  get "my_groups", to: "public/groups#my_groups", as: "my_groups"
  get "join_groups", to: "public/groups#join_groups", as: "join_groups"

  scope module: :public do
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      member do
        get :favorites
      end
    end

    resources :diary_records, only: [:new, :create, :index, :show, :edit, :destroy, :update] do
      resources :diary_record_comments, only: [:create, :destroy]
      resource :favorite, only: [:create, :destroy]
    end

    resources :groups, only: [:new, :create, :index, :show, :edit, :destroy, :update]  do
      resource :permits, only: [:create, :destroy]
      resource :group_users, only: [:create, :destroy] do
        member do
          delete "decline", as: :decline
        end
      end
    end

    devise_scope :user do
      post "users/guest_sign_in", to: "sessions#guest_sign_in"
    end
    get "search" => "searches#search"
    get "group_search" => "searches#group_search"
    get "groups/:id/permits" => "groups#permits", as: :permits
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
end
