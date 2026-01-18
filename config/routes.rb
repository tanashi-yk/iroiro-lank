Rails.application.routes.draw do
  # アプリのトップページを pages コントローラーの top アクションに設定
  root 'pages#top'

  # 予想（Predictions）に関するすべてのルート
  resources :predictions do
    collection do
      # 必要に応じて後で「正解入力画面」などを追加する場所
    end
  end

  # イベント（Competitions）に関するルート
  resources :competitions, only: [:index, :show]
end