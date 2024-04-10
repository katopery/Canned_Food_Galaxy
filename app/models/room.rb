class Room < ApplicationRecord
  has_many :entries, dependent: :destroy  # DM機能用の情報との関連付け
  has_many :messages, dependent: :destroy # DM機能用のメッセージとの関連付け
end
