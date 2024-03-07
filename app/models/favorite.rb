class Favorite < ApplicationRecord
  belongs_to :member      # 会員に所属
  belongs_to :canned_food # 缶詰に所属
end
