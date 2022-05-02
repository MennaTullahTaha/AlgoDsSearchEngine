class Datastructure < ApplicationRecord
    include PgSearch::Model
    validates :title, presence: true
    validates :content, presence: true
    validates :url, presence: true
    
    pg_search_scope :search,
                  against: { title: 'B', content: 'A' },
                  using: { tsearch: { dictionary: 'english', tsvector_column: 'searchable'} }
end