class AddAnswerColorsToCompetitions < ActiveRecord::Migration[7.2]
  def change
    add_column :competitions, :answer_colors, :text
  end
end
