# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :body, presence: true, length: { minimum: 10, maximum: 500 }
  belongs_to :user
  belongs_to :post
end
