class CreateFavouriteAlgorithms < ActiveRecord::Migration[5.2]
  def change
    create_table :favourite_algorithms do |t|
      t.integer :user_id
      t.integer :algorithm_id
      t.timestamps
    end
  end
end
