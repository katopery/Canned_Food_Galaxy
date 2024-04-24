class CannedFood < ApplicationRecord
  has_many :reviews, dependent: :destroy      # レビューとの関連付け
  has_many :favorites, dependent: :destroy    # お気に入りとの関連付け
  has_many :canned_tags, dependent: :destroy  # 缶詰タグとの関連付け
  has_many :tags, through: :canned_tags       # タグとの関連付け

  # 缶詰の画像用
  has_one_attached :image
  # 缶詰画像取得
  def get_image(width, height)
    unless image.attached?
      # デフォルトの画像を設定する
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    # 指定した幅と高さにリサイズした画像を返す
    image.variant(resize_to_limit: [width,height]).processed
  end
  
  # 検索機能用
  def self.looks(word)
      @canned_food = CannedFood.where("canned_name LIKE?","%#{word}%")
  end

  validates :canned_name, presence: true
  validates :description, presence: true
  validates :image, presence: true
  validates :is_canned_status, inclusion: { in: [true, false] }
end
