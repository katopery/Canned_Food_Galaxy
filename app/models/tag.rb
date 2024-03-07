class Tag < ApplicationRecord
  has_many :canned_tags, dependent: :destroy  # 缶詰タグとの関連付け
end
