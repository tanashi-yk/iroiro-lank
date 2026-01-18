class CompetitionsController < ApplicationController
  def create
    count = Competition.count + 1
    @competition = Competition.create!(name: "第#{count}回イベント")
    # 修正：作成した大会のIDをURLに含めて一覧へ飛ばす
    redirect_to predictions_path(competition_id: @competition.id)
  end

  # --- edit, update は以前のままでOK ---
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
end