class Entry < ApplicationRecord
  belongs_to :member  # 会員に所属
  belongs_to :room    # ルームに所属
end
