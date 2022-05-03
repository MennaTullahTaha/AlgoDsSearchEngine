class Algorithm < ApplicationRecord
    include PgSearch::Model
    validates :title, presence: true
    validates :time_complexity, presence: true
    validates :url, presence: true
    has_many :posts
    pg_search_scope :search,
                  against: { title: 'B', time_complexity: 'A' },
                  using: { tsearch: { dictionary: 'english',tsvector_column: 'searchable'} }
end