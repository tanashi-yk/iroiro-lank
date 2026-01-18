class PredictionsController < ApplicationController
  def index
    # URLの competition_id を優先し、なければ最新の大会を表示
    @competition = Competition.find_by(id: params[:competition_id]) || Competition.last
    
    if @competition
      # その大会に紐づく予想だけを取得
      @predictions = @competition.predictions.includes(:ranking_items)
    else
      @competition = Competition.create!(name: "第1回イベント")
      @predictions = []
    end
  end

  def new
    @competition = Competition.find(params[:competition_id])
    @prediction = @competition.predictions.build
    6.times { @prediction.ranking_items.build }
  end

  def create
    # フォームから送られた competition_id を使って保存先を固定
    @competition = Competition.find(params[:prediction][:competition_id])
    @prediction = @competition.predictions.build(prediction_params)

    if @prediction.save
      # 保存後、その大会のIDをURLに付けてリダイレクト（これが連動を防ぐコツ）
      redirect_to predictions_path(competition_id: @competition.id), notice: "予想を保存しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @prediction = Prediction.find(params[:id])
    comp_id = @prediction.competition_id
    @prediction.destroy
    redirect_to predictions_path(competition_id: comp_id), notice: "予想を削除しました"
  end

  private

  def prediction_params
    # :competition_id の許可が必須です
    params.require(:prediction).permit(:name, :competition_id, ranking_items_attributes: [:id, :color_code, :rank, :_destroy])
  end
end