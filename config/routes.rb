Rails.application.routes.draw do
  namespace :admin do
    get 'groups/index'
    get 'groups/destroy'
  end
  namespace :admin do
    get 'diary_record_comments/index'
    get 'diary_record_comments/destroy'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'users/destroy'
    get 'users/update'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'group_users/create'
    get 'group_users/destroy'
  end
  namespace :public do
    get 'groups/new'
    get 'groups/create'
    get 'groups/index'
    get 'groups/show'
    get 'groups/edit'
    get 'groups/update'
    get 'groups/destroy'
  end
  namespace :public do
    get 'favorites/create'
    get 'favorites/destroy'
  end
  namespace :public do
    get 'diary_record_comments/create'
    get 'diary_record_comments/destroy'
  end
  namespace :public do
    get 'diary_records/new'
    get 'diary_records/create'
    get 'diary_records/index'
    get 'diary_records/show'
    get 'diary_records/edit'
    get 'diary_records/update'
    get 'diary_records/destroy'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/update'
    get 'users/destroy'
    get 'users/index'
  end
  namespace :public do
    get 'policies/index'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
