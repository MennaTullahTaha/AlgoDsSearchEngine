# frozen_string_literal: true

class FavouritePost < ApplicationRecord
  belongs_to :post
  belongs_to :user
end
