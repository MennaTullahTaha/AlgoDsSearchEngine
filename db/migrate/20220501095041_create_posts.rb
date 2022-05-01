class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false, index: {unique: true}
      t.text :body, null: false, index: {unique: true}
    end
  end
end
