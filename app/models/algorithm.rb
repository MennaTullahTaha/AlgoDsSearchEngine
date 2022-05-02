class Algorithm < ApplicationRecord
    validates :title, presence: true
    validates :time_complexity, presence: true
    validates :url, presence: true
end