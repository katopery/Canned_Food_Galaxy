class Review < ApplicationRecord
  belongs_to :member      # 会員に所属
  belongs_to :canned_food # 缶詰に所属

  has_many :comments, dependent: :destroy # コメントとの関連付け

  validates :expiry_date_rating, numericality: { in: 1..5 }
  validates :taste_rating, numericality: { in: 1..5 }
  validates :snack_rating, numericality: { in: 1..5 }
  validates :outdoor_rating, numericality: { in: 1..5 }
end
