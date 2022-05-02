class Post < ApplicationRecord
    validates :title, presence: true, length: {minimum: 6, maximum: 200}
    validates :body, presence: true, length: {minimum: 50, maximum:1000}
    belongs_to :user, dependent: :destroy

end