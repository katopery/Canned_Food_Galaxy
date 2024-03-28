class Tag < ApplicationRecord
  has_many :canned_tags, dependent: :destroy    # 缶詰タグとの関連付け
  has_many :canned_foods, through: :canned_tags # 缶詰との関連付け
end
