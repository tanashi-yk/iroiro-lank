class CompetitionsController < ApplicationController
  def edit
    @competition = Competition.find(params[:id])
  end

  def update
    @competition = Competition.find(params[:id])
    
    # フォームから送られてくるデータは {"0"=>"#FF0000", "1"=>"#0000FF", ...} という形
    raw_colors = params[:competition][:answer_colors]
    
    if raw_colors.present?
      # 0から5までのキーを順番に取得して、綺麗な配列 ["#FF0000", "#0000FF", ...] に変換
      formatted_colors = (0..5).map { |i| raw_colors[i.to_s] }
      
      if @competition.update(answer_colors: formatted_colors)
        # 保存に成功したら、みんなの予想一覧（Index）へ戻る
        redirect_to predictions_path, notice: "正解を更新しました！"
      else
        render :edit, status: :unprocessable_entity
      end
    else
      # 何も選ばれなかった場合など
      render :edit, status: :unprocessable_entity
    end
  end
end