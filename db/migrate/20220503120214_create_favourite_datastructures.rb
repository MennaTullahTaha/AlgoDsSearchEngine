class CreateFavouriteDatastructures < ActiveRecord::Migration[5.2]
  def change
    create_table :favourite_datastructures do |t|
      t.integer :user_id
      t.integer :datastructure_id
      t.timestamps
    end
  end
end
