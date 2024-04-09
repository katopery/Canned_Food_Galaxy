class Room < ApplicationRecord
  has_many :entries, dependent: :destroy  # メッセージ機能用の情報との関連付け
  has_many :messages, dependent: :destroy # メッセージ機能用のメッセージとの関連付け
end
