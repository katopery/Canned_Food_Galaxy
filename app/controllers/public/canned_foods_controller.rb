class Public::CannedFoodsController < ApplicationController
  def index
    @canned_foods = CannedFood.order(created_at: :desc).page(params[:page]).per(10)
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

  def search
    @word = params[:word]
    @search = params[:search]
    @range = params[:range]

    # 検索された缶詰に関連付けられたCannedFoodを取得
    if @range == "缶詰"
      @canned_foods = CannedFood.looks(@search, @word).page(params[:page]).per(10)
    end
  end
  
  def search_tag
    # 検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    # 検索されたタグに関連付けられたCannedTagを取得
    @canned_tags = @tag.canned_tags.page(params[:page]).per(10)
    # 検索されたタグに関連付けられたCannedFoodを取得
    @canned_foods = @canned_tags.map(&:canned_food)
  end
end
