class Comment < ApplicationRecord
  belongs_to :member  # 会員に所属
  belongs_to :review  # レビューに所属
end
