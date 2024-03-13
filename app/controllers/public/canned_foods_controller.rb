class Public::CannedFoodsController < ApplicationController
  def index
  end

  def search
  end

  def show
    @canned_food = CannedFood.find(params[:id])
    @tags = @canned_food.tags
    @member = Member.find(current_member.id)
    
    # 新規レビュー作成用
    @review = @canned_food.reviews.build
    
    # 各レビューの平均値算出
    @expiry_date_avg = @canned_food.reviews.average(:expiry_date_rating) || 0
    @taste_avg = @canned_food.reviews.average(:taste_rating) || 0
    @snack_avg = @canned_food.reviews.average(:snack_rating) || 0
    @outdoor_avg = @canned_food.reviews.average(:outdoor_rating) || 0
  end
end
