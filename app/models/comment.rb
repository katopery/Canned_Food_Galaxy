class Comment < ApplicationRecord
  belongs_to :member  # 会員に所属
  belongs_to :review  # レビューに所属
  
  has_one_attached :image
  def get_image(width, height)
    if image.attached?
      image.variant(resize_to_limit: [width,height]).processed
    end
  end
  
  validates :content, presence: true
end
