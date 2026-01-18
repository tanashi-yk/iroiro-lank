class CreateRankingItems < ActiveRecord::Migration[7.2]
  def change
    create_table :ranking_items do |t|
      t.references :prediction, null: false, foreign_key: true
      t.string :color_code
      t.integer :rank

      t.timestamps
    end
  end
end
