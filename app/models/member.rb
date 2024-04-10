class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy    # レビューとの関連付け
  has_many :comments, dependent: :destroy   # コメントとの関連付け

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy     # フォローしている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy  # フォローされている関連付け
  has_many :followings, through: :active_relationships, source: :followed   # フォローしている会員を取得
  has_many :followers, through: :passive_relationships, source: :follower   # フォロワーを取得
  
  has_many :favorites, dependent: :destroy  # お気に入りとの関連付け
  has_many :favorite_canned_foods, through: :favorites, source: :canned_food  # お気に入りに関連するすべての缶詰
  
  has_many :entries, dependent: :destroy  # DM機能用の情報との関連付け
  has_many :messages, dependent: :destroy # DM機能用のメッセージとの関連付け


  # 会員の画像用
  has_one_attached :image 
  # 会員のプロフィール画像取得
  def get_profile_image(width, height)
    unless image.attached?
      # デフォルトの画像を設定する
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    # 指定した幅と高さにリサイズした画像を返す
    image.variant(resize_to_limit: [width,height]).processed
  end

  # 指定した会員をフォローする
  def follow(member)
    active_relationships.create(followed_id: member.id)
  end
  # 指定した会員のフォローを解除する
  def unfollow(member)
    active_relationships.find_by(followed_id: member.id).destroy
  end
  # 指定した会員をフォローしているかどうかを判定
  def following?(member)
    followings.include?(member)
  end
  
  # お気に入りに追加する
  def favorite(canned_food)
  	favorite_canned_foods << canned_food
  end
  # お気に入りを外す
  def unfavorite(canned_food)
  	favorite_canned_foods.destroy(canned_food)
  end
  # お気に入りにしているか判定する
  def favorite?(canned_food)
    favorite_canned_foods.include?(canned_food)
  end
  
  # 検索機能用
  def self.looks(search, word)
    if search == "partial"
      @member = Member.where("nickname LIKE?","%#{word}%")
    end
  end

  # ゲスト会員用メールアドレス
  GUEST_MEMBER_EMAIL = 'guest@example.com'
  # ゲスト会員用情報取得
  def self.guest
    find_or_create_by!(email: GUEST_MEMBER_EMAIL) do |member|
      member.password = SecureRandom.urlsafe_base64
      member.nickname = "ゲスト"
      member.phone_number = "XXXXXXXXXXX"
    end
  end
  # ゲスト会員の判定
  def guest_member?
    email == GUEST_MEMBER_EMAIL
  end

  validates :nickname, uniqueness: true, presence: true, length: { in: 1..12 }
  validates :phone_number, presence: true, length: { in: 10..11 }
  devise :validatable, password_length: 6..32
end
