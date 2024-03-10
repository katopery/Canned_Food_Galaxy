class CannedFood < ApplicationRecord
  has_many :reviews, dependent: :destroy      # レビューとの関連付け
  has_many :favorites, dependent: :destroy    # お気に入りとの関連付け
  has_many :canned_tags, dependent: :destroy  # 缶詰タグとの関連付け
  has_many :tags, through: :canned_tags       # タグとの関連付け
  
  has_one_attached :image  # 缶詰の画像用
  
  validates :canned_name, presence: true
  validates :description, presence: true
  validates :image, presence: true
  validates :is_canned_status, inclusion: { in: [true, false] }
end
