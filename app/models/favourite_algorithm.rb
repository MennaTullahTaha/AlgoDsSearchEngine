# frozen_string_literal: true

class FavouriteAlgorithm < ApplicationRecord
  belongs_to :algorithm
  belongs_to :user
end
