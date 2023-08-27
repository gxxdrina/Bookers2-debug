Rails.application.routes.draw do
  get 'chats/show'
  devise_for :users
  
  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]# resource(単数)だとURLにidが入らない
    resources :book_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  #検索ボタンが押されたらSearchesコントローラーのsearchアクション実行
  get "search" => "searches#search"
  
  resources :chats, only: [:show, :create]
end

