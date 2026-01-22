class CompetitionsController < ApplicationController
  def create
    # 1. フォームから送られてきた名前を受け取れるようにする
    # 2. 名前が空だった場合のみ「第○回イベント」をデフォルトにする
    count = Competition.count + 1
    name = competition_params[:name].presence || "第#{count}回イベント"
    
    @competition = Competition.new(competition_params)
    @competition.name = name
    
    if @competition.save
      redirect_to predictions_path(competition_id: @competition.id)
    else
      # 失敗した場合はTOPへ戻す
      redirect_to root_path, alert: "作成に失敗しました"
    end
  end

  def edit
    @competition = Competition.find(params[:id])
  end

  def update
    @competition = Competition.find(params[:id])
    raw_colors = params[:competition][:answer_colors]
    if raw_colors.present?
      formatted_colors = (0..5).map { |i| raw_colors[i.to_s] }
      if @competition.update(answer_colors: formatted_colors)
        redirect_to predictions_path(competition_id: @competition.id), notice: "正解を更新しました！"
      else
        render :edit
      end
    end
  end

  def destroy
    @competition = Competition.find(params[:id])
    @competition.destroy
    # 削除が終わったらトップページに戻る
    redirect_to root_path, notice: "イベントを削除しました"
  end

  private

  # ここが超重要！ :name を受け取れるように許可します
  def competition_params
    params.require(:competition).permit(:name, :answer_colors)
  end
end