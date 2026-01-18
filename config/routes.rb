Rails.application.routes.draw do
  root 'pages#top'

  # すべての機能をフルオープンにします（onlyなどをつけない）
  resources :predictions
  resources :competitions

  get 'top', to: 'pages#top'
end