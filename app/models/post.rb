# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 6, maximum: 200 }
  validates :body, presence: true, length: { minimum: 50, maximum: 1000 }
  belongs_to :user
  belongs_to :algorithm, optional: true
  belongs_to :datastructure, optional: true
  has_many :comments, dependent: :destroy
  has_many :favourite_posts, dependent: :destroy
  has_many :favourites, through: :favourite_posts, source: :user
end
