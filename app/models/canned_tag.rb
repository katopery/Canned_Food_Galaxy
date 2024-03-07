class CannedTag < ApplicationRecord
  belongs_to :canned_food # 缶詰に所属
  belongs_to :tag         # タグに所属
end
