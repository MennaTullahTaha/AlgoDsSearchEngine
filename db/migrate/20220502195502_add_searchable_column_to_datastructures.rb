class AddSearchableColumnToDatastructures < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
    ALTER TABLE datastructures
      ADD COLUMN searchable tsvector GENERATED ALWAYS AS (
      setweight(to_tsvector('english', coalesce(title, '')), 'B') ||
      setweight(to_tsvector('english', coalesce(content,'')), 'A')
      ) STORED;
      SQL
    end
    
    def down
      remove_column :datastructures, :searchable
    end
end
