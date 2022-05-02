class CreateDatastructures < ActiveRecord::Migration[5.2]
  def change
    create_table :datastructures do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end
