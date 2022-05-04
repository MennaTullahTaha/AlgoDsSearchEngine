# frozen_string_literal: true

class FavouriteDatastructure < ApplicationRecord
  belongs_to :datastructure
  belongs_to :user
end
