class CreateAlgorithms < ActiveRecord::Migration[5.2]
  def change
    create_table :algorithms do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.text :time_complexity, null: false
      t.timestamps
    end
  end
end
