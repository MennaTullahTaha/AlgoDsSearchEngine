class Datastructure < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    validates :url, presence: true
end