class CreatePredictions < ActiveRecord::Migration[7.1]
  def change
    create_table :predictions do |t|
      t.references :event, null: false, foreign_key: true
      t.string :name
      t.jsonb :colors, default: []

      t.timestamps
    end
  end
end