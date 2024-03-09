class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy    # レビューとの関連付け
  has_many :comments, dependent: :destroy   # コメントとの関連付け
  has_many :favorites, dependent: :destroy  # お気に入りとの関連付け

  has_many :active_relationships, class_name: "Relationship", foreign_key: "member_id", dependent: :destroy     # フォローしている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy  # フォローされている関連付け

  has_many :followings, through: :active_relationships, source: :followed   # フォローしている会員を取得
  has_many :followers, through: :passive_relationships, source: :follower   # フォロワーを取得

  has_one_attached :image  # 会員の画像用

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
  
  # ゲスト会員
  GUEST_MEMBER_EMAIL = 'guest@example.com'
  def self.guest
    find_or_create_by!(email: GUEST_MEMBER_EMAIL) do |member|
      member.password = SecureRandom.urlsafe_base64
      member.nickname = "ゲスト"
      member.phone_number = "XXXXXXXXXXX"
    end
  end

  validates :nickname, uniqueness: true, presence: true, length: { in: 1..12 }
  validates :phone_number, presence: true
end
