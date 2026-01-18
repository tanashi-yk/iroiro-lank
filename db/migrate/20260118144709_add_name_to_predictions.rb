class AddNameToPredictions < ActiveRecord::Migration[7.2]
  def change
    add_column :predictions, :name, :string
  end
end
