class AddIndexToSearchableDatastructures < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :datastructures, :searchable, using: :gin, algorithm: :concurrently
  end
end
