class PagesController < ApplicationController
  def top
    # データベースにあるイベント（大会）をすべて取得して、トップ画面のボタンにします
    @competitions = Competition.all
    
    # もし大会が一つもなければ、デフォで作る（動作確認用）
    if @competitions.empty?
      Competition.create!(name: "第1回 色いろ順位決定戦")
      @competitions = Competition.all
    end
  end
end