class PredictionsController < ApplicationController
  def index
    @predictions = Prediction.all
  end

  def new
    @prediction = Prediction.new
    # 6枠分の入力枠を準備
    6.times { @prediction.ranking_items.build }
  end

  def create
    @prediction = Prediction.new(prediction_params)
    @prediction.competition = Competition.first || Competition.create!(name: "第1回大会")

    if @prediction.save
      redirect_to "/predictions", notice: "予想を保存しました！"
    else
      Rails.logger.error "【保存失敗】: #{@prediction.errors.full_messages}"
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
    # :name とランキング項目の両方を許可
    params.require(:prediction).permit(
      :name,
      ranking_items_attributes: [:id, :color_code, :rank, :_destroy]
    )
  end
end