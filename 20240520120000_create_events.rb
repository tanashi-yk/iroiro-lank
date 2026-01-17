class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.jsonb :correct_colors, default: []

      t.timestamps
    end
  end
end