class AddForeignKeysToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :algorithm_id, :int
    add_column :posts, :datastructure_id, :int
  end
end
