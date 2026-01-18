Rails.application.routes.draw do
  # 個別の get ... などをすべて消して、これ一行にします
  resources :predictions

  # 動作確認用（残しておいてOK）
  get "up" => "rails/health#show", as: :rails_health_check
end