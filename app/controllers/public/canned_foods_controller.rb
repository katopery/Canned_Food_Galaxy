class Public::CannedFoodsController < ApplicationController
  def index
    @canned_foods = CannedFood.page(params[:page]).per(10)
  end

  def search
  end

  def show
    @canned_food = CannedFood.find(params[:id])
    @tags = @canned_food.tags
    
    # 各レビューの平均値算出
    @expiry_date_avg = @canned_food.reviews.average(:expiry_date_rating) || 0
    @taste_avg = @canned_food.reviews.average(:taste_rating) || 0
    @snack_avg = @canned_food.reviews.average(:snack_rating) || 0
    @outdoor_avg = @canned_food.reviews.average(:outdoor_rating) || 0
    

    if current_member
      # 会員がログインしている場合
      @member = Member.find(current_member.id)
      @review = Review.find_by(member_id: current_member.id, canned_food_id: params[:id])
    else
      # 会員がログインしていない場合
      @member = nil
    end

    if @review == nil
       # 新規レビュー作成用
      @review = @canned_food.reviews.build
    end
  end
end
