class AddSearchableColumnToAlgorithms < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
    ALTER TABLE algorithms
      ADD COLUMN searchable tsvector GENERATED ALWAYS AS (
      setweight(to_tsvector('english', coalesce(title, '')), 'B') ||
      setweight(to_tsvector('english', coalesce(time_complexity,'')), 'A')
      ) STORED;
      SQL
    end
    
    def down
      remove_column :algorithms, :searchable
    end
end

