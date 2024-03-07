class CannedFood < ApplicationRecord
  has_many :reviews, dependent: :destroy      # レビューとの関連付け
  has_many :favorites, dependent: :destroy    # お気に入りとの関連付け
  has_many :canned_tags, dependent: :destroy  # 缶詰タグとの関連付け
  
end
