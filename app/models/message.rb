class Message < ApplicationRecord
  belongs_to :member  # 会員に所属
  belongs_to :room    # ルームに所属
  
  validates :content, presence: true, length: { maximum: 100 }
end
