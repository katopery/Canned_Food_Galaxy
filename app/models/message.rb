class Message < ApplicationRecord
  belongs_to :member  # 会員に所属
  belongs_to :room    # ルームに所属

  validates :content, presence: true, length: { in: 1..100 }
end
