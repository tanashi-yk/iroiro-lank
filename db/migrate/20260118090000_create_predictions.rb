class CreatePredictions < ActiveRecord::Migration[7.2]
  def change
    create_table :predictions do |t|
      t.references :competition, null: false, foreign_key: true
      t.timestamps
    end
  end
end
