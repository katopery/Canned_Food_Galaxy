class Public::CannedFoodsController < ApplicationController
  before_action :authenticate_member!

  def index
    # 有効な缶詰を取得
    @canned_foods = CannedFood.where(is_canned_status: true)
    
    # 評価項目ごとに絞り込みを行う
    rating_params = [:expiry_date_rating, :taste_rating, :snack_rating, :outdoor_rating]
    rating_params.each do |param|
      # 評価項目のパラメータが指定されているか確認
      next unless params[param]
      avg_column = "avg(reviews.#{param})"
      # 平均値が指定された評価値以上のものを選択する
      ids = CannedFood.left_joins(:reviews)
                      .group(:id)
                      .having("#{avg_column} >= ?", params[param].to_f)
                      .pluck(:id)
      @canned_foods = @canned_foods.where(id: ids)
    end
  
    # 評価順にソートする場合の処理
    if params[:sort_review]
      @canned_foods = @canned_foods.left_joins(:reviews)
                                    .group(:id)
                                    .order("avg(reviews.#{params[:sort_review]}) desc")
    end
  
    # デフォルトは10件ずつ表示し、ページネーションを適用
    @canned_foods = @canned_foods.page(params[:page]).per(10)
  
    # ビュー側で表示するための評価項目ごとの値を保持
    set_rating_params
  end

  def show
    @canned_food = CannedFood.find(params[:id])
    @tags = @canned_food.tags

    if current_member
      # 会員がログインしている場合
      @member = Member.find(current_member.id)
      @review = Review.find_by(member_id: current_member.id, canned_food_id: params[:id])
    else
      # 会員がログインしていない場合
      @member = nil
    end

    # 新規レビュー作成用
    if @review == nil
      @review = @canned_food.reviews.build
    end

    # 缶詰の表示ステータスがtrueではない場合、詳細画面に遷移できないようにする
    if @canned_food.is_canned_status != true
      redirect_to canned_foods_path, alert: 'この缶詰は表示できません'
      return
    end
  end

  def search
    # 検索ワードを取得し、缶詰表示ステータスが有効な缶詰を取得
    @word = params[:word]
    @canned_foods = CannedFood.where(is_canned_status: true).looks(@word)

    if params[:sort_review]
      # 各評価項目ごとの降順表示の処理
      @canned_foods = @canned_foods.left_joins(:reviews)
                                    .group(:id)
                                    .order("avg(reviews.#{params[:sort_review]}) desc")
    end

    # 各評価項目ごとに絞り込みを行う
    rating_params = [:expiry_date_rating, :taste_rating, :snack_rating, :outdoor_rating]
    rating_params.each do |param|
      # 評価項目のパラメータが指定されているか確認
      next unless params[param]
      avg_column = "avg(reviews.#{param})"
      # 平均値が指定された評価値以上のものを選択する
      ids = CannedFood.left_joins(:reviews)
                      .group(:id)
                      .having("#{avg_column} >= ?", params[param].to_f)
                      .pluck(:id)
      @canned_foods = @canned_foods.where(id: ids)
    end
    
    @canned_foods = @canned_foods.page(params[:page]).per(10)

    # ビュー側で表示するための評価項目ごとの値を保持
    set_rating_params
  end

  def search_tag
    # タグIDが存在しているかチェック
    if params[:tag_id].present?
      # 検索されたタグを受け取る
      @tag = Tag.find(params[:tag_id])
      # 検索されたタグに関連付けられたCannedTagを取得
      @canned_tags = @tag.canned_tags.joins(:canned_food).where("canned_foods.is_canned_status = ?", true).page(params[:page]).per(10)
      # 検索されたタグに関連付けられたCannedFoodを取得
      @canned_foods = @canned_tags.map(&:canned_food)
    else
      # タグIDが指定されていない場合、タグIDをnilとして処理をする
      @tag = nil
      @canned_tags = Kaminari.paginate_array([]).page(params[:page]).per(10)
      @canned_foods = []
    end
  end

  private

  # ビュー側で表示するための評価項目ごとの値を保持
  def set_rating_params
    @expiry_date_rating = params[:expiry_date_rating]
    @taste_rating = params[:taste_rating]
    @snack_rating = params[:snack_rating]
    @outdoor_rating = params[:outdoor_rating]
  end
end
