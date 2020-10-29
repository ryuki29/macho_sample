Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: :create
    # ネストする理由は、お気に入り時にforeign_keyの一つであるpost_idを取得するのが楽になるから(foreign_keyを取得しないとリレーションができない)
    # favoriteの詳細ページは作らない、つまりfaboriteのidは要らず省略したいため、resourceと、単数系のメソッドを利用している
    collection do
      get 'search'
    end
  end
  resources :users, only: :show
  resources :relationships, only: [:create, :destroy]
end