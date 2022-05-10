# frozen_string_literal: true

class User < ApplicationRecord
  before_save { self.email = email.downcase }

  has_secure_password

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favourite_posts, dependent: :destroy
  has_many :saved_posts, through: :favourite_posts, source: :post
  has_many :favourite_datastructures, dependent: :destroy
  has_many :saved_datastructures, through: :favourite_datastructures, source: :datastructure
  has_many :favourite_algorithms, dependent: :destroy
  has_many :saved_algorithms, through: :favourite_algorithms, source: :algorithm
end
