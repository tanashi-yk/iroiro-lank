class PredictionsController < ApplicationController
  def index
    # 最新の大会を取得し、ボタンのリンク先や正答判定に使う
    @competition = Competition.last
    
    if @competition
      # 大会に紐づく予想を取得
      @predictions = @competition.predictions.includes(:ranking_items)
    else
      # 大会が一つもない場合、エラー回避のために作成
      @competition = Competition.create!(name: "第1回大会")
      @predictions = []
    end
  end

  def new
    @prediction = Prediction.new
    6.times { @prediction.ranking_items.build }
  end

  def create
    @prediction = Prediction.new(prediction_params)
    # 最初の大会に紐づける
    @prediction.competition = Competition.first || Competition.create!(name: "第1回大会")

    if @prediction.save
      redirect_to predictions_path, notice: "予想を保存しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @prediction = Prediction.find(params[:id])
    @prediction.destroy
    redirect_to predictions_path, notice: "予想を削除しました"
  end

  private

  def prediction_params
    params.require(:prediction).permit(
      :name,
      ranking_items_attributes: [:id, :color_code, :rank, :_destroy]
    )
  end
end