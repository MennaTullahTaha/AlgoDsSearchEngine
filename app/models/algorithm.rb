# frozen_string_literal: true

class Algorithm < ApplicationRecord
  include PgSearch::Model
  validates :title, presence: true
  validates :time_complexity, presence: true
  validates :url, presence: true
  has_many :posts, dependent: :destroy
  has_many :favourite_algorithms, dependent: :destroy
  has_many :favourites, through: :favourite_algorithms, source: :user
  pg_search_scope :search,
                  against: { title: 'B', time_complexity: 'A' },
                  using: { tsearch: { dictionary: 'english', tsvector_column: 'searchable' } }
end
