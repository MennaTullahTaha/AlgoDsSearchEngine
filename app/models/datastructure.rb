# frozen_string_literal: true

class Datastructure < ApplicationRecord
  include PgSearch::Model
  validates :title, presence: true
  validates :content, presence: true
  validates :url, presence: true
  has_many :posts, dependent: :destroy
  has_many :favourite_datastructures, dependent: :destroy
  has_many :favourites, through: :favourite_datastructures, source: :user
  pg_search_scope :search,
                  against: { title: 'B', content: 'A' },
                  using: { tsearch: { dictionary: 'english', tsvector_column: 'searchable' } }
end
